Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVCEVft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVCEVft (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCEVfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:35:48 -0500
Received: from mailfe01.swip.net ([212.247.154.1]:41413 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261194AbVCEVfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:35:42 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: dm-crypt vs. cryptoloop reminder
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Sat, 05 Mar 2005 22:35:24 +0100
Message-Id: <1110058524.13821.17.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.3-mm1 'dm-crypt vs. cryptoloop' discussion was some time ago, it is
time to bring this up again:
http://kerneltrap.org/node/2433

I'm no cryptanalyst, but googling a bit shows a bunch of problems with
it (also see above thread), there is no maintainer and most importantly
there is a replacement for it that has active maintainers. Redundant
security solutions is a risky thing to me.



===== Documentation/feature-removal-schedule.txt 1.4 vs edited =====
--- 1.4/Documentation/feature-removal-schedule.txt	2005-01-14 22:22:44 +01:00
+++ edited/Documentation/feature-removal-schedule.txt	2005-03-05 22:13:12 +01:00
@@ -15,3 +15,10 @@ Why:	It has been unmaintained for a numb
 	against the LSB, and can be replaced by using udev.
 Who:	Greg Kroah-Hartman <greg@kroah.com>
 
+
+What:	cryptoloop
+When:	July 2005
+Files:	drivers/block/cryptoloop.c and parts of drivers/block/loop.c
+Why:	Unmaintained, has vulnerabilities that haven't been fixed.
+	Superseded by dm-crypt that has been in mainline for a long time 
+	now: http://www.saout.de/misc/dm-crypt/



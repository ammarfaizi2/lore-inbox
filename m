Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWFBU1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWFBU1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWFBU1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:27:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:5331 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932561AbWFBU1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:27:30 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:25:45 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 16/18] Update feature removal of obsolete
 raw1394 ISO requests.
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
Message-ID: <tkrat.96e1b392429fe277@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
 <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
 <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.885) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jody McIntyre <scjody@modernduck.com>

Index: linux-2.6.17-rc5-mm2/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.17-rc5-mm2.orig/Documentation/feature-removal-schedule.txt	2006-06-01 20:55:03.000000000 +0200
+++ linux-2.6.17-rc5-mm2/Documentation/feature-removal-schedule.txt	2006-06-01 20:55:48.000000000 +0200
@@ -34,11 +34,11 @@ Who:	Adrian Bunk <bunk@stusta.de>
 ---------------------------
 
 What:	raw1394: requests of type RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN
-When:	November 2005
+When:	November 2006
 Why:	Deprecated in favour of the new ioctl-based rawiso interface, which is
 	more efficient.  You should really be using libraw1394 for raw1394
 	access anyway.
-Who:	Jody McIntyre <scjody@steamballoon.com>
+Who:	Jody McIntyre <scjody@modernduck.com>
 
 ---------------------------
 



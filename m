Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVAXKVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVAXKVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVAXKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:21:18 -0500
Received: from smartmx-03.inode.at ([213.229.60.35]:18836 "EHLO
	smartmx-03.inode.at") by vger.kernel.org with ESMTP id S261477AbVAXKVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:21:09 -0500
Message-ID: <41F4CC12.8080309@acousta.at>
Date: Mon, 24 Jan 2005 11:21:06 +0100
From: Bernhard Schauer <schauer@acousta.at>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ioctl() Syscall number assignment
Content-Type: multipart/mixed;
 boundary="------------060109000102020304030904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060109000102020304030904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'd like to "register" some ioctl numbers for driver development. 
Attached is a patch for ioctl-numbers.txt, as requested in the same file.

regards

Bernhard Schauer

--------------060109000102020304030904
Content-Type: text/plain;
 name="acousta_ioctl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acousta_ioctl.patch"

diff -ur ./linux-2.6.10-org/Documentation/ioctl-number.txt ./linux-2.6.10/Documentation/ioctl-number.txt
--- ./linux-2.6.10-org/Documentation/ioctl-number.txt	2005-01-21 11:53:29.000000000 +0100
+++ ./linux-2.6.10/Documentation/ioctl-number.txt	2005-01-21 11:55:34.000000000 +0100
@@ -181,6 +181,8 @@
 0xA3	90-9F	linux/dtlk.h
 0xAB	00-1F	linux/nbd.h
 0xAC	00-1F	linux/raw.h
+0xAC	A0-BF	ACOUSTA Electronic	in development:
+					<mailto:schauer@acousta.at>
 0xAD	00	Netfilter device	in development:
 					<mailto:rusty@rustcorp.com.au>	
 0xB0	all	RATIO devices		in development:

--------------060109000102020304030904--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbTCIONH>; Sun, 9 Mar 2003 09:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbTCIONG>; Sun, 9 Mar 2003 09:13:06 -0500
Received: from CPE-144-132-194-153.nsw.bigpond.net.au ([144.132.194.153]:17799
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S262513AbTCIONF>; Sun, 9 Mar 2003 09:13:05 -0500
Date: Sun, 9 Mar 2003 22:18:17 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add missing module license to ipfwadm_core.c
Message-ID: <20030309141817.GA8987@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


Since vger seems to have eaten some mail over the weekend, I thought
maybe I should resend this.

This adds a missing module license to ipfwadm_core.c to prevent it
from tainting the kernel when loaded in as a module.

Please apply.

Thanks,

	-- Geoff.

-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="ifwadm_core.c.diff"

--- linux-2.4.20/net/ipv4/netfilter/ipfwadm_core.c.orig	2002-03-23 17:30:07.000000000 +0800
+++ linux-2.4.20/net/ipv4/netfilter/ipfwadm_core.c	2003-03-08 14:40:01.000000000 +0800
@@ -130,6 +130,8 @@
 #include <linux/stat.h>
 #include <linux/version.h>
 
+MODULE_LICENSE("Dual BSD/GPL");
+
 /*
  *	Implement IP packet firewall
  */

--2fHTh5uZTiUOsy+g--

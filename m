Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVAPB1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVAPB1h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVAPB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 20:27:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:48783 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262374AbVAPB1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 20:27:34 -0500
Message-ID: <41E9C14D.9010806@osdl.org>
Date: Sat, 15 Jan 2005 17:20:13 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: [PATCH] x86_64: update defconfig
Content-Type: multipart/mixed;
 boundary="------------050701050107070702050808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050701050107070702050808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I suggest that we do a little defconfig module trimming.

Reduce number of modules built via defconfig.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  arch/x86_64/defconfig |    2 +-
  1 files changed, 1 insertion(+), 1 deletion(-)
---

--------------050701050107070702050808
Content-Type: text/x-patch;
 name="defconfig_x8664.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="defconfig_x8664.patch"


Reduce number of modules built via defconfig.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/x86_64/defconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/x86_64/defconfig~xdefcfg ./arch/x86_64/defconfig
--- ./arch/x86_64/defconfig~xdefcfg	2005-01-15 16:13:04.568830640 -0800
+++ ./arch/x86_64/defconfig	2005-01-15 16:49:41.908784192 -0800
@@ -543,7 +543,7 @@ CONFIG_TIGON3=y
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
-CONFIG_S2IO=m
+# CONFIG_S2IO is not set
 # CONFIG_S2IO_NAPI is not set
 # CONFIG_2BUFF_MODE is not set
 

--------------050701050107070702050808--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbTCIECH>; Sat, 8 Mar 2003 23:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262391AbTCIECH>; Sat, 8 Mar 2003 23:02:07 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:36736 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262389AbTCIECC>; Sat, 8 Mar 2003 23:02:02 -0500
Date: Sun, 9 Mar 2003 13:12:08 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (1/20) boot98 update
Message-ID: <20030309041208.GB1231@yuzuki.cinet.co.jp>
References: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309035245.GA1231@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.64-ac3. (1/20)

Updates for files under arch/i386/boot98 directory.

Regards,
Osamu Tomita

diff -Nru linux-2.5.64-ac1/arch/i386/boot98/Makefile linux98-2.5.64-ac1/arch/i386/boot98/Makefile
--- linux-2.5.64-ac1/arch/i386/boot98/Makefile	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.64-ac1/arch/i386/boot98/Makefile	2003-03-05 13:23:00.000000000 +0900
@@ -32,10 +32,6 @@
 
 host-progs	:= tools/build
 
-# 	Default
-
-boot: bzImage
-
 # ---------------------------------------------------------------------------
 
 $(obj)/zImage:  IMAGE_OFFSET := 0x1000

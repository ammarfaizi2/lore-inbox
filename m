Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbUK3CDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUK3CDB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUK3CBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:01:33 -0500
Received: from baikonur.stro.at ([213.239.196.228]:61346 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261823AbUK3B5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:57:25 -0500
Subject: [patch 05/11] Subject: ifdef typos: arch_sh_boards_renesas_hs7751rvoip_io.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org,
       rddunlap@osdl.org
From: janitor@sternwelten.at
Date: Tue, 30 Nov 2004 02:57:22 +0100
Message-ID: <E1CYxGc-0002nr-VQ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



CONFIG_HS7751RVOIP_CIDEC is mistyped.

Signed-off-by: Domen Puncer <domen@coderock.org>
Acked-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk13-max/arch/sh/boards/renesas/hs7751rvoip/io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/sh/boards/renesas/hs7751rvoip/io.c~ifdef-arch_sh_boards_renesas_hs7751rvoip_io arch/sh/boards/renesas/hs7751rvoip/io.c
--- linux-2.6.10-rc2-bk13/arch/sh/boards/renesas/hs7751rvoip/io.c~ifdef-arch_sh_boards_renesas_hs7751rvoip_io	2004-11-30 02:41:37.000000000 +0100
+++ linux-2.6.10-rc2-bk13-max/arch/sh/boards/renesas/hs7751rvoip/io.c	2004-11-30 02:41:37.000000000 +0100
@@ -166,7 +166,7 @@ void hs7751rvoip_outb(unsigned char valu
 
         if (PXSEG(port))
                 *(volatile unsigned char *)port = value;
-#if defined(CONFIG_HS7751RVOIP_CIDEC)
+#if defined(CONFIG_HS7751RVOIP_CODEC)
 	else if (codec_port(port))
 		*(volatile unsigned cjar *)((unsigned long)area6_io8_base+(port-CODEC_IO_BASE)) = value;
 #endif
@@ -180,7 +180,7 @@ void hs7751rvoip_outb_p(unsigned char va
 {
         if (PXSEG(port))
                 *(volatile unsigned char *)port = value;
-#if defined(CONFIG_HS7751RVOIP_CIDEC)
+#if defined(CONFIG_HS7751RVOIP_CODEC)
 	else if (codec_port(port))
 		*(volatile unsigned cjar *)((unsigned long)area6_io8_base+(port-CODEC_IO_BASE)) = value;
 #endif
_

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSCOLDn>; Fri, 15 Mar 2002 06:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSCOLC5>; Fri, 15 Mar 2002 06:02:57 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:46049 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S290713AbSCOLCN>; Fri, 15 Mar 2002 06:02:13 -0500
Date: Fri, 15 Mar 2002 12:01:52 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] BK ignore list
Message-ID: <20020315110152.GF13625@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch (send as a regular not a bk patch since for some
reason bitkeeper doesn't like changesets which modify files 
under BitKeeper/...) backports the exclusion patterns from
Linus' 2.5 BK repository.

With this patch, bk citool can really be used :-)

Stelian.

===== BitKeeper/etc/ignore 1.1 vs edited =====
--- 1.1/BitKeeper/etc/ignore	Tue Feb  5 18:30:56 2002
+++ edited/BitKeeper/etc/ignore	Fri Mar 15 11:42:52 2002
@@ -1,3 +1,47 @@
+*.[oas]
+.*.flags
+.config
+.config.old
+.depend
+.hdepend
+.version
 BitKeeper/*/*
-PENDING/*
 Desktop.ini
+PENDING/*
+System.map
+arch/alpha/boot/tools/objstrip
+arch/alpha/boot/vmlinux.gz
+arch/alpha/vmlinux.lds
+arch/i386/boot/bbootsect
+arch/i386/boot/bsetup
+arch/i386/boot/bzImage
+arch/i386/boot/compressed/bvmlinux
+arch/i386/boot/compressed/bvmlinux.out
+arch/i386/boot/tools/build
+drivers/char/conmakehash
+drivers/char/consolemap_deftbl.c
+drivers/net/hamradio/soundmodem/gentbl
+drivers/net/hamradio/soundmodem/sm_tbl_afsk1200.h
+drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_7.h
+drivers/net/hamradio/soundmodem/sm_tbl_afsk2400_8.h
+drivers/net/hamradio/soundmodem/sm_tbl_afsk2666.h
+drivers/net/hamradio/soundmodem/sm_tbl_fsk9600.h
+drivers/net/hamradio/soundmodem/sm_tbl_hapn4800.h
+drivers/net/hamradio/soundmodem/sm_tbl_psk4800.h
+drivers/pci/classlist.h
+drivers/pci/devlist.h
+drivers/pci/gen-devlist
+include/asm
+include/asm-alpha/asm_offsets.h
+include/config/*
+include/linux/autoconf.h
+include/linux/compile.h
+include/linux/modversions.h
+include/linux/version.h
+include/linux/modules/*
+scripts/kconfig.tk
+scripts/lxdialog/lxdialog
+scripts/mkdep
+scripts/split-include
+scripts/tkparse
+vmlinux
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

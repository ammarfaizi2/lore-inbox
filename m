Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUHMT62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUHMT62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUHMTz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:55:58 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:59180 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267168AbUHMTsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:48:41 -0400
Date: Fri, 13 Aug 2004 21:51:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [9/12] kbuild: Replace host-progs with hostprogs-y
Message-ID: <20040813195100.GI10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 21:42:56+02:00 sam@mars.ravnborg.org 
#   kbuild: Replace host-progs with hostprogs-y
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# usr/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# sound/oss/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# scripts/mod/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +2 -2
#   Replace host-progs with hostprogs-y
# 
# scripts/lxdialog/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +2 -2
#   Replace host-progs with hostprogs-y
# 
# scripts/kconfig/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# scripts/genksyms/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +2 -2
#   Replace host-progs with hostprogs-y
# 
# scripts/basic/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +2 -2
#   Replace host-progs with hostprogs-y
# 
# scripts/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -2
#   Replace host-progs with hostprogs-y
# 
# lib/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# drivers/zorro/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# drivers/pci/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# drivers/media/dvb/ttpci/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# drivers/md/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# drivers/atm/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# arch/x86_64/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# arch/um/sys-i386/util/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +2 -2
#   Replace host-progs with hostprogs-y
# 
# arch/sparc64/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# arch/sparc/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# arch/ppc64/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# arch/ppc/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +2 -2
#   Replace host-progs with hostprogs-y
# 
# arch/i386/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
# arch/alpha/boot/Makefile
#   2004/08/10 21:42:40+02:00 sam@mars.ravnborg.org +1 -1
#   Replace host-progs with hostprogs-y
# 
diff -Nru a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
--- a/arch/alpha/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/alpha/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -8,7 +8,7 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
-host-progs	:= tools/mkbb tools/objstrip
+hostprogs-y	:= tools/mkbb tools/objstrip
 targets		:= vmlinux.gz vmlinux \
 		   vmlinux.nh tools/lxboot tools/bootlx tools/bootph \
 		   tools/bootpzh bootloader bootpheader bootpzheader 
diff -Nru a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
--- a/arch/i386/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/i386/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -29,7 +29,7 @@
 		   zImage bzImage
 subdir- 	:= compressed
 
-host-progs	:= tools/build
+hostprogs-y	:= tools/build
 
 HOSTCFLAGS_build.o := $(LINUXINCLUDE)
 
diff -Nru a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
--- a/arch/ppc/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/ppc/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -23,12 +23,12 @@
 # for cleaning
 subdir-				+= simple openfirmware
 
-host-progs := $(addprefix utils/, addnote mknote hack-coff mkprep mkbugboot mktree)
+hostprogs-y := $(addprefix utils/, addnote mknote hack-coff mkprep mkbugboot mktree)
 
 .PHONY: $(BOOT_TARGETS) $(bootdir-y)
 
 $(BOOT_TARGETS): $(bootdir-y)
 
 $(bootdir-y): $(addprefix $(obj)/,$(subdir-y)) \
-		$(addprefix $(obj)/,$(host-progs))
+		$(addprefix $(obj)/,$(hostprogs-y))
 	$(Q)$(MAKE) $(build)=$(obj)/$@ $(MAKECMDGOALS)
diff -Nru a/arch/ppc64/boot/Makefile b/arch/ppc64/boot/Makefile
--- a/arch/ppc64/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/ppc64/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -58,7 +58,7 @@
 src-sec = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.c, $(section)))
 gz-sec  = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.gz, $(section)))
 
-host-progs		:= piggy addnote addSystemMap addRamDisk
+hostprogs-y		:= piggy addnote addSystemMap addRamDisk
 targets 		+= zImage zImage.initrd imagesize.c \
 			   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
 			   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
diff -Nru a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
--- a/arch/sparc/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/sparc/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -7,7 +7,7 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-host-progs	:= piggyback btfixupprep
+hostprogs-y	:= piggyback btfixupprep
 targets		:= tftpboot.img btfix.o btfix.S image
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
diff -Nru a/arch/sparc64/boot/Makefile b/arch/sparc64/boot/Makefile
--- a/arch/sparc64/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/sparc64/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -7,7 +7,7 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-host-progs	:= piggyback
+hostprogs-y	:= piggyback
 targets		:= image tftpboot.img vmlinux.aout
 
 quiet_cmd_elftoaout = ELF2AOUT $@
diff -Nru a/arch/um/sys-i386/util/Makefile b/arch/um/sys-i386/util/Makefile
--- a/arch/um/sys-i386/util/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/um/sys-i386/util/Makefile	2004-08-13 21:08:01 +02:00
@@ -1,6 +1,6 @@
 
-host-progs	:= mk_sc
-always		:= $(host-progs) mk_thread
+hostprogs-y	:= mk_sc
+always		:= $(hostprogs-y) mk_thread
 targets		:= mk_thread_kern.o mk_thread_user.o
 
 mk_sc-objs	:= mk_sc.o
diff -Nru a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
--- a/arch/x86_64/boot/Makefile	2004-08-13 21:08:01 +02:00
+++ b/arch/x86_64/boot/Makefile	2004-08-13 21:08:01 +02:00
@@ -30,7 +30,7 @@
 
 EXTRA_CFLAGS := -m32
 
-host-progs	:= tools/build
+hostprogs-y	:= tools/build
 subdir-		:= compressed/	#Let make clean descend in compressed/
 # ---------------------------------------------------------------------------
 
diff -Nru a/drivers/atm/Makefile b/drivers/atm/Makefile
--- a/drivers/atm/Makefile	2004-08-13 21:08:01 +02:00
+++ b/drivers/atm/Makefile	2004-08-13 21:08:01 +02:00
@@ -3,7 +3,7 @@
 #
 
 fore_200e-objs	:= fore200e.o
-host-progs	:= fore200e_mkfirm
+hostprogs-y	:= fore200e_mkfirm
 
 # Files generated that shall be removed upon make clean
 clean-files := atmsar11.bin atmsar11.bin1 atmsar11.bin2 pca200e.bin \
diff -Nru a/drivers/md/Makefile b/drivers/md/Makefile
--- a/drivers/md/Makefile	2004-08-13 21:08:01 +02:00
+++ b/drivers/md/Makefile	2004-08-13 21:08:01 +02:00
@@ -10,7 +10,7 @@
 		   raid6int1.o raid6int2.o raid6int4.o \
 		   raid6int8.o raid6int16.o raid6int32.o \
 		   raid6mmx.o raid6sse1.o raid6sse2.o
-host-progs	:= mktables
+hostprogs-y	:= mktables
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
diff -Nru a/drivers/media/dvb/ttpci/Makefile b/drivers/media/dvb/ttpci/Makefile
--- a/drivers/media/dvb/ttpci/Makefile	2004-08-13 21:08:01 +02:00
+++ b/drivers/media/dvb/ttpci/Makefile	2004-08-13 21:08:01 +02:00
@@ -13,7 +13,7 @@
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
 
-host-progs	:= fdump
+hostprogs-y	:= fdump
 
 ifdef CONFIG_DVB_AV7110_FIRMWARE
 $(obj)/av7110.o: $(obj)/fdump $(obj)/av7110_firm.h 
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2004-08-13 21:08:01 +02:00
+++ b/drivers/pci/Makefile	2004-08-13 21:08:01 +02:00
@@ -35,7 +35,7 @@
 obj-y += syscall.o
 endif
 
-host-progs := gen-devlist
+hostprogs-y := gen-devlist
 
 # Dependencies on generated files need to be listed explicitly
 $(obj)/names.o: $(obj)/devlist.h $(obj)/classlist.h
diff -Nru a/drivers/zorro/Makefile b/drivers/zorro/Makefile
--- a/drivers/zorro/Makefile	2004-08-13 21:08:01 +02:00
+++ b/drivers/zorro/Makefile	2004-08-13 21:08:01 +02:00
@@ -5,7 +5,7 @@
 obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o names.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 
-host-progs 		:= gen-devlist
+hostprogs-y 		:= gen-devlist
 
 # Files generated that shall be removed upon make clean
 clean-files := devlist.h
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2004-08-13 21:08:01 +02:00
+++ b/lib/Makefile	2004-08-13 21:08:01 +02:00
@@ -25,7 +25,7 @@
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 
-host-progs	:= gen_crc32table
+hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
 $(obj)/crc32.o: $(obj)/crc32table.h
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	2004-08-13 21:08:01 +02:00
+++ b/scripts/Makefile	2004-08-13 21:08:01 +02:00
@@ -13,8 +13,7 @@
 hostprogs-$(CONFIG_PROM_CONSOLE) += conmakehash
 hostprogs-$(CONFIG_IKCONFIG)     += bin2c
 
-host-progs	:= $(sort $(hostprogs-y))
-always		:= $(host-progs)
+always		:= $(hostprogs-y)
 
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_MODULES)     += mod
diff -Nru a/scripts/basic/Makefile b/scripts/basic/Makefile
--- a/scripts/basic/Makefile	2004-08-13 21:08:01 +02:00
+++ b/scripts/basic/Makefile	2004-08-13 21:08:01 +02:00
@@ -11,8 +11,8 @@
 #                include/config/...
 # docproc:	 Used in Documentation/docbook
 
-host-progs	:= fixdep split-include docproc
-always		:= $(host-progs)
+hostprogs-y	:= fixdep split-include docproc
+always		:= $(hostprogs-y)
 
 # fixdep is needed to compile other host programs
 $(addprefix $(obj)/,$(filter-out fixdep,$(always))): $(obj)/fixdep
diff -Nru a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
--- a/scripts/genksyms/Makefile	2004-08-13 21:08:01 +02:00
+++ b/scripts/genksyms/Makefile	2004-08-13 21:08:01 +02:00
@@ -1,6 +1,6 @@
 
-host-progs	:= genksyms
-always		:= $(host-progs)
+hostprogs-y	:= genksyms
+always		:= $(hostprogs-y)
 
 genksyms-objs	:= genksyms.o parse.o lex.o
 
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	2004-08-13 21:08:01 +02:00
+++ b/scripts/kconfig/Makefile	2004-08-13 21:08:01 +02:00
@@ -67,7 +67,7 @@
 
 libkconfig-objs := zconf.tab.o
 
-host-progs	:= conf mconf qconf gconf
+hostprogs-y	:= conf mconf qconf gconf
 conf-objs	:= conf.o  libkconfig.so
 mconf-objs	:= mconf.o libkconfig.so
 
diff -Nru a/scripts/lxdialog/Makefile b/scripts/lxdialog/Makefile
--- a/scripts/lxdialog/Makefile	2004-08-13 21:08:01 +02:00
+++ b/scripts/lxdialog/Makefile	2004-08-13 21:08:01 +02:00
@@ -15,8 +15,8 @@
 endif
 endif
 
-host-progs	:= lxdialog
-always		:= ncurses $(host-progs)
+hostprogs-y	:= lxdialog
+always		:= ncurses $(hostprogs-y)
 
 lxdialog-objs := checklist.o menubox.o textbox.o yesno.o inputbox.o \
 		 util.o lxdialog.o msgbox.o
diff -Nru a/scripts/mod/Makefile b/scripts/mod/Makefile
--- a/scripts/mod/Makefile	2004-08-13 21:08:01 +02:00
+++ b/scripts/mod/Makefile	2004-08-13 21:08:01 +02:00
@@ -1,5 +1,5 @@
-host-progs	:= modpost mk_elfconfig
-always		:= $(host-progs) empty.o
+hostprogs-y	:= modpost mk_elfconfig
+always		:= $(hostprogs-y) empty.o
 
 modpost-objs	:= modpost.o file2alias.o sumversion.o
 
diff -Nru a/sound/oss/Makefile b/sound/oss/Makefile
--- a/sound/oss/Makefile	2004-08-13 21:08:01 +02:00
+++ b/sound/oss/Makefile	2004-08-13 21:08:01 +02:00
@@ -103,7 +103,7 @@
 vidc_mod-objs	:= vidc.o vidc_fill.o
 wavefront-objs  := wavfront.o wf_midi.o yss225.o
 
-host-progs	:= bin2hex hex2hex
+hostprogs-y	:= bin2hex hex2hex
 
 # Files generated that shall be removed upon make clean
 clean-files := maui_boot.h msndperm.c msndinit.c pndsperm.c pndspini.c \
diff -Nru a/usr/Makefile b/usr/Makefile
--- a/usr/Makefile	2004-08-13 21:08:01 +02:00
+++ b/usr/Makefile	2004-08-13 21:08:01 +02:00
@@ -1,7 +1,7 @@
 
 obj-y := initramfs_data.o
 
-host-progs  := gen_init_cpio
+hostprogs-y  := gen_init_cpio
 
 clean-files := initramfs_data.cpio.gz
 

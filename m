Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUHOUSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUHOUSD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUHOUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:18:03 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:29241 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266876AbUHOUOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:14:49 -0400
Date: Sun, 15 Aug 2004 22:17:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild/all archs: Rename all *.lds.s to *.lds
Message-ID: <20040815201724.GC14133@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 20:21:00+02:00 sam@mars.ravnborg.org 
#   kbuild/all archs: Rename *.lds.s to *.lds
#   
#   For all architectures use the new name for linker definition scripts.
#   Based on patch from: Dan Aloni <da-x@colinux.org>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/x86_64/kernel/Makefile
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/x86_64/kernel/Makefile-HEAD
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/v850/kernel/Makefile
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/um/kernel/Makefile
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/um/Makefile
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +4 -4
#   Renamed *.lds.s to *.lds
# 
# arch/um/Makefile-skas
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sparc64/kernel/Makefile
#   2004/08/15 20:20:44+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sparc64/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sparc/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sparc/boot/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sh64/boot/compressed/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +3 -3
#   Renamed *.lds.s to *.lds
# 
# arch/sh/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sh/boot/compressed/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/sh/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/s390/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/ppc64/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/ppc/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/ppc/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/parisc/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/mips/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/mips/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/m68knommu/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/m68k/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/ia64/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +5 -5
#   Renamed *.lds.s to *.lds
# 
# arch/h8300/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/cris/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/cris/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/arm26/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/arm26/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/arm/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/arm/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
# arch/alpha/kernel/Makefile
#   2004/08/15 20:20:43+02:00 sam@mars.ravnborg.org +1 -1
#   Renamed *.lds.s to *.lds
# 
diff -Nru a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
--- a/arch/alpha/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/alpha/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o vmlinux.lds.s
+extra-y		:= head.o vmlinux.lds
 EXTRA_AFLAGS	:= $(CFLAGS)
 EXTRA_CFLAGS	:= -Werror -Wno-sign-compare
 
diff -Nru a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/arm/Makefile	2004-08-15 22:17:11 +02:00
@@ -9,7 +9,7 @@
 
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 LDFLAGS_BLOB	:=--format binary
-AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
+CPPFLAGS_vmlinux.lds = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
 #CFLAGS		+=-pipe
diff -Nru a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
--- a/arch/arm/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/arm/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -26,7 +26,7 @@
 head-y			:= head.o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
-extra-y := $(head-y) init_task.o vmlinux.lds.s
+extra-y := $(head-y) init_task.o vmlinux.lds
 
 # Spell out some dependencies that aren't automatically figured out
 $(obj)/entry-armv.o: 	$(obj)/entry-header.S include/asm-arm/constants.h
diff -Nru a/arch/arm26/Makefile b/arch/arm26/Makefile
--- a/arch/arm26/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/arm26/Makefile	2004-08-15 22:17:11 +02:00
@@ -9,7 +9,7 @@
 
 LDFLAGS_vmlinux	:=-p -X
 LDFLAGS_BLOB	:=--format binary
-AFLAGS_vmlinux.lds.o = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
+CPPFLAGS_vmlinux.lds = -DTEXTADDR=$(TEXTADDR) -DDATAADDR=$(DATAADDR)
 OBJCOPYFLAGS	:=-O binary -R .note -R .comment -S
 GZFLAGS		:=-9
 
diff -Nru a/arch/arm26/kernel/Makefile b/arch/arm26/kernel/Makefile
--- a/arch/arm26/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/arm26/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -14,5 +14,5 @@
 obj-$(CONFIG_FIQ)		+= fiq.o
 obj-$(CONFIG_MODULES)		+= armksyms.o
 
-extra-y := init_task.o vmlinux.lds.s
+extra-y := init_task.o vmlinux.lds
 
diff -Nru a/arch/cris/Makefile b/arch/cris/Makefile
--- a/arch/cris/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/cris/Makefile	2004-08-15 22:17:11 +02:00
@@ -29,7 +29,7 @@
 
 OBJCOPYFLAGS := -O binary -R .note -R .comment -S
 
-AFLAGS_vmlinux.lds.o = -DDRAM_VIRTUAL_BASE=0x$(CONFIG_ETRAX_DRAM_VIRTUAL_BASE)
+CPPFLAGS_vmlinux.lds = -DDRAM_VIRTUAL_BASE=0x$(CONFIG_ETRAX_DRAM_VIRTUAL_BASE)
 AFLAGS += -mlinux
 
 CFLAGS := $(CFLAGS) -mlinux -march=$(arch-y) -pipe
diff -Nru a/arch/cris/kernel/Makefile b/arch/cris/kernel/Makefile
--- a/arch/cris/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/cris/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -3,7 +3,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= vmlinux.lds.s
+extra-y	:= vmlinux.lds
 
 obj-y   := process.o traps.o irq.o ptrace.o setup.o \
 	   time.o sys_cris.o semaphore.o
diff -Nru a/arch/h8300/kernel/Makefile b/arch/h8300/kernel/Makefile
--- a/arch/h8300/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/h8300/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y := process.o traps.o ptrace.o ints.o \
 	 sys_h8300.o time.o semaphore.o signal.o \
diff -Nru a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
--- a/arch/ia64/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/ia64/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
@@ -21,25 +21,25 @@
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
 
-extra-y += gate.so gate-syms.o gate.lds.s gate.o
+extra-y := gate.so gate-syms.o gate.lds gate.o
 
 # fp_emulate() expects f2-f5,f16-f31 to contain the user-level state.
 CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
 
-AFLAGS_gate.lds.o += -P -C -U$(ARCH)
+CPPFLAGS_gate.lds := -P -C -U$(ARCH)
 
 quiet_cmd_gate = GATE $@
       cmd_gate = $(CC) -nostdlib $(GATECFLAGS_$(@F)) -Wl,-T,$(filter-out FORCE,$^) -o $@
 
 GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1
-$(obj)/gate.so: $(obj)/gate.lds.s $(obj)/gate.o FORCE
+$(obj)/gate.so: $(obj)/gate.lds $(obj)/gate.o FORCE
 	$(call if_changed,gate)
 
 $(obj)/built-in.o: $(obj)/gate-syms.o
 $(obj)/built-in.o: ld_flags += -R $(obj)/gate-syms.o
 
 GATECFLAGS_gate-syms.o = -r
-$(obj)/gate-syms.o: $(src)/gate.lds.s $(obj)/gate.o FORCE
+$(obj)/gate-syms.o: $(obj)/gate.lds $(obj)/gate.o FORCE
 	$(call if_changed,gate)
 
 # gate-data.o contains the gate DSO image as data in section .data.gate.
diff -Nru a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
--- a/arch/m68k/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/m68k/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -7,7 +7,7 @@
 else
   extra-y := sun3-head.o
 endif
-extra-y	+= vmlinux.lds.s
+extra-y	+= vmlinux.lds
 
 obj-y		:= entry.o process.o traps.o ints.o signal.o ptrace.o \
 			sys_m68k.o time.o semaphore.o setup.o m68k_ksyms.o
diff -Nru a/arch/m68knommu/kernel/Makefile b/arch/m68knommu/kernel/Makefile
--- a/arch/m68knommu/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/m68knommu/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for arch/m68knommu/kernel.
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y += dma.o entry.o init_task.o m68k_ksyms.o process.o ptrace.o semaphore.o \
 	 setup.o signal.o syscalltable.o sys_m68k.o time.o traps.o
diff -Nru a/arch/mips/Makefile b/arch/mips/Makefile
--- a/arch/mips/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/mips/Makefile	2004-08-15 22:17:11 +02:00
@@ -643,7 +643,7 @@
 # none has been choosen above.
 #
 
-AFLAGS_vmlinux.lds.o := \
+CPPFLAGS_vmlinux.lds := \
 	-D"LOADADDR=$(load-y)" \
 	-D"JIFFIES=$(JIFFIES)" \
 	-imacros $(srctree)/include/asm-$(ARCH)/sn/mapped_kernel.h
diff -Nru a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
--- a/arch/mips/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/mips/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the Linux/MIPS kernel.
 #
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
diff -Nru a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
--- a/arch/parisc/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/parisc/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -4,7 +4,7 @@
 
 head-y			:= head.o
 head-$(CONFIG_PARISC64)	:= head64.o
-extra-y			:= init_task.o $(head-y) vmlinux.lds.s
+extra-y			:= init_task.o $(head-y) vmlinux.lds
 
 AFLAGS_entry.o	:= -traditional
 AFLAGS_pacache.o := -traditional
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/ppc/Makefile	2004-08-15 22:17:11 +02:00
@@ -73,7 +73,7 @@
 
 all: zImage
 
-AFLAGS_vmlinux.lds.o	:= -Upowerpc
+CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
 # All the instructions talk about "make bzImage".
 bzImage: zImage
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/ppc/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -19,7 +19,7 @@
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-$(CONFIG_POWER4)		+= idle_power4.o
-extra-y				+= vmlinux.lds.s
+extra-y				+= vmlinux.lds
 
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
diff -Nru a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/ppc64/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -3,7 +3,7 @@
 #
 
 EXTRA_CFLAGS	+= -mno-minimal-toc
-extra-y		:= head.o vmlinux.lds.s
+extra-y		:= head.o vmlinux.lds
 
 obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
diff -Nru a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
--- a/arch/s390/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/s390/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -10,7 +10,7 @@
 
 extra-$(CONFIG_ARCH_S390_31)	+= head.o 
 extra-$(CONFIG_ARCH_S390X)	+= head64.o 
-extra-y				+= init_task.o vmlinux.lds.s
+extra-y				+= init_task.o vmlinux.lds
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
 obj-$(CONFIG_SMP)		+= smp.o
diff -Nru a/arch/sh/Makefile b/arch/sh/Makefile
--- a/arch/sh/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sh/Makefile	2004-08-15 22:17:11 +02:00
@@ -122,7 +122,7 @@
 
 boot := arch/sh/boot
 
-AFLAGS_vmlinux.lds.o := -traditional
+CPPFLAGS_vmlinux.lds := -traditional
 
 prepare: target_links
 
diff -Nru a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
--- a/arch/sh/boot/compressed/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sh/boot/compressed/Makefile	2004-08-15 22:17:11 +02:00
@@ -22,7 +22,7 @@
 CONFIG_BOOT_LINK_OFFSET ?= 0x00800000
 IMAGE_OFFSET := $(shell printf "0x%8x" $$[0x80000000+$(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET)])
 
-LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds.s
+LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup -T $(obj)/../../kernel/vmlinux.lds
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
diff -Nru a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
--- a/arch/sh/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sh/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the Linux/SuperH kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 	ptrace.o setup.o time.o sys_sh.o semaphore.o \
diff -Nru a/arch/sh64/boot/compressed/Makefile b/arch/sh64/boot/compressed/Makefile
--- a/arch/sh64/boot/compressed/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sh64/boot/compressed/Makefile	2004-08-15 22:17:11 +02:00
@@ -12,7 +12,7 @@
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
-		   head.o misc.o cache.o piggy.o vmlinux.lds.o
+		   head.o misc.o cache.o piggy.o vmlinux.lds
 
 EXTRA_AFLAGS	:= -traditional
 
@@ -25,7 +25,7 @@
 ZIMAGE_OFFSET = $(shell printf "0x%8x" $$[$(CONFIG_MEMORY_START)+0x400000+0x10000])
 
 LDFLAGS_vmlinux := -Ttext $(ZIMAGE_OFFSET) -e startup \
-		    -T $(obj)/../../kernel/vmlinux.lds.s \
+		    -T $(obj)/../../kernel/vmlinux.lds \
 		    --no-warn-mismatch
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
@@ -41,6 +41,6 @@
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-sh64-linux -T
 OBJCOPYFLAGS += -R .empty_zero_page
 
-$(obj)/piggy.o: $(obj)/vmlinux.lds.s $(obj)/vmlinux.bin.gz FORCE
+$(obj)/piggy.o: $(obj)/vmlinux.lds $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,ld)
 
diff -Nru a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
--- a/arch/sparc/boot/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sparc/boot/Makefile	2004-08-15 22:17:11 +02:00
@@ -37,7 +37,7 @@
 
 BTOBJS := $(HEAD_Y) $(INIT_Y)
 BTLIBS := $(CORE_Y) $(LIBS_Y) $(DRIVERS_Y) $(NET_Y)
-LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds.s $(BTOBJS) \
+LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) \
                   --start-group $(BTLIBS) --end-group \
                   $(kallsyms.o) $(obj)/btfix.o
 
diff -Nru a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
--- a/arch/sparc/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sparc/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 EXTRA_AFLAGS	:= -ansi
 
diff -Nru a/arch/sparc64/Makefile b/arch/sparc64/Makefile
--- a/arch/sparc64/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sparc64/Makefile	2004-08-15 22:17:11 +02:00
@@ -10,7 +10,7 @@
 
 CHECK		:= $(CHECK) -D__sparc__=1 -D__sparc_v9__=1
 
-AFLAGS_vmlinux.lds.o += -Usparc
+CPPFLAGS_vmlinux.lds += -Usparc
 
 CC		:= $(shell if $(CC) -m64 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo $(CC); else echo sparc64-linux-gcc; fi )
 
diff -Nru a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
--- a/arch/sparc64/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/sparc64/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -5,7 +5,7 @@
 EXTRA_AFLAGS := -ansi
 EXTRA_CFLAGS := -Werror
 
-extra-y		:= head.o init_task.o vmlinux.lds.s
+extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		:= process.o setup.o cpu.o idprom.o \
 		   traps.o devices.o auxio.o \
diff -Nru a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/um/Makefile	2004-08-15 22:17:11 +02:00
@@ -77,7 +77,7 @@
 # CONFIG_MODE_SKAS + CONFIG_STATIC_LINK case.
 
 LINK_TT = -static
-LD_SCRIPT_TT := uml.lds.s
+LD_SCRIPT_TT := uml.lds
 
 ifeq ($(CONFIG_STATIC_LINK),y)
   LINK-y += $(LINK_TT)
@@ -98,12 +98,12 @@
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
 
-AFLAGS_vmlinux.lds.o = -U$(SUBARCH) \
+CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 	-DSTART=$$(($(TOP_ADDR) - $(SIZE))) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE)
 
-AFLAGS_$(LD_SCRIPT-y:.s=).o = $(AFLAGS_vmlinux.lds.o) -P -C -Uum
+CPPFLAGS_$(LD_SCRIPT-y) = $(CPPFLAGS_vmlinux.lds) -P -C -Uum
 
 LD_SCRIPT-y := $(ARCH_DIR)/$(LD_SCRIPT-y)
 
@@ -122,7 +122,7 @@
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
-CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds.s \
+CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds \
 	$(ARCH_DIR)/dyn_link.ld.s $(GEN_HEADERS)
 
 $(ARCH_DIR)/main.o: $(ARCH_DIR)/main.c
diff -Nru a/arch/um/Makefile-skas b/arch/um/Makefile-skas
--- a/arch/um/Makefile-skas	2004-08-15 22:17:11 +02:00
+++ b/arch/um/Makefile-skas	2004-08-15 22:17:11 +02:00
@@ -12,7 +12,7 @@
 MODE_INCLUDE += -I$(TOPDIR)/$(ARCH_DIR)/kernel/skas/include
 
 LINK_SKAS = -Wl,-rpath,/lib 
-LD_SCRIPT_SKAS = dyn.lds.s
+LD_SCRIPT_SKAS = dyn.lds
 
 GEN_HEADERS += $(ARCH_DIR)/kernel/skas/include/skas_ptregs.h
 
diff -Nru a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
--- a/arch/um/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/um/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds.s
+extra-y := vmlinux.lds
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
diff -Nru a/arch/v850/kernel/Makefile b/arch/v850/kernel/Makefile
--- a/arch/v850/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/v850/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -9,7 +9,7 @@
 # for more details.
 #
 
-extra-y := head.o init_task.o vmlinux.lds.s
+extra-y := head.o init_task.o vmlinux.lds
 
 obj-y += intv.o entry.o process.o syscalls.o time.o semaphore.o setup.o \
 	 signal.o irq.o mach.o ptrace.o bug.o
diff -Nru a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile	2004-08-15 22:17:11 +02:00
+++ b/arch/x86_64/kernel/Makefile	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
+extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \
diff -Nru a/arch/x86_64/kernel/Makefile-HEAD b/arch/x86_64/kernel/Makefile-HEAD
--- a/arch/x86_64/kernel/Makefile-HEAD	2004-08-15 22:17:11 +02:00
+++ b/arch/x86_64/kernel/Makefile-HEAD	2004-08-15 22:17:11 +02:00
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-extra-y 	:= head.o head64.o init_task.o vmlinux.lds.s
+extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_x86_64.o \

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933223AbWFXIKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223AbWFXIKd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933224AbWFXIKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:10:33 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:3062 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S933223AbWFXIKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:10:32 -0400
Message-ID: <18235552.1151136631329.JavaMail.tomcat@pne-ps3-sn2>
Date: Sat, 24 Jun 2006 10:10:31 +0200 (MEST)
From: <lista1@comhem.se>
Reply-To: <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-git[5,6] CONFIG_PCI_MSI=y compile failure
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [83.249.195.206]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-git1 and git4 compiles OK, but git5 and 6 fail with CONFIG_PCI_MSI=y 
here:

msi)"  -D"KBUILD_MODNAME=KBUILD_STR(msi)" -c -o drivers/pci/msi.o 
drivers/pci/msi.c
  gcc -Wp,-MD,drivers/pci/.msi-apic.o.d  -nostdinc -isystem 
/usr/lib/gcc/x86_64-unknown-linux-gnu/3.4.4/include -D__KERNEL__ -Iinclude  -
include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-
trigraphs -fno-strict-aliasing -fno-common -Os -fomit-frame-pointer  -march=k8 -
m64 -mno-red-zone -mcmodel=kernel -pipe -ffunction-sections -fno-reorder-blocks 
-Wno-sign-compare -fno-asynchronous-unwind-tables -funit-at-a-time -mno-sse -
mno-mmx -mno-sse2 -mno-3dnow -Wdeclaration-after-statement     -D"KBUILD_STR(s)
=#s" -D"KBUILD_BASENAME=KBUILD_STR(msi_apic)"  -D"KBUILD_MODNAME=KBUILD_STR
(msi_apic)" -c -o drivers/pci/msi-apic.o drivers/pci/msi-apic.c
In file included from include/asm/msi.h:11,
                 from drivers/pci/msi.h:71,
                 from drivers/pci/msi-apic.c:8:
include/asm/smp.h:103: error: parse error before '->' token
make[2]: *** [drivers/pci/msi-apic.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2

Sorry about line-wraps/length, I'm writing this from a webmail site - own 
machine is down.

Mvh
Mats Johannesson


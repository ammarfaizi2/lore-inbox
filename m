Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTLCVcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTLCVcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:32:16 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:64952 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261891AbTLCVbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:31:53 -0500
Subject: configuration failure of 2.6.0-test11 on non-scsi system
From: david nicol <whatever@davidnicol.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1070487104.30344.1.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Dec 2003 15:31:45 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[david@plaza linux-2.6.0-test11]$ make menuconfig
  HOSTCC  scripts/fixdep
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/mconf
  HOSTCC  scripts/lxdialog/checklist.o
  HOSTCC  scripts/lxdialog/inputbox.o
  HOSTCC  scripts/lxdialog/lxdialog.o
  HOSTCC  scripts/lxdialog/menubox.o
  HOSTCC  scripts/lxdialog/msgbox.o
  HOSTCC  scripts/lxdialog/textbox.o
  HOSTCC  scripts/lxdialog/util.o
  HOSTCC  scripts/lxdialog/yesno.o
  HOSTLD  scripts/lxdialog/lxdialog
scripts/kconfig/mconf arch/i386/Kconfig
#
# using defaults found in arch/i386/defconfig
#
arch/i386/defconfig:114: trying to assign nonexistent symbol ACPI_HT
arch/i386/defconfig:176: trying to assign nonexistent symbol KCORE_ELF
arch/i386/defconfig:177: trying to assign nonexistent symbol KCORE_AOUT
arch/i386/defconfig:355: trying to assign nonexistent symbol
SCSI_SYM53C8XX
make[1]: *** [menuconfig] Segmentation fault
make: *** [menuconfig] Error 2
-- 
david nicol
	                                Where the hell did I put my coffee?


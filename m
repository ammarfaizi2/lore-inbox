Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTLCVz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTLCVzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:55:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:55984 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbTLCVyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:54:15 -0500
Date: Wed, 3 Dec 2003 13:47:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: david nicol <whatever@davidnicol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: configuration failure of 2.6.0-test11 on non-scsi system
Message-Id: <20031203134704.4a3b2abf.rddunlap@osdl.org>
In-Reply-To: <1070487104.30344.1.camel@plaza.davidnicol.com>
References: <1070487104.30344.1.camel@plaza.davidnicol.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Dec 2003 15:31:45 -0600 david nicol <whatever@davidnicol.com> wrote:

| [david@plaza linux-2.6.0-test11]$ make menuconfig
|   HOSTCC  scripts/fixdep
|   SHIPPED scripts/kconfig/zconf.tab.h
|   HOSTCC  scripts/kconfig/conf.o
|   HOSTCC  scripts/kconfig/mconf.o
|   SHIPPED scripts/kconfig/zconf.tab.c
|   SHIPPED scripts/kconfig/lex.zconf.c
|   HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
|   HOSTLLD -shared scripts/kconfig/libkconfig.so
|   HOSTLD  scripts/kconfig/mconf
|   HOSTCC  scripts/lxdialog/checklist.o
|   HOSTCC  scripts/lxdialog/inputbox.o
|   HOSTCC  scripts/lxdialog/lxdialog.o
|   HOSTCC  scripts/lxdialog/menubox.o
|   HOSTCC  scripts/lxdialog/msgbox.o
|   HOSTCC  scripts/lxdialog/textbox.o
|   HOSTCC  scripts/lxdialog/util.o
|   HOSTCC  scripts/lxdialog/yesno.o
|   HOSTLD  scripts/lxdialog/lxdialog
| scripts/kconfig/mconf arch/i386/Kconfig
| #
| # using defaults found in arch/i386/defconfig
| #
| arch/i386/defconfig:114: trying to assign nonexistent symbol ACPI_HT
| arch/i386/defconfig:176: trying to assign nonexistent symbol KCORE_ELF
| arch/i386/defconfig:177: trying to assign nonexistent symbol KCORE_AOUT
| arch/i386/defconfig:355: trying to assign nonexistent symbol
| SCSI_SYM53C8XX

Same for me down to here (without a .config file), but then menuconfig
runs for me.... I would guess either tools or libraries, but dunno.

| make[1]: *** [menuconfig] Segmentation fault
| make: *** [menuconfig] Error 2
| -- 
| 	                                Where the hell did I put my coffee?
Yes.

--
~Randy
MOTD:  Always include version info.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSKENkp>; Tue, 5 Nov 2002 08:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264858AbSKENkp>; Tue, 5 Nov 2002 08:40:45 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:57227 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264857AbSKENko>; Tue, 5 Nov 2002 08:40:44 -0500
Message-Id: <4.3.2.7.2.20021105145305.00c5d2b0@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 05 Nov 2002 14:53:24 +0100
To: linux-kernel@vger.kernel.org
From: Roger While <RogerWhile@sim-basis.de>
Subject: 2.5.46 make modules_install fail
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDRemoteIP: 192.168.6.50
X-Return-Path: RogerWhile@sim-basis.de
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.modinst obj=arch/i386/lib
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.46/kernel/drivers/isdn/hisax/hisax.o
depmod:         kstat__per_cpu
depmod: *** Unresolved symbols in 
/lib/modules/2.5.46/kernel/drivers/isdn/i4l/isdn.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.46/kernel/fs/binfmt_aout.o
depmod:         ptrace_notify
make: *** [_modinst_post] Error 1



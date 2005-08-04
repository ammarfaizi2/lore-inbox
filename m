Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVHDMAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVHDMAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVHDMAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:00:31 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:61057 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262493AbVHDMAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:00:04 -0400
Message-ID: <42F20345.3020603@gmail.com>
Date: Thu, 04 Aug 2005 14:00:05 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Old api files, rewrite or delete?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I'm interested mainly in things that may be removed. I don't want to 
rewrite drivers, which nobody uses.
Thanks for your opinion and knowledge about usage.

I was searching for pci_find_device, so changes to do may not be huge,
only few lines in some cases could be everything what to do.
the result is:

REWRITE:
drivers/media/video/bttv-cards.c
drivers/media/video/zoran_card.c
drivers/media/video/stradis.c
drivers/media/radio/radio-maestro.c
drivers/video/sis/sis_main.c
drivers/video/igafb.c
drivers/net/skfp/drvfbi.c
drivers/net/sunhme.c
drivers/net/gt96100eth.c
drivers/char/watchdog/i8xx_tco.c
drivers/char/watchdog/alim1535_wdt.c
drivers/char/watchdog/alim7101_wdt.c
drivers/char/watchdog/i6300esb.c
drivers/char/sx.c
drivers/char/istallion.c
drivers/char/mxser.c
drivers/char/rocket.c
drivers/char/stallion.c
drivers/char/specialix.c
drivers/char/ip2main.c
drivers/isdn/hisax/gazel.c
drivers/isdn/hisax/elsa.c
drivers/isdn/hisax/nj_u.c
drivers/isdn/hisax/nj_s.c
drivers/isdn/hisax/avm_pci.c
drivers/isdn/hisax/bkm_a4t.c
drivers/isdn/hisax/hfc_pci.c
drivers/isdn/hisax/telespci.c
drivers/isdn/hisax/enternow_pci.c
drivers/isdn/hisax/bkm_a8.c
drivers/isdn/hisax/w6692.c
drivers/isdn/hisax/diva.c
drivers/isdn/hisax/sedlbauer.c
drivers/isdn/hisax/niccy.c
drivers/isdn/hysdn/hysdn_init.c
drivers/scsi/cpqfcTSinit.c
drivers/scsi/initio.c
drivers/scsi/advansys.c
drivers/scsi/gdth.c
drivers/scsi/eata_pio.c
drivers/scsi/fdomain.c
drivers/scsi/qlogicfc.c
drivers/scsi/dpt_i2o.c
drivers/scsi/qlogicisp.c
drivers/scsi/aic7xxx_old.c
drivers/scsi/BusLogic.c
drivers/parport/parport_pc.c
drivers/mtd/devices/pmc551.c
drivers/mtd/maps/ichxrom.c
drivers/mtd/maps/amd76xrom.c
drivers/mtd/maps/scx200_docflash.c
drivers/mtd/maps/l440gx.c
drivers/ide/pci/serverworks.c
drivers/ide/pci/piix.c
drivers/ide/pci/cs5530.c
drivers/ide/pci/alim15x3.c
drivers/ide/pci/sis5513.c
drivers/ide/pci/pdc202xx_new.c
drivers/ide/pci/via82cxxx.c
drivers/ide/pci/hpt366.c
drivers/ide/setup-pci.c
drivers/macintosh/via-pmu68k.c
drivers/macintosh/via-pmu.c
drivers/telephony/ixj.c
arch/ppc/kernel/pci.c
arch/ppc/platforms/85xx/mpc85xx_cds_common.c
arch/sparc64/kernel/ebus.c
arch/alpha/kernel/sys_sio.c
arch/alpha/kernel/sys_alcor.c
arch/frv/mb93090-mb00/pci-frv.c
arch/frv/mb93090-mb00/pci-irq.c
include/asm-i386/ide.h
sound/pci/cs46xx/cs46xx_lib.c
sound/pci/au88x0/au88x0.c
sound/pci/via82xx.c
sound/pci/ali5451/ali5451.c
sound/core/memalloc.c

LET IT BE (and then delete):
sound/oss/esssolo1.c
sound/oss/via82cxxx_audio.c
sound/oss/trident.c
sound/oss/maestro.c
sound/oss/cs46xx.c

REMOVE:
drivers/video/pm3fb.c

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10


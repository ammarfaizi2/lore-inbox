Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265529AbSKAAle>; Thu, 31 Oct 2002 19:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265533AbSKAAld>; Thu, 31 Oct 2002 19:41:33 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:59097 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265529AbSKAAlO> convert rfc822-to-8bit; Thu, 31 Oct 2002 19:41:14 -0500
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.45: AIC7XXX_BUILD_FIRMWARE=y is broken
Date: Fri, 1 Nov 2002 01:47:33 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200211010147.33165.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=drivers/scsi
  ld -m elf_i386  -r -o drivers/scsi/scsi_mod.o drivers/scsi/scsi.o 
drivers/scsi/hosts.o dr
ivers/scsi/scsi_ioctl.o drivers/scsi/constants.o drivers/scsi/scsicam.o 
drivers/scsi/scsi_p
roc.o drivers/scsi/scsi_error.o drivers/scsi/scsi_lib.o 
drivers/scsi/scsi_scan.o drivers/sc
si/scsi_syms.o
make -f scripts/Makefile.build obj=drivers/scsi/aic7xxx
make[3]: *** No rule to make target `drivers/scsi/aic7xxx/aix7xxx_seq.h', 
needed by `driver
s/scsi/aic7xxx/aic7xxx_reg.h'.  Stop.
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

Thanks,
	Dieter

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSDUGpv>; Sun, 21 Apr 2002 02:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310749AbSDUGpu>; Sun, 21 Apr 2002 02:45:50 -0400
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:34577
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S310666AbSDUGpt>; Sun, 21 Apr 2002 02:45:49 -0400
Date: Sun, 21 Apr 2002 01:43:58 -0500 (CDT)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: <linux-kernel@vger.kernel.org>
Subject: possible GPL violation involving linux kernel code
Message-ID: <Pine.LNX.4.33.0204200024030.24652-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just know I'm going to regret posting this, but I can think of
no better group to notify of this than the copyright holders, and
no better location for the majority of them then l-k.

While searching through all of the driver images on Promise Tech's
website I stumbled across their disk images for Caldera/Open Linux
and their TX2 card ( http://promise.com/support/file/ftol_12014.tgz )

This tarball contains two disk images:
-rw-r--r--    1 cabbey    1474560 Nov 19 01:29 ols31-ft.img
-rw-r--r--    1 cabbey    1474560 Nov 19 01:27 olw31-ft.img

which in turn contain binary modules from 2.4.2 and 2.4.3
(intermixed, I found some modules from 2.4.2 and some from
2.4.3, as well as a few of their rc's)

The contents of one of these images (ols31-ft.img) is as such
(ther other disk is very similar):

cabbey@chesire:/mnt > find .
.
./bin
./bin/mol.gz
./lib
./lib/modules
./lib/modules/2.4.2
./lib/modules/2.4.2/pnp
./lib/modules/2.4.2/pnp/isa-pnp.o.gz
./lib/modules/2.4.2/block
./lib/modules/2.4.2/block/DAC960.o.gz
./lib/modules/2.4.2/block/cciss.o.gz
./lib/modules/2.4.2/block/loop.o.gz
./lib/modules/2.4.2/block/cpqarray.o.gz
./lib/modules/2.4.2/cdrom
./lib/modules/2.4.2/cdrom/mcdx.o.gz
./lib/modules/2.4.2/cdrom/sbpcd.o.gz
./lib/modules/2.4.2/fs
./lib/modules/2.4.2/fs/fat.o.gz
./lib/modules/2.4.2/fs/msdos.o.gz
./lib/modules/2.4.2/fs/umsdos.o.gz
./lib/modules/2.4.2/fs/reiserfs.o.gz
./lib/modules/2.4.2/fs/vfat.o.gz
./lib/modules/2.4.2/net
./lib/modules/2.4.2/net/3c501.o.gz
./lib/modules/2.4.2/net/3c503.o.gz
./lib/modules/2.4.2/net/3c505.o.gz
./lib/modules/2.4.2/net/3c507.o.gz
./lib/modules/2.4.2/net/3c509.o.gz
./lib/modules/2.4.2/net/3c515.o.gz
./lib/modules/2.4.2/net/ac3200.o.gz
./lib/modules/2.4.2/net/at1700.o.gz
./lib/modules/2.4.2/net/atp.o.gz
./lib/modules/2.4.2/net/de4x5.o.gz
./lib/modules/2.4.2/net/de600.o.gz
./lib/modules/2.4.2/net/de620.o.gz
./lib/modules/2.4.2/net/depca.o.gz
./lib/modules/2.4.2/net/dgrs.o.gz
./lib/modules/2.4.2/net/dmfe.o.gz
./lib/modules/2.4.2/net/e2100.o.gz
./lib/modules/2.4.2/net/eepro.o.gz
./lib/modules/2.4.2/net/eth16i.o.gz
./lib/modules/2.4.2/net/eepro100.o.gz
./lib/modules/2.4.2/net/eexpress.o.gz
./lib/modules/2.4.2/net/epic100.o.gz
./lib/modules/2.4.2/net/ewrk3.o.gz
./lib/modules/2.4.2/net/hp.o.gz
./lib/modules/2.4.2/net/hp-plus.o.gz
./lib/modules/2.4.2/net/hp100.o.gz
./lib/modules/2.4.2/net/lance.o.gz
./lib/modules/2.4.2/net/ne.o.gz
./lib/modules/2.4.2/net/ni52.o.gz
./lib/modules/2.4.2/net/ne2k-pci.o.gz
./lib/modules/2.4.2/net/ni65.o.gz
./lib/modules/2.4.2/net/sis900.o.gz
./lib/modules/2.4.2/net/olympic.o.gz
./lib/modules/2.4.2/net/tlan.o.gz
./lib/modules/2.4.2/net/smc-ultra.o.gz
./lib/modules/2.4.2/net/wd.o.gz
./lib/modules/2.4.2/net/smc-ultra32.o.gz
./lib/modules/2.4.2/net/yellowfin.o.gz
./lib/modules/2.4.2/net/e100.o.gz
./lib/modules/2.4.2/scsi
./lib/modules/2.4.2/scsi/AM53C974.o.gz
./lib/modules/2.4.2/scsi/BusLogic.o.gz
./lib/modules/2.4.2/scsi/NCR53c406a.o.gz
./lib/modules/2.4.2/scsi/a100u2w.o.gz
./lib/modules/2.4.2/scsi/ft.o.gz
./lib/modules/2.4.2/scsi/aha152x.o.gz
./lib/modules/2.4.2/scsi/aha1542.o.gz
./lib/modules/2.4.2/scsi/aha1740.o.gz
./lib/modules/2.4.2/scsi/aic7xxx.o.gz
./lib/modules/2.4.2/scsi/atp870u.o.gz
./lib/modules/2.4.2/scsi/dtc.o.gz
./lib/modules/2.4.2/scsi/eata.o.gz
./lib/modules/2.4.2/scsi/eata_dma.o.gz
./lib/modules/2.4.2/scsi/eata_pio.o.gz
./lib/modules/2.4.2/scsi/fdomain.o.gz
./lib/modules/2.4.2/scsi/g_NCR5380.o.gz
./lib/modules/2.4.2/scsi/gdth.o.gz
./lib/modules/2.4.2/scsi/ide-scsi.o.gz
./lib/modules/2.4.2/scsi/imm.o.gz
./lib/modules/2.4.2/scsi/in2000.o.gz
./lib/modules/2.4.2/scsi/ips.o.gz
./lib/modules/2.4.2/scsi/ncr53c8xx.o.gz
./lib/modules/2.4.2/scsi/pas16.o.gz
./lib/modules/2.4.2/scsi/pci2000.o.gz
./lib/modules/2.4.2/scsi/pci2220i.o.gz
./lib/modules/2.4.2/scsi/ppa.o.gz
./lib/modules/2.4.2/scsi/psi240i.o.gz
./lib/modules/2.4.2/scsi/qlogicfas.o.gz
./lib/modules/2.4.2/scsi/qlogicfc.o.gz
./lib/modules/2.4.2/scsi/qlogicisp.o.gz
./lib/modules/2.4.2/scsi/scsi_mod.o.gz
./lib/modules/2.4.2/scsi/sd_mod.o.gz
./lib/modules/2.4.2/scsi/seagate.o.gz
./lib/modules/2.4.2/scsi/sg.o.gz
./lib/modules/2.4.2/scsi/sr_mod.o.gz
./lib/modules/2.4.2/scsi/st.o.gz
./lib/modules/2.4.2/scsi/sym53c416.o.gz
./lib/modules/2.4.2/scsi/sym53c8xx.o.gz
./lib/modules/2.4.2/scsi/t128.o.gz
./lib/modules/2.4.2/scsi/tmscsim.o.gz
./lib/modules/2.4.2/scsi/u14-34f.o.gz
./lib/modules/2.4.2/scsi/wd7000.o.gz
./sbin
./sbin/fdisk.gz
./readme.txt
./setup-ft

I pulled a few of these gzip'd modules apart and am confident
that they are exactly what they appear to be. There is no source,
license or mention of either on the image, or on their website.

http://promise.com/support/other2_eng.asp?mode=linux_download&product_id=8

The bin/mol and sbin/fdisk files are certainly executables, but I
wasn't able to execute either due dynamic library dependencies.

Note that there are a large number of images on there, and I was only
looking at a subset (most recent TX2 driver images) there may be other
examples of this. Given the incredibly high quality of those other images
I can easily believe this is a mistake on their part rather than
intentionsl. (note only half of that sentence was sardonic.)

-- 
Never make a technical decision based upon the politics of the situation.
Never make a political decision based upon technical issues.
The only place these realms meet is in the mind of the unenlightened.
			-- Geoffrey James, The Zen of Programming



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274816AbRJAJcS>; Mon, 1 Oct 2001 05:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274825AbRJAJb7>; Mon, 1 Oct 2001 05:31:59 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:13328 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S274823AbRJAJbq>; Mon, 1 Oct 2001 05:31:46 -0400
Subject: 2.4.11-pre1 -- Compile errors in cpqfcTSinit.c: In function
	`cpqfcTS_ioctl'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99 (Preview Release)
Date: 01 Oct 2001 02:24:22 -0700
Message-Id: <1001928264.1247.86.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make[2]: Entering directory `/usr/src/linux/drivers/scsi'
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
ld -m elf_i386 -r -o initio.o ini9100u.o i91uscsi.o
ld -m elf_i386 -r -o a100u2w.o inia100.o i60uscsi.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o cpqfcTSinit.o cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:662: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this function)
cpqfcTSinit.c:662: (Each undeclared identifier is reported only once
cpqfcTSinit.c:662: for each function it appears in.)
cpqfcTSinit.c:680: `SCSI_IOCTL_FC_TDR' undeclared (first use in this function)
make[2]: *** [cpqfcTSinit.o] Error 1

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_MEGARAID=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_SCSI_CPQFCTS=m
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_EATA_LINKED_COMMANDS=y
CONFIG_SCSI_EATA_MAX_TAGS=16
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
CONFIG_SCSI_GENERIC_NCR53C400=y
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_NCR53C406A=m
# CONFIG_SCSI_NCR_D700 is not set
CONFIG_SCSI_NCR53C7xx=m
CONFIG_SCSI_NCR53C7xx_sync=y
CONFIG_SCSI_NCR53C7xx_FAST=y
CONFIG_SCSI_NCR53C7xx_DISCONNECT=y
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_PCI2000=m
CONFIG_SCSI_PCI2220I=m
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_QLOGIC_FC_FIRMWARE=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_DC390T_NOGENSUPP=y
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
CONFIG_SCSI_U14_34F_LINKED_COMMANDS=y
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_DEBUG=m


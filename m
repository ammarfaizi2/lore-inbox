Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTA1J6H>; Tue, 28 Jan 2003 04:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTA1J6G>; Tue, 28 Jan 2003 04:58:06 -0500
Received: from mx7.mail.ru ([194.67.57.17]:54543 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S264939AbTA1J5y>;
	Tue, 28 Jan 2003 04:57:54 -0500
From: "Alex Kazantsev" <lesha__k@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Compilation errors. SCSI driver NCR53c7,8xx.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.208.208.184]
Date: Tue, 28 Jan 2003 13:07:02 +0300
Reply-To: "Alex Kazantsev" <lesha__k@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18dSdy-0003LR-00@f10.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.]			Compilation errors. SCSI driver NCR53c7,8xx.
[2.]
Description :
Command ' make bzImage ' give's this :

< ... cut ... >
make -f scripts/Makefile.build obj=drivers/scsi
  gcc -Wp,-MD,drivers/scsi/.53c7_8xx.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=53c7_8xx -DKBUILD_MODNAME=53c7_8xx   -c -o drivers/scsi/53c7,8xx.o drivers/scsi/53c7,8xx.c
drivers/scsi/53c7,8xx.c:65: #error Please convert me to Documentation/DMA-mapping.txt
drivers/scsi/53c7,8xx.c: In function `NCR53c7x0_init':
drivers/scsi/53c7,8xx.c:1107: structure has no member named `next'
drivers/scsi/53c7,8xx.c:1113: warning: implicit declaration of function `request_irq'
drivers/scsi/53c7,8xx.c: In function `NCR53c7xx_detect':
drivers/scsi/53c7,8xx.c:1554: too many arguments to function `normal_init'
drivers/scsi/53c7,8xx.c: In function `NCR53c8xx_run_tests':
drivers/scsi/53c7,8xx.c:1829: warning: implicit declaration of function `save_flags'
drivers/scsi/53c7,8xx.c:1830: warning: implicit declaration of function `cli'
drivers/scsi/53c7,8xx.c:1833: warning: implicit declaration of function `restore_flags'
drivers/scsi/53c7,8xx.c:1824: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `abnormal_finished':
drivers/scsi/53c7,8xx.c:2119: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c:2083: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `intr_break':
drivers/scsi/53c7,8xx.c:2240: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `allocate_cmd':
drivers/scsi/53c7,8xx.c:3455: structure has no member named `has_cmdblocks'
drivers/scsi/53c7,8xx.c:3439: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `create_cmd':
drivers/scsi/53c7,8xx.c:3784: structure has no member named `address'
drivers/scsi/53c7,8xx.c:3529: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `NCR53c7xx_queue_command':
drivers/scsi/53c7,8xx.c:3885: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c:2083: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `process_issue_queue':
drivers/scsi/53c7,8xx.c:4102: structure has no member named `next'
drivers/scsi/53c7,8xx.c:3969: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `NCR53c7x0_intr':
drivers/scsi/53c7,8xx.c:4399: structure has no member named `next'
drivers/scsi/53c7,8xx.c:4391: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c:2083: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `intr_bf':
drivers/scsi/53c7,8xx.c:5084: structure has no member named `pcidev'
drivers/scsi/53c7,8xx.c:5054: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `intr_dma':
drivers/scsi/53c7,8xx.c:5154: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `NCR53c7xx_abort':
drivers/scsi/53c7,8xx.c:5471: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c:2083: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `NCR53c7xx_reset':
drivers/scsi/53c7,8xx.c:5635: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `insn_to_offset':
drivers/scsi/53c7,8xx.c:5750: structure has no member named `address'
drivers/scsi/53c7,8xx.c:5751: structure has no member named `address'
drivers/scsi/53c7,8xx.c:5759: structure has no member named `address'
drivers/scsi/53c7,8xx.c: In function `print_queues':
drivers/scsi/53c7,8xx.c:5910: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `shutdown':
drivers/scsi/53c7,8xx.c:6051: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `ncr_scsi_reset':
drivers/scsi/53c7,8xx.c:6078: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `hard_reset':
drivers/scsi/53c7,8xx.c:6105: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `disable':
drivers/scsi/53c7,8xx.c:6206: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `ncr_halt':
drivers/scsi/53c7,8xx.c:6241: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: In function `dump_events':
drivers/scsi/53c7,8xx.c:6332: warning: `flags' might be used uninitialized in this function
drivers/scsi/53c7,8xx.c: At top level:
drivers/scsi/53c7,8xx.c:6431: warning: initialization from incompatible pointer type
drivers/scsi/53c7,8xx.c:6431: warning: initialization from incompatible pointer type
make[2]: *** [drivers/scsi/53c7,8xx.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2


[4.]
cat /proc/version :
Linux version 2.5.59 (root@slackware) (gcc version 2.95.3 20010315 (release)) #5 Tue Jan 28 13:53:06 MSK 2003
// Now kernel compiled without this driver

[7.7.]
Cutted .config :
#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_NCR53C7xx=y
# CONFIG_SCSI_NCR53C7xx_sync is not set
# CONFIG_SCSI_NCR53C7xx_FAST is not set
# CONFIG_SCSI_NCR53C7xx_DISCONNECT is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set


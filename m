Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTBFXCd>; Thu, 6 Feb 2003 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTBFXCc>; Thu, 6 Feb 2003 18:02:32 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:17361 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S267696AbTBFXCS>; Thu, 6 Feb 2003 18:02:18 -0500
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302061424110.14297-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302061424110.14297-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Feb 2003 16:09:09 -0700
Message-Id: <1044572949.14310.356.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 15:26, Linus Torvalds wrote:
> 
> On 6 Feb 2003, Steven Cole wrote:
> > 
> > So, since this uses ex instead of vi ;), here is something to fix
> > the spelling of definite and separate throughout the tree.
> 
> You've not tried this with a tree that has source control (either CVS, BK
> or RCS) have you? It looks like it corrupts the SCM too.
> 
> I don't really mind getting scripts occasionally to do things, but they 
> had better be "obviously fool-proof" for it to really be worth-while. 
> Mostly it's easier to just get a diff, even if in this case the (broken) 
> script is just 3 lines, and the diff would likely be 700+ lines.
> 
> 		Linus

I sent Linus an 880-line diff which fixed the spelling of definite and
separate in 2.5.59-bk2.  Here is the diffstat output for that diff.

Steven

 Documentation/SubmittingDrivers        |    2 +-
 Documentation/networking/bonding.txt   |    4 ++--
 Documentation/s390/s390dbf.txt         |    2 +-
 Documentation/scsi/ibmmca.txt          |    4 ++--
 Documentation/usb/hiddev.txt           |    2 +-
 arch/cris/lib/old_checksum.c           |    2 +-
 arch/m68k/atari/hades-pci.c            |    2 +-
 arch/m68k/math-emu/fp_decode.h         |    4 ++--
 arch/m68k/math-emu/fp_scan.S           |    4 ++--
 arch/parisc/kernel/irq.c               |    2 +-
 drivers/block/cpqarray.c               |    2 +-
 drivers/char/drm/i830_dma.c            |    2 +-
 drivers/char/ip2main.c                 |    2 +-
 drivers/char/n_hdlc.c                  |    2 +-
 drivers/char/rio/cmdpkt.h              |    2 +-
 drivers/char/synclink.c                |    2 +-
 drivers/ide/pci/pdc202xx_new.c         |    2 +-
 drivers/ide/pci/pdc202xx_old.c         |    2 +-
 drivers/isdn/hardware/eicon/io.h       |    2 +-
 drivers/media/video/zr36120.c          |    2 +-
 drivers/mtd/maps/elan-104nc.c          |    2 +-
 drivers/net/fealnx.c                   |    2 +-
 drivers/net/hamachi.c                  |    2 +-
 drivers/net/sis900.c                   |    2 +-
 drivers/net/sk98lin/skgeinit.c         |    2 +-
 drivers/net/skfp/h/supern_2.h          |    2 +-
 drivers/net/skfp/smt.c                 |    2 +-
 drivers/net/skfp/smtdef.c              |    2 +-
 drivers/net/tg3.c                      |    2 +-
 drivers/net/tokenring/madgemc.c        |    4 ++--
 drivers/net/tokenring/smctr_firmware.h |    2 +-
 drivers/net/tokenring/tmsisa.c         |    2 +-
 drivers/net/tokenring/tmspci.c         |    2 +-
 drivers/net/wan/lmc/lmc_ioctl.h        |    2 +-
 drivers/parisc/ccio-dma.c              |    2 +-
 drivers/parisc/ccio-rm-dma.c           |    2 +-
 drivers/parisc/sba_iommu.c             |    2 +-
 drivers/s390/char/sclp_tty.c           |    6 +++---
 drivers/s390/char/sclp_tty.h           |    4 ++--
 drivers/s390/char/tape_char.c          |    2 +-
 drivers/scsi/aacraid/aacraid.h         |    4 ++--
 drivers/scsi/aic7xxx_old.c             |    2 +-
 drivers/scsi/qla1280.c                 |    2 +-
 drivers/scsi/qlogicfc.c                |    2 +-
 drivers/scsi/sim710.c                  |    4 ++--
 drivers/usb/serial/usb-serial.c        |    2 +-
 drivers/video/riva/fbdev.c             |    2 +-
 drivers/video/skeletonfb.c             |    4 ++--
 fs/binfmt_elf.c                        |    2 +-
 fs/binfmt_flat.c                       |    2 +-
 fs/jfs/jfs_txnmgr.c                    |    2 +-
 fs/nfs/nfs4proc.c                      |    4 ++--
 fs/xfs/xfs_bmap.c                      |    2 +-
 include/asm-ia64/sn/sv.h               |    2 +-
 include/asm-m68k/mac_psc.h             |    2 +-
 include/asm-mips/ng1hw.h               |    2 +-
 include/asm-sparc/ide.h                |    2 +-
 include/asm-sparc64/ide.h              |    2 +-
 net/8021q/vlan.h                       |    2 +-
 sound/core/seq/seq_device.c            |    2 +-
 sound/oss/i810_audio.c                 |    6 +++---
 sound/oss/trident.c                    |    2 +-
 sound/pci/ali5451/ali5451.c            |    4 ++--
 63 files changed, 78 insertions(+), 78 deletions(-)


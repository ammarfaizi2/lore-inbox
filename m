Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbUAAQi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 11:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUAAQi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 11:38:56 -0500
Received: from mk-smarthost-3.mail.uk.tiscali.com ([212.74.114.39]:50193 "EHLO
	mk-smarthost-3.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id S264490AbUAAQio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 11:38:44 -0500
Date: Thu, 1 Jan 2004 16:38:39 +0000
Message-ID: <3FB8EA9C000A0983@mk-cpfrontend-2.mail.uk.tiscali.com>
From: zydas@tiscali.co.uk
Subject: kernel 2.6.0 making modules problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI EVERYONE, HAPPY NEW YEAR!!!
PROBLEM: Get error msgs when make modules
The kernel version I am trying to install is 2.6.0.
'make modules' gives me the output below, when support for usb is off in
xconfig then everything is allright but my keyboard and mouse are usb.
[root@localhost linux-2.6.0]# make modules
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  CC [M]  fs/binfmt_misc.o
  CC [M]  fs/autofs/dirhash.o
  CC [M]  fs/autofs/init.o
  CC [M]  fs/autofs/inode.o
  CC [M]  fs/autofs/root.o
  CC [M]  fs/autofs/symlink.o
  CC [M]  fs/autofs/waitq.o
  LD [M]  fs/autofs/autofs.o
  CC [M]  fs/autofs4/init.o
  CC [M]  fs/autofs4/inode.o
  CC [M]  fs/autofs4/root.o
  CC [M]  fs/autofs4/symlink.o
  CC [M]  fs/autofs4/waitq.o
  CC [M]  fs/autofs4/expire.o
  LD [M]  fs/autofs4/autofs4.o
  CC [M]  fs/coda/psdev.o
  CC [M]  fs/coda/cache.o
  CC [M]  fs/coda/cnode.o
  CC [M]  fs/coda/inode.o
  CC [M]  fs/coda/dir.o
  CC [M]  fs/coda/file.o
  CC [M]  fs/coda/upcall.o
  CC [M]  fs/coda/coda_linux.o
  CC [M]  fs/coda/symlink.o
  CC [M]  fs/coda/pioctl.o
  CC [M]  fs/coda/sysctl.o
  LD [M]  fs/coda/coda.o
  CC [M]  fs/fat/cache.o
  CC [M]  fs/fat/dir.o
  CC [M]  fs/fat/file.o
  CC [M]  fs/fat/inode.o
  CC [M]  fs/fat/misc.o
  CC [M]  fs/fat/fatfs_syms.o
  LD [M]  fs/fat/fat.o
  CC [M]  fs/hfs/balloc.o
  CC [M]  fs/hfs/bdelete.o
  CC [M]  fs/hfs/bfind.o
  CC [M]  fs/hfs/bins_del.o
  CC [M]  fs/hfs/binsert.o
  CC [M]  fs/hfs/bitmap.o
  CC [M]  fs/hfs/bitops.o
  CC [M]  fs/hfs/bnode.o
  CC [M]  fs/hfs/brec.o
  CC [M]  fs/hfs/btree.o
  CC [M]  fs/hfs/catalog.o
  CC [M]  fs/hfs/dir.o
  CC [M]  fs/hfs/dir_cap.o
  CC [M]  fs/hfs/dir_dbl.o
  CC [M]  fs/hfs/dir_nat.o
  CC [M]  fs/hfs/extent.o
  CC [M]  fs/hfs/file.o
  CC [M]  fs/hfs/file_cap.o
  CC [M]  fs/hfs/file_hdr.o
  CC [M]  fs/hfs/inode.o
  CC [M]  fs/hfs/mdb.o
  CC [M]  fs/hfs/part_tbl.o
  CC [M]  fs/hfs/string.o
  CC [M]  fs/hfs/super.o
  CC [M]  fs/hfs/sysdep.o
  CC [M]  fs/hfs/trans.o
  CC [M]  fs/hfs/version.o
  LD [M]  fs/hfs/hfs.o
  CC [M]  fs/intermezzo/cache.o
  CC [M]  fs/intermezzo/dcache.o
  CC [M]  fs/intermezzo/dir.o
  CC [M]  fs/intermezzo/ext_attr.o
  CC [M]  fs/intermezzo/file.o
  CC [M]  fs/intermezzo/fileset.o
  CC [M]  fs/intermezzo/inode.o
  CC [M]  fs/intermezzo/journal.o
  CC [M]  fs/intermezzo/journal_ext2.o
  CC [M]  fs/intermezzo/journal_ext3.o
  CC [M]  fs/intermezzo/journal_obdfs.o
  CC [M]  fs/intermezzo/journal_reiserfs.o
  CC [M]  fs/intermezzo/journal_tmpfs.o
  CC [M]  fs/intermezzo/journal_xfs.o
  CC [M]  fs/intermezzo/kml_reint.o
  CC [M]  fs/intermezzo/kml_unpack.o
  CC [M]  fs/intermezzo/methods.o
  CC [M]  fs/intermezzo/presto.o
  CC [M]  fs/intermezzo/psdev.o
  CC [M]  fs/intermezzo/replicator.o
  CC [M]  fs/intermezzo/super.o
  CC [M]  fs/intermezzo/sysctl.o
  CC [M]  fs/intermezzo/upcall.o
  CC [M]  fs/intermezzo/vfs.o
  LD [M]  fs/intermezzo/intermezzo.o
  CC [M]  fs/jfs/super.o
  CC [M]  fs/jfs/file.o
  CC [M]  fs/jfs/inode.o
  CC [M]  fs/jfs/namei.o
  CC [M]  fs/jfs/jfs_mount.o
  CC [M]  fs/jfs/jfs_umount.o
  CC [M]  fs/jfs/jfs_xtree.o
  CC [M]  fs/jfs/jfs_imap.o
  CC [M]  fs/jfs/jfs_debug.o
  CC [M]  fs/jfs/jfs_dmap.o
  CC [M]  fs/jfs/jfs_unicode.o
  CC [M]  fs/jfs/jfs_dtree.o
  CC [M]  fs/jfs/jfs_inode.o
  CC [M]  fs/jfs/jfs_extent.o
  CC [M]  fs/jfs/symlink.o
  CC [M]  fs/jfs/jfs_metapage.o
  CC [M]  fs/jfs/jfs_logmgr.o
  CC [M]  fs/jfs/jfs_txnmgr.o
  CC [M]  fs/jfs/jfs_uniupr.o
  CC [M]  fs/jfs/resize.o
  CC [M]  fs/jfs/xattr.o
  LD [M]  fs/jfs/jfs.o
  CC [M]  fs/msdos/namei.o
  CC [M]  fs/msdos/msdosfs_syms.o
  LD [M]  fs/msdos/msdos.o
  CC [M]  fs/ncpfs/dir.o
  CC [M]  fs/ncpfs/file.o
  CC [M]  fs/ncpfs/inode.o
  CC [M]  fs/ncpfs/ioctl.o
  CC [M]  fs/ncpfs/mmap.o
  CC [M]  fs/ncpfs/ncplib_kernel.o
  CC [M]  fs/ncpfs/sock.o
  CC [M]  fs/ncpfs/ncpsign_kernel.o
  CC [M]  fs/ncpfs/getopt.o
  CC [M]  fs/ncpfs/symlink.o
  LD [M]  fs/ncpfs/ncpfs.o
  CC [M]  fs/nls/nls_cp775.o
  CC [M]  fs/nls/nls_iso8859-1.o
  CC [M]  fs/reiserfs/bitmap.o
  CC [M]  fs/reiserfs/do_balan.o
  CC [M]  fs/reiserfs/namei.o
  CC [M]  fs/reiserfs/inode.o
  CC [M]  fs/reiserfs/file.o
  CC [M]  fs/reiserfs/dir.o
  CC [M]  fs/reiserfs/fix_node.o
  CC [M]  fs/reiserfs/super.o
  CC [M]  fs/reiserfs/prints.o
  CC [M]  fs/reiserfs/objectid.o
  CC [M]  fs/reiserfs/lbalance.o
  CC [M]  fs/reiserfs/ibalance.o
  CC [M]  fs/reiserfs/stree.o
  CC [M]  fs/reiserfs/hashes.o
  CC [M]  fs/reiserfs/tail_conversion.o
  CC [M]  fs/reiserfs/journal.o
  CC [M]  fs/reiserfs/resize.o
  CC [M]  fs/reiserfs/item_ops.o
  CC [M]  fs/reiserfs/ioctl.o
  CC [M]  fs/reiserfs/procfs.o
  LD [M]  fs/reiserfs/reiserfs.o
  CC [M]  fs/romfs/inode.o
  LD [M]  fs/romfs/romfs.o
  CC [M]  fs/smbfs/proc.o
  CC [M]  fs/smbfs/dir.o
  CC [M]  fs/smbfs/cache.o
  CC [M]  fs/smbfs/sock.o
  CC [M]  fs/smbfs/inode.o
  CC [M]  fs/smbfs/file.o
  CC [M]  fs/smbfs/ioctl.o
  CC [M]  fs/smbfs/getopt.o
  CC [M]  fs/smbfs/symlink.o
  CC [M]  fs/smbfs/smbiod.o
  CC [M]  fs/smbfs/request.o
  LD [M]  fs/smbfs/smbfs.o
  CC [M]  fs/vfat/namei.o
  CC [M]  fs/vfat/vfatfs_syms.o
  LD [M]  fs/vfat/vfat.o
  CC [M]  drivers/char/agp/backend.o
  CC [M]  drivers/char/agp/frontend.o
  CC [M]  drivers/char/agp/generic.o
  CC [M]  drivers/char/agp/isoch.o
  LD [M]  drivers/char/agp/agpgart.o
  CC [M]  drivers/char/agp/uninorth-agp.o
  CC [M]  drivers/char/drm/radeon_drv.o
  CC [M]  drivers/char/drm/radeon_cp.o
  CC [M]  drivers/char/drm/radeon_state.o
  CC [M]  drivers/char/drm/radeon_mem.o
  CC [M]  drivers/char/drm/radeon_irq.o
  LD [M]  drivers/char/drm/radeon.o
  CC [M]  drivers/i2c/i2c-core.o
  CC [M]  drivers/i2c/i2c-dev.o
  CC [M]  drivers/i2c/busses/i2c-keywest.o
  CC [M]  drivers/net/sungem.o
  CC [M]  drivers/net/sungem_phy.o
  CC [M]  drivers/net/dgrs.o
  CC [M]  drivers/net/3c59x.o
  CC [M]  drivers/net/typhoon.o
  CC [M]  drivers/net/ne2k-pci.o
drivers/net/ne2k-pci.c:72:1: warning: "insl" redefined
In file included from include/asm/dma.h:12,
                 from include/asm/scatterlist.h:5,
                 from include/asm/pci.h:9,
                 from include/linux/pci.h:702,
                 from drivers/net/ne2k-pci.c:50:
include/asm/io.h:79:1: warning: this is the location of the previous definition
drivers/net/ne2k-pci.c:73:1: warning: "outsl" redefined
include/asm/io.h:80:1: warning: this is the location of the previous definition
  CC [M]  drivers/net/8390.o
  CC [M]  drivers/net/pcnet32.o
  CC [M]  drivers/net/eepro100.o
  CC [M]  drivers/net/tlan.o
  CC [M]  drivers/net/epic100.o
  CC [M]  drivers/net/sis900.o
  CC [M]  drivers/net/acenic.o
  CC [M]  drivers/net/natsemi.o
  CC [M]  drivers/net/tg3.o
  CC [M]  drivers/net/via-rhine.o
  CC [M]  drivers/net/mii.o
  CC [M]  drivers/net/sundance.o
  CC [M]  drivers/net/ppp_generic.o
  CC [M]  drivers/net/slhc.o
  CC [M]  drivers/net/ppp_async.o
  CC [M]  drivers/net/ppp_deflate.o
  CC [M]  drivers/net/pppox.o
  CC [M]  drivers/net/pppoe.o
  CC [M]  drivers/net/slip.o
  CC [M]  drivers/net/dummy.o
  CC [M]  drivers/net/8139too.o
  CC [M]  drivers/net/appletalk/ipddp.o
  CC [M]  drivers/net/e1000/e1000_main.o
  CC [M]  drivers/net/e1000/e1000_hw.o
  CC [M]  drivers/net/e1000/e1000_ethtool.o
  CC [M]  drivers/net/e1000/e1000_param.o
  LD [M]  drivers/net/e1000/e1000.o
  CC [M]  drivers/net/tokenring/olympic.o
  CC [M]  drivers/net/tokenring/lanstreamer.o
  CC [M]  drivers/net/wireless/orinoco.o
  CC [M]  drivers/net/wireless/hermes.o
  CC [M]  drivers/net/wireless/airport.o
  CC [M]  drivers/scsi/scsi.o
  CC [M]  drivers/scsi/hosts.o
  CC [M]  drivers/scsi/scsi_ioctl.o
  CC [M]  drivers/scsi/constants.o
  CC [M]  drivers/scsi/scsicam.o
  CC [M]  drivers/scsi/scsi_error.o
  CC [M]  drivers/scsi/scsi_lib.o
  CC [M]  drivers/scsi/scsi_scan.o
  CC [M]  drivers/scsi/scsi_syms.o
  CC [M]  drivers/scsi/scsi_sysfs.o
  CC [M]  drivers/scsi/scsi_devinfo.o
  CC [M]  drivers/scsi/scsi_sysctl.o
  LD [M]  drivers/scsi/scsi_mod.o
  CC [M]  drivers/usb/serial/usb-serial.o
  CC [M]  drivers/usb/serial/generic.o
  CC [M]  drivers/usb/serial/bus.o
  CC [M]  drivers/usb/serial/ezusb.o
  LD [M]  drivers/usb/serial/usbserial.o
  CC [M]  drivers/usb/serial/visor.o
  CC [M]  drivers/usb/serial/whiteheat.o
drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared (first use in this
function)
drivers/usb/serial/whiteheat.c:1209: (Each undeclared identifier is reported
only once
drivers/usb/serial/whiteheat.c:1209: for each function it appears in.)
make[3]: *** [drivers/usb/serial/whiteheat.o] Error 1
make[2]: *** [drivers/usb/serial] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2
[root@localhost linux-2.6.0]# 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.22-2a #2 Thu Sep 4 01:06:59 MDT 2003 ppc
ppc ppc GNU/Linux

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.22
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         dmasound_pmac dmasound_core i2c-core soundcore autofs
sungem sungem_phy ipt_REJECT iptable_filter ip_tables

Cpuinfo:
cpu		: 740/750
temperature 	: 32-35 C (uncalibrated)
clock		: 500MHz
revision	: 131.2 (pvr 0008 8302)
bogomips	: 996.14
machine		: PowerMac2,2
motherboard	: PowerMac2,2 MacRISC2 MacRISC Power Macintosh
board revision	: 00000001
detected as	: 66 (iMac FireWire)
pmac flags	: 00000005
L2 cache	: 512K unified
memory		: 384MB
pmac-generation	: NewWorld
Version:
Linux version 2.4.22-2a (dburcaw@skyfox.terraplex.com) (gcc version 3.2.2
20030217 (Yellow Dog Linux 3.0 3.2.2-2a)) #2 Thu Sep 4 01:06:59 MDT 2003
Modules:
dmasound_pmac          76096   0 (autoclean)
dmasound_core          15488   0 (autoclean) [dmasound_pmac]
i2c-core               19968   0 (autoclean) [dmasound_pmac]
soundcore               6920   3 (autoclean) [dmasound_core]
autofs                 13376   0 (autoclean) (unused)
sungem                 28144   0
sungem_phy              7600   0 [sungem]
ipt_REJECT              4432   6 (autoclean)
iptable_filter          2544   1 (autoclean)
ip_tables              17328   2 [ipt_REJECT iptable_filter]

PCI:
00:0b.0 Host bridge: Apple Computer Inc. UniNorth AGP
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, cache line size 08
        Capabilities: [80] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:10.0 Display controller: ATI Technologies Inc Rage 128 PR/PRO AGP 4x
TMDS
        Subsystem: ATI Technologies Inc Rage 128 PR/PRO AGP 4x TMDS
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at 94000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at 802400 [size=256]
        Region 2: Memory at 90000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at 90020000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

10:0b.0 Host bridge: Apple Computer Inc. UniNorth PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, cache line size 08

10:17.0 Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16, cache line size 08
        Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max)
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at 80081000 (32-bit, non-prefetchable) [size=4K]

10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (750ns min, 21500ns max)
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=4K]

20:0b.0 Host bridge: Apple Computer Inc. UniNorth Internal PCI
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 16, cache line size 08

20:0e.0 Class ffff: Apple Computer Inc. UniNorth FireWire (rev ff) (prog-if
ff)
        !!! Unknown header type 7f

20:0f.0 Class ffff: Apple Computer Inc. UniNorth GMAC (Sun GEM) (rev ff)
(prog-if ff)
        !!! Unknown header type 7f

SCSI:
Attached devices:none
-----------------------

LOOKING FOWARD TO HEARING FROM YOU AS SOON AS POSSIBLE...
YOURS SICERELY
MR. LEONIDAS JEGOROVAS


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135313AbREEUQe>; Sat, 5 May 2001 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbREEUQ1>; Sat, 5 May 2001 16:16:27 -0400
Received: from fsuj20.rz.uni-jena.de ([141.35.1.18]:217 "EHLO
	fsuj20.rz.uni-jena.de") by vger.kernel.org with ESMTP
	id <S135313AbREEUQM>; Sat, 5 May 2001 16:16:12 -0400
>Received: (from pfk@localhost)
	by fuchs.offl.uni-jena.de (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) id VAA15463;
	Sat, 5 May 2001 21:20:09 +0200
Date: Sat, 5 May 2001 21:20:09 +0200
From: Frank Klemm <pfk@fuchs.offl.uni-jena.de>
To: linux-kernel@vger.kernel.org, linux-kernel@vger.rutgers.edu
Subject: Next compile time problem ...
Message-ID: <20010505212009.A14529@fuchs.offl.uni-jena.de>
Mime-Version: 1.0
X-Mailer: Mutt 1.0.1i
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii


Compiling of kernel 2.4.3 stops:

Messages and .config are appended.


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=1

make -C  kernel CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  drivers CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  mm CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  fs CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  net CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  ipc CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  lib CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make -C  arch/i386/kernel CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/var/src/linux-2.4.3/drivers'
make -C block modules
make -C cdrom modules
make -C  arch/i386/mm CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/var/src/linux-2.4.3/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/kernel'
make -C  arch/i386/lib CFLAGS="-D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h" MAKING_MODULES=1 modules
make[1]: Entering directory `/var/src/linux-2.4.3/mm'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/mm'
make -C char modules
make[1]: Entering directory `/var/src/linux-2.4.3/net'
make -C ipv4 modules
make[1]: Entering directory `/var/src/linux-2.4.3/ipc'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/ipc'
make -C i2c modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/cdrom'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/cdrom'
make -C i2o modules
make[1]: Entering directory `/var/src/linux-2.4.3/lib'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/lib'
make -C ipx modules
make[1]: Entering directory `/var/src/linux-2.4.3/fs'
make -C adfs modules
make[1]: Entering directory `/var/src/linux-2.4.3/arch/i386/mm'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/arch/i386/mm'
make -C irda modules
make[1]: Entering directory `/var/src/linux-2.4.3/arch/i386/lib'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/arch/i386/lib'
make -C ide modules
make[2]: Entering directory `/var/src/linux-2.4.3/net/ipv4'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/net/ipv4'
make -C netlink modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/block'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/block'
make -C ieee1394 modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/i2o'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/i2o'
make -C input modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/i2c'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/i2c'
make -C md modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/adfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/adfs'
make -C affs modules
make[2]: Entering directory `/var/src/linux-2.4.3/net/netlink'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/net/netlink'
make -C sched modules
make[2]: Entering directory `/var/src/linux-2.4.3/net/irda'
make -C ircomm modules
make[2]: Entering directory `/var/src/linux-2.4.3/net/ipx'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/net/ipx'
make -C media modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/char'
make -C drm modules
make[1]: Entering directory `/var/src/linux-2.4.3/arch/i386/kernel'
make[1]: Nothing to be done for `modules'.
make[1]: Leaving directory `/var/src/linux-2.4.3/arch/i386/kernel'
make -C bfs modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/ide'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/ide'
make -C misc modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/media'
make -C radio modules
make[2]: Entering directory `/var/src/linux-2.4.3/net/sched'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/net/sched'
make -C irlan modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/ieee1394'
ld -m elf_i386 -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o hosts.o highlevel.o csr.o guid.o ieee1394_syms.o
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/ieee1394'
make -C mtd modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/input'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/input'
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/char/drm'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/char/drm'
make -C joystick modules
make -C net modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/misc'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/misc'
make -C parport modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/affs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/affs'
make -C efs modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/bfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/bfs'
make -C fat modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/md'
ld -m elf_i386 -r -o lvm-mod.o lvm.o lvm-snap.o
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/md'
make -C pcmcia modules
make[3]: Entering directory `/var/src/linux-2.4.3/net/irda/ircomm'
ld -m elf_i386  -r -o ircomm.o ircomm_core.o ircomm_event.o ircomm_lmp.o ircomm_ttp.o
ld -m elf_i386  -r -o ircomm-tty.o ircomm_tty.o ircomm_tty_attach.o ircomm_tty_ioctl.o ircomm_param.o
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/char/joystick'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/char/joystick'
make -C pcmcia modules
make[3]: Leaving directory `/var/src/linux-2.4.3/net/irda/ircomm'
make -C irnet modules
make[3]: Entering directory `/var/src/linux-2.4.3/net/irda/irlan'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/net/irda/irlan'
make -C video modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/mtd'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/mtd'
make -C pnp modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/parport'
ld -m elf_i386 -r -o parport.o share.o ieee1284.o ieee1284_ops.o init.o procfs.o daisy.o probe.o
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/media/radio'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/media/radio'
make -C hfs modules
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/parport'
make -C scsi modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/pcmcia'
ld -m elf_i386  -r -o pcmcia_core.o cistpl.o rsrc_mgr.o bulkmem.o cs.o cardbus.o
make[2]: Entering directory `/var/src/linux-2.4.3/fs/efs'
make[2]: Nothing to be done for `modules'.
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/net'
make -C irda modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/pnp'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/pnp'
make -C sound modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/fat'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/efs'
make -C hpfs modules
ld -m elf_i386  -r -o yenta_socket.o pci_socket.o yenta.o
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/char/pcmcia'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/char/pcmcia'
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/char'
make -C usb modules
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/fat'
make -C jffs modules
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/pcmcia'
make -C video modules
make[3]: Entering directory `/var/src/linux-2.4.3/net/irda/irnet'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/net/irda/irnet'
make[2]: Leaving directory `/var/src/linux-2.4.3/net/irda'
make[1]: Leaving directory `/var/src/linux-2.4.3/net'
make -C pcmcia modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/hfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/hfs'
make -C minix modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/media/video'
ld -m elf_i386  -r -o bttv.o bttv-driver.o bttv-cards.o bttv-if.o
ld -m elf_i386  -r -o zoran.o zr36120.o zr36120_i2c.o zr36120_mem.o
gcc -D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h   -c -o buz.o buz.c
make[2]: Entering directory `/var/src/linux-2.4.3/fs/hpfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/hpfs'
make -C msdos modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/usb'
make -C serial modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/net/irda'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/net/irda'
make -C sk98lin modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/jffs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/jffs'
make -C ncpfs modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/scsi'
ld -m elf_i386 -r -o sr_mod.o sr.o sr_ioctl.o sr_vendor.o
make -C pcmcia modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/net/pcmcia'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/net/pcmcia'
make -C skfp modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/video'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/video'
make -C nls modules
make[2]: Entering directory `/var/src/linux-2.4.3/drivers/sound'
ld -m elf_i386 -r -o sound.o dev_table.o soundcard.o sound_syms.o audio.o audio_syms.o dmabuf.o midi_syms.o midi_synth.o midibuf.o sequencer.o sequencer_syms.o sound_timer.o sys_timer.o
make[2]: Entering directory `/var/src/linux-2.4.3/fs/minix'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/minix'
make -C ntfs modules
ld -m elf_i386 -r -o sb_lib.o sb_common.o sb_audio.o sb_midi.o sb_mixer.o sb_ess.o
ld -m elf_i386 -r -o pas2.o pas2_card.o pas2_midi.o pas2_mixer.o pas2_pcm.o
make[2]: Entering directory `/var/src/linux-2.4.3/fs/msdos'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/msdos'
make -C qnx4 modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/scsi/pcmcia'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/scsi/pcmcia'
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/scsi'
make -C tulip modules
ld -m elf_i386 -r -o sb.o sb_card.o
ld -m elf_i386 -r -o wavefront.o wavfront.o wf_midi.o yss225.o
make[2]: Entering directory `/var/src/linux-2.4.3/fs/nls'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/nls'
make -C reiserfs modules
ld -m elf_i386 -r -o gus.o gus_card.o gus_midi.o gus_vol.o gus_wave.o ics2101.o
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/net/skfp'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/net/skfp'
make -C wan modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/ncpfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/ncpfs'
make -C romfs modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/net/sk98lin'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/net/sk98lin'
make -C smbfs modules
make -C cs4281 modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/usb/serial'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/usb/serial'
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/usb'
make -C sysv modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/ntfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/ntfs'
make -C udf modules
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/net/tulip'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/net/tulip'
make -C emu10k1 modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/qnx4'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/qnx4'
make -C ufs modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/reiserfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/reiserfs'
make -C umsdos modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/romfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/romfs'
make -C vfat modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/smbfs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/smbfs'
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/sound/cs4281'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/sound/cs4281'
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/net/wan'
gcc -D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h   -c -o dscc4.o dscc4.c
make -C lmc modules
make[2]: Entering directory `/var/src/linux-2.4.3/fs/sysv'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/sysv'
make[2]: Entering directory `/var/src/linux-2.4.3/fs/udf'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/udf'
make[2]: Entering directory `/var/src/linux-2.4.3/fs/ufs'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/ufs'
make[2]: Entering directory `/var/src/linux-2.4.3/fs/vfat'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/vfat'
make[2]: Entering directory `/var/src/linux-2.4.3/fs/umsdos'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/var/src/linux-2.4.3/fs/umsdos'
make[1]: Leaving directory `/var/src/linux-2.4.3/fs'
make[3]: Entering directory `/var/src/linux-2.4.3/drivers/sound/emu10k1'
make[3]: Nothing to be done for `modules'.
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/sound/emu10k1'
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/sound'
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this function
make[4]: Entering directory `/var/src/linux-2.4.3/drivers/net/wan/lmc'
make[4]: Nothing to be done for `modules'.
make[4]: Leaving directory `/var/src/linux-2.4.3/drivers/net/wan/lmc'
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this function
dscc4.c:1745: `PCI_VENDOR_ID_SIEMENS' undeclared here (not in a function)
dscc4.c:1745: initializer element is not constant
dscc4.c:1745: (near initialization for `dscc4_pci_tbl[0].vendor')
dscc4.c:1745: `PCI_DEVICE_ID_SIEMENS_DSCC4' undeclared here (not in a function)
dscc4.c:1745: initializer element is not constant
dscc4.c:1745: (near initialization for `dscc4_pci_tbl[0].device')
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [dscc4.o] Error 1
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/net/wan'
make[2]: *** [_modsubdir_wan] Error 2
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: *** Waiting for unfinished jobs....
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/var/src/linux-2.4.3/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/var/src/linux-2.4.3/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/var/src/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=m
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_DOC1000 is not set
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOCPROBE is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_JEDEC is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_MIXMEM is not set
# CONFIG_MTD_NORA is not set
# CONFIG_MTD_OCTAGON is not set
# CONFIG_MTD_PNC2000 is not set
# CONFIG_MTD_RPXLITE is not set
# CONFIG_MTD_VMAX is not set
# CONFIG_MTD_CHAR is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_PKT_TASK_IOCTL is not set
# CONFIG_IDE_TASK_IOCTL_DEBUG is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=4
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
CONFIG_SCSI_AHA1542=m
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
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
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
# CONFIG_SCSI_NCR53C7xx_sync is not set
# CONFIG_SCSI_NCR53C7xx_FAST is not set
# CONFIG_SCSI_NCR53C7xx_DISCONNECT is not set
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
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
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
CONFIG_IEEE1394_PCILYNX_PORTS=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_LANCE=m
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_WINBOND_840=m
CONFIG_HAPPYMEAL=m
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
CONFIG_ACENIC_OMIT_TIGON_I=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m
CONFIG_AIRONET4500=m
CONFIG_AIRONET4500_NONCS=m
CONFIG_AIRONET4500_PNP=y
CONFIG_AIRONET4500_PCI=y
CONFIG_AIRONET4500_ISA=y
CONFIG_AIRONET4500_I365=y
CONFIG_AIRONET4500_PROC=m

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
CONFIG_WAN=y
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
CONFIG_COMX=m
CONFIG_COMX_HW_COMX=m
CONFIG_COMX_HW_LOCOMX=m
CONFIG_COMX_HW_MIXCOM=m
CONFIG_COMX_PROTO_PPP=m
CONFIG_COMX_PROTO_FR=m
CONFIG_DSCC4=m
CONFIG_LANMEDIA=m
CONFIG_SEALEVEL_4021=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_HDLC=m
CONFIG_HDLC_PPP=y
CONFIG_N2=m
CONFIG_C101=m
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
# CONFIG_LAPBETHER is not set
# CONFIG_X25_ASY is not set
CONFIG_SBNI=m

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=m
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_PCMCIA_XIRTULIP is not set
CONFIG_NET_PCMCIA_RADIO=y
CONFIG_PCMCIA_RAYCS=m
# CONFIG_PCMCIA_HERMES is not set
# CONFIG_PCMCIA_NETWAVE is not set
# CONFIG_PCMCIA_WAVELAN is not set
CONFIG_AIRONET4500_CS=m

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1536
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1152
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=m
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
CONFIG_PCMCIA_SERIAL_CS=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CQCAM=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_STRADIS=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_BUZ=m
CONFIG_VIDEO_ZR36120=m

#
# Radio Adapters
#
CONFIG_RADIO_CADET=m
CONFIG_RADIO_RTRACK=m
CONFIG_RADIO_RTRACK2=m
CONFIG_RADIO_AZTECH=m
CONFIG_RADIO_GEMTEK=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_MAESTRO=m
CONFIG_RADIO_MIROPCM20=m
CONFIG_RADIO_SF16FMI=m
CONFIG_RADIO_TERRATEC=m
CONFIG_RADIO_TRUST=m
CONFIG_RADIO_TYPHOON=m
CONFIG_RADIO_TYPHOON_PROC_FS=y
CONFIG_RADIO_ZOLTRIX=m

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS_FS=m
CONFIG_JFFS_FS_VERBOSE=0
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
# CONFIG_SYSV_FS_WRITE is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_SPDIFLOOP=y
CONFIG_SOUND_CMPCI_4CH=y
CONFIG_SOUND_CMPCI_REAR=y
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=y
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
# CONFIG_MSNDCLAS_HAVE_BOOT is not set
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
# CONFIG_MSNDPIN_HAVE_BOOT is not set
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
# CONFIG_SOUND_GUS16 is not set
# CONFIG_SOUND_GUSMAX is not set
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_MAD16_OLDCARD=y
CONFIG_SOUND_PAS=m
# CONFIG_PAS_JOYSTICK is not set
CONFIG_SOUND_PSS=m
# CONFIG_PSS_MIXER is not set
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
# CONFIG_SC6600 is not set
# CONFIG_AEDSP16_SBPRO is not set
# CONFIG_AEDSP16_MSS is not set
# CONFIG_AEDSP16_MPU401 is not set
CONFIG_SOUND_TVMIXER=m

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=m
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_WACOM=m
CONFIG_USB_DC2XX=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
CONFIG_USB_DSBR=m
CONFIG_USB_DABUSB=m
CONFIG_USB_PLUSB=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_NET1080=m
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_RIO500=m

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set

--rwEMma7ioTxnRzrJ--


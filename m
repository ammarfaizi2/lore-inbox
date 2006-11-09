Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424182AbWKISIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424182AbWKISIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424183AbWKISIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:08:13 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:17637 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1424181AbWKISIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:08:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lv1z9f5R5ik+iDcgsVXgbNWSufKW9bQc1vQH3tsZfuXUQ3Y2fmLA8ta1PBxey1cbi8NR2TCZpy1lrwergP8mWgDqedIAqGG6PnpLSfA/VWmos0XWfjy9fiXV/ZUNrJQThchinc9447Hp3uAlYUJw2OqnTbeooisYkQxQ/V65uKo=
Message-ID: <d9a083460611091008g38d22e78ob0748e5aee959da1@mail.gmail.com>
Date: Thu, 9 Nov 2006 19:08:10 +0100
From: Jano <jasieczek@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: Problems with mounting filesystems from /dev/hdb (kernel 2.6.18.1)
Cc: "Phillip Susi" <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <45536CCF.4020209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d9a083460611081439v2eacb065nef62f129d2d9c9c0@mail.gmail.com>
	 <4af2d03a0611090320m5d8316a7l86b42cde888a4fd@mail.gmail.com>
	 <45534B31.50008@cfl.rr.com> <45534D2C.6080509@gmail.com>
	 <455360CF.9070600@cfl.rr.com>
	 <d9a083460611090922j75b97cd4u6cc53eeee52b2344@mail.gmail.com>
	 <45536CCF.4020209@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/9, Jiri Slaby <jirislaby@gmail.com>:
>
> Hmm, both should be sufficient, however initrd seems to be not loaded. What does
> your grub config says and could you zcat [initrd] | cpio -t (or whatever it is
> packed by)?
>

$ zcat /boot/initrd.img-2.6.18.1 | cpio -t
.
bin
bin/cat
bin/chroot
bin/dd
bin/false
bin/fstype
bin/gunzip
bin/gzip
bin/insmod
bin/ipconfig
bin/kinit
bin/ln
bin/minips
bin/mkdir
bin/mkfifo
bin/mount
bin/nfsmount
bin/nuke
bin/pivot_root
bin/run-init
bin/sh.shared
bin/sleep
bin/true
bin/umount
bin/uname
bin/zcat
bin/sh
bin/busybox
conf
conf/conf.d
conf/conf.d/resume
conf/arch.conf
conf/initramfs.conf
conf/modules
etc
etc/modprobe.d
etc/modprobe.d/aliases
etc/modprobe.d/alsa-base
etc/modprobe.d/apm
etc/modprobe.d/arch
etc/modprobe.d/arch/i386
etc/modprobe.d/arch-aliases
etc/modprobe.d/blacklist
etc/modprobe.d/blacklist-framebuffer
etc/modprobe.d/blacklist-modem
etc/modprobe.d/blacklist-oss
etc/modprobe.d/blacklist-scanner
etc/modprobe.d/blacklist-watchdog
etc/modprobe.d/bluez
etc/modprobe.d/ibm_acpi.modprobe
etc/modprobe.d/ipw3945
etc/modprobe.d/isapnp
etc/modprobe.d/nvidia-kernel-nkc
etc/modprobe.d/options
etc/modprobe.d/toshiba_acpi.modprobe
etc/evms.conf
etc/udev
etc/udev/udev.conf
etc/udev/rules.d
etc/udev/rules.d/00-init.rules
etc/udev/rules.d/20-names.rules
etc/udev/rules.d/65-persistent-disk.rules
etc/udev/rules.d/90-modprobe.rules
lib
lib/modules
lib/modules/2.6.18.1
lib/modules/2.6.18.1/kernel
lib/modules/2.6.18.1/kernel/drivers
lib/modules/2.6.18.1/kernel/drivers/md
lib/modules/2.6.18.1/kernel/drivers/md/md-mod.ko
lib/modules/2.6.18.1/kernel/drivers/md/raid0.ko
lib/modules/2.6.18.1/kernel/drivers/md/raid1.ko
lib/modules/2.6.18.1/kernel/drivers/md/dm-mod.ko
lib/modules/2.6.18.1/kernel/drivers/md/linear.ko
lib/modules/2.6.18.1/kernel/drivers/usb
lib/modules/2.6.18.1/kernel/drivers/usb/core
lib/modules/2.6.18.1/kernel/drivers/usb/core/usbcore.ko
lib/modules/2.6.18.1/kernel/drivers/usb/host
lib/modules/2.6.18.1/kernel/drivers/usb/host/ehci-hcd.ko
lib/modules/2.6.18.1/kernel/drivers/usb/input
lib/modules/2.6.18.1/kernel/drivers/usb/input/usbhid.ko
lib/modules/2.6.18.1/kernel/drivers/usb/storage
lib/modules/2.6.18.1/kernel/drivers/usb/storage/usb-storage.ko
lib/modules/2.6.18.1/kernel/drivers/scsi
lib/modules/2.6.18.1/kernel/drivers/scsi/scsi_mod.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/3w-xxxx.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/aacraid
lib/modules/2.6.18.1/kernel/drivers/scsi/aacraid/aacraid.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/scsi_transport_spi.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/aic7xxx
lib/modules/2.6.18.1/kernel/drivers/scsi/aic7xxx/aic79xx.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/aic7xxx/aic7xxx.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/atp870u.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/BusLogic.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/ch.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/dmx3191d.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/dpt_i2o.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/eata.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/fdomain.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/gdth.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/initio.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/ips.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/nsp32.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/osst.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/qla1280.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/libata.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/sata_promise.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/sata_svw.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/sata_via.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/sata_vsc.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/sd_mod.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/sym53c8xx_2
lib/modules/2.6.18.1/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko
lib/modules/2.6.18.1/kernel/drivers/scsi/tmscsim.ko
lib/modules/2.6.18.1/kernel/drivers/net
lib/modules/2.6.18.1/kernel/drivers/net/3c59x.ko
lib/modules/2.6.18.1/kernel/drivers/net/8139too.ko
lib/modules/2.6.18.1/kernel/drivers/net/8390.ko
lib/modules/2.6.18.1/kernel/drivers/net/b44.ko
lib/modules/2.6.18.1/kernel/drivers/net/dl2k.ko
lib/modules/2.6.18.1/kernel/drivers/net/e1000
lib/modules/2.6.18.1/kernel/drivers/net/e1000/e1000.ko
lib/modules/2.6.18.1/kernel/drivers/net/e100.ko
lib/modules/2.6.18.1/kernel/drivers/net/epic100.ko
lib/modules/2.6.18.1/kernel/drivers/net/fealnx.ko
lib/modules/2.6.18.1/kernel/drivers/net/forcedeth.ko
lib/modules/2.6.18.1/kernel/drivers/net/hp100.ko
lib/modules/2.6.18.1/kernel/drivers/net/natsemi.ko
lib/modules/2.6.18.1/kernel/drivers/net/ne2k-pci.ko
lib/modules/2.6.18.1/kernel/drivers/net/ns83820.ko
lib/modules/2.6.18.1/kernel/drivers/net/pcnet32.ko
lib/modules/2.6.18.1/kernel/drivers/net/r8169.ko
lib/modules/2.6.18.1/kernel/drivers/net/sis900.ko
lib/modules/2.6.18.1/kernel/drivers/net/slhc.ko
lib/modules/2.6.18.1/kernel/drivers/net/starfire.ko
lib/modules/2.6.18.1/kernel/drivers/net/sundance.ko
lib/modules/2.6.18.1/kernel/drivers/net/sunhme.ko
lib/modules/2.6.18.1/kernel/drivers/net/tg3.ko
lib/modules/2.6.18.1/kernel/drivers/net/tlan.ko
lib/modules/2.6.18.1/kernel/drivers/cdrom
lib/modules/2.6.18.1/kernel/drivers/cdrom/cdrom.ko
lib/modules/2.6.18.1/kernel/drivers/ide
lib/modules/2.6.18.1/kernel/drivers/ide/ide-cd.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci
lib/modules/2.6.18.1/kernel/drivers/ide/pci/aec62xx.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/alim15x3.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/amd74xx.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/atiixp.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/cmd64x.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/cs5530.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/cy82c693.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/generic.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/hpt34x.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/hpt366.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/ns87415.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/pdc202xx_new.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/pdc202xx_old.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/piix.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/rz1000.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/sc1200.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/serverworks.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/siimage.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/sis5513.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/slc90e66.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/triflex.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/trm290.ko
lib/modules/2.6.18.1/kernel/drivers/ide/pci/via82cxxx.ko
lib/modules/2.6.18.1/kernel/drivers/block
lib/modules/2.6.18.1/kernel/drivers/block/cpqarray.ko
lib/modules/2.6.18.1/kernel/drivers/video
lib/modules/2.6.18.1/kernel/drivers/video/cfbfillrect.ko
lib/modules/2.6.18.1/kernel/drivers/video/cfbimgblt.ko
lib/modules/2.6.18.1/kernel/drivers/video/vgastate.ko
lib/modules/2.6.18.1/kernel/drivers/video/cfbcopyarea.ko
lib/modules/2.6.18.1/kernel/drivers/video/fb.ko
lib/modules/2.6.18.1/kernel/drivers/video/vga16fb.ko
lib/modules/2.6.18.1/kernel/net
lib/modules/2.6.18.1/kernel/net/sunrpc
lib/modules/2.6.18.1/kernel/net/sunrpc/sunrpc.ko
lib/modules/2.6.18.1/kernel/net/packet
lib/modules/2.6.18.1/kernel/net/packet/af_packet.ko
lib/modules/2.6.18.1/kernel/net/unix
lib/modules/2.6.18.1/kernel/net/unix/unix.ko
lib/modules/2.6.18.1/kernel/fs
lib/modules/2.6.18.1/kernel/fs/lockd
lib/modules/2.6.18.1/kernel/fs/lockd/lockd.ko
lib/modules/2.6.18.1/kernel/fs/nfs
lib/modules/2.6.18.1/kernel/fs/nfs/nfs.ko
lib/klibc-t2jM36h7OcxUNTDzncfER2p7kd4.so
lib/libc.so.6
lib/ld-linux.so.2
lib/libevms-2.5.so.0
lib/libpthread.so.0
lib/libdl.so.2
lib/evms
lib/evms/2.5.4
lib/evms/2.5.4/bbr-1.1.14.so
lib/evms/2.5.4/bbr_seg-1.1.12.so
lib/evms/2.5.4/bsd-1.0.8.so
lib/evms/2.5.4/disk-1.2.12.so
lib/evms/2.5.4/dos-1.1.15.so
lib/evms/2.5.4/drivelink-3.0.6.so
lib/evms/2.5.4/gpt-1.1.11.so
lib/evms/2.5.4/lvm2-1.0.4.so
lib/evms/2.5.4/mac-1.0.8.so
lib/evms/2.5.4/md-1.1.19.so
lib/evms/2.5.4/multipath-1.0.4.so
lib/libuuid.so.1
lib/libselinux.so.1
lib/libsepol.so.1
lib/udev
lib/udev/dvb_device_name
lib/udev/usb_device_name
lib/udev/ata_id
lib/udev/edd_id
lib/udev/usb_id
lib/udev/vol_id
lib/udev/dasd_id
lib/udev/scsi_id
lib/udev/path_id
lib/udev/pnp_modules
lib/udev/ide_media
lib/udev/vio_type
lib/libdevmapper.so.1.02
lib/libreadline.so.5
lib/libncurses.so.5
modules
sbin
sbin/modprobe
sbin/depmod
sbin/rmmod
sbin/evms_activate
sbin/udevd
sbin/udevplug
sbin/usplash
sbin/usplash_write
sbin/mdadm
sbin/mdrun
sbin/vgchange
scripts
scripts/casper-premount
scripts/casper-premount/udev
scripts/functions
scripts/init-bottom
scripts/init-bottom/udev
scripts/init-premount
scripts/init-premount/thermal
scripts/init-premount/udev
scripts/init-top
scripts/init-top/framebuffer
scripts/init-top/usplash
scripts/local
scripts/local-bottom
scripts/local-premount
scripts/local-premount/suspend
scripts/local-top
scripts/local-top/evms
scripts/local-top/lvm
scripts/local-top/md
scripts/local-top/udev
scripts/nfs
scripts/nfs-bottom
scripts/nfs-premount
scripts/nfs-top
scripts/nfs-top/udev
init
usr
usr/lib
usr/lib/usplash
usr/lib/usplash/usplash-artwork.so

>
> Is the real reason EBUSY (as it should be) -- could you strace your mount command?
>

"EBUSY", "strace"? Excuse me? Could you paraphrase it somehow (sorry
if it's a newbie-like question)? If you mean that /home is busy, then
no, it is not.

# lsof | grep home

doesn't output a single line.

>
> I'm clueless now, sorry.
>

Do not lose your faith - it can be done ;).

Best regards,
Jano
-- 
Mail 	jano at stepien com pl
Jabber 	jano at jabber aster pl
GG 	1894343
Web	http://stepien.com.pl

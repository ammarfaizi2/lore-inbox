Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQKFOq1>; Mon, 6 Nov 2000 09:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKFOqH>; Mon, 6 Nov 2000 09:46:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129049AbQKFOqD>; Mon, 6 Nov 2000 09:46:03 -0500
Date: Mon, 6 Nov 2000 09:45:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.0-test9 
In-Reply-To: <6695.973335327@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.95.1001106093040.696A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2000, Keith Owens wrote:

> On Fri, 3 Nov 2000 17:54:51 -0500 (EST), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >(1)	I have SCSI modules that have to be installed upon boot
> >from initrd. Insmod failed with "Can't find the kernel version that
> >this module was compiled with..."
> 
> "Can't find the kernel version that this module was compiled with..."
> means that the module object does not contain symbol __module_kernel_version.
> What does 'nm' on the module report?
> 

Script started on Mon Nov  6 09:23:59 2000

# nm /lib/modules/2.4.0/kernel/drivers/scsi/BusLogic.o
0000005c d AnnouncementLines.867
00000058 d BeginningOfLine.866
00000000 b Buffer.865
000002e8 b BusLogic
00003fd0 T BusLogic_AbortCommand
000024e0 t BusLogic_AcquireResources
00000310 t BusLogic_AllocateCCB
00000000 t BusLogic_AnnounceDriver
00000750 t BusLogic_AppendProbeAddressISA
00004800 T BusLogic_BIOSDiskParameters
00001500 t BusLogic_CheckHostAdapter
000003e0 t BusLogic_Command
00000300 b BusLogic_CommandFailureReason
000032a0 t BusLogic_ComputeResultCode
00000230 t BusLogic_CreateAdditionalCCBs
00000170 t BusLogic_CreateInitialCCBs
000003b0 t BusLogic_DeallocateCCB
000001e0 t BusLogic_DestroyCCBs
00002eb0 T BusLogic_DetectHostAdapter
00000030 T BusLogic_DriverInfo
00000068 b BusLogic_DriverOptions
00000064 b BusLogic_DriverOptionsCount
00000050 d BusLogic_ErrorRecoveryStrategyLetters
00000040 d BusLogic_ErrorRecoveryStrategyNames
00001230 t BusLogic_Failure
000002f0 b BusLogic_FirstRegisteredHostAdapter
000002ee b BusLogic_GlobalOptions
00001370 t BusLogic_HardwareResetHostAdapter
00000014 d BusLogic_HostAdapterAddressCount
00000020 d BusLogic_HostAdapterBusNames
00000038 d BusLogic_HostAdapterBusTypes
00000100 t BusLogic_InitializeCCBs
00000fc0 t BusLogic_InitializeFlashPointProbeInfo
000025f0 t BusLogic_InitializeHostAdapter
00002cb0 t BusLogic_InitializeHostStructure
000009d0 t BusLogic_InitializeMultiMasterProbeInfo
00001090 t BusLogic_InitializeProbeInfoList
00000780 t BusLogic_InitializeProbeInfoListISA
000038c0 t BusLogic_InterruptHandler
000002f4 b BusLogic_LastRegisteredHostAdapter
000050d0 t BusLogic_Message
00000000 d BusLogic_MessageLevelMap
00005270 t BusLogic_ParseDriverOptions
00005220 t BusLogic_ParseKeyword
000012d0 t BusLogic_ProbeHostAdapter
000002f8 b BusLogic_ProbeInfoCount
000002fc b BusLogic_ProbeInfoList
000002ec b BusLogic_ProbeOptions
00004a20 T BusLogic_ProcDirectoryInfo
000034b0 t BusLogic_ProcessCompletedCCBs
00003a10 T BusLogic_QueueCommand
00003250 t BusLogic_QueueCompletedCCB
00001570 t BusLogic_ReadHostAdapterConfiguration
00000040 t BusLogic_RegisterHostAdapter
00003210 T BusLogic_ReleaseHostAdapter
000025c0 t BusLogic_ReleaseResources
00001df0 t BusLogic_ReportHostAdapterConfiguration
00002ae0 t BusLogic_ReportTargetDeviceInfo
000046d0 T BusLogic_ResetCommand
00004150 t BusLogic_ResetHostAdapter
00003420 t BusLogic_ScanIncomingMailboxes
00002d10 t BusLogic_SelectQueueDepths
00004460 t BusLogic_SendBusDeviceReset
00005ae0 t BusLogic_Setup
00000910 t BusLogic_SortProbeInfo
00002810 t BusLogic_TargetDeviceInquiry
00000090 t BusLogic_UnregisterHostAdapter
00003970 t BusLogic_WriteOutgoingMailbox
00000054 d SerialNumber.790
         U __brelse
         U __check_region
         U __const_udelay
         U __global_cli
         U __global_restore_flags
         U __global_save_flags
         U __global_sti
00000000 ? __module_kernel_version
00000015 ? __module_parm_BusLogic
         U __release_region
         U __request_region
         U __this_module
         U bread
00005bb0 T cleanup_module
00000060 d driver_template
00005b90 t exit_this_scsi_driver
         U free_dma
         U free_irq
00000000 t gcc2_compiled.
         U get_options
         U high_memory
00005ba0 T init_module
00005b40 t init_this_scsi_driver
         U io_request_lock
         U ioport_resource
         U jiffies
         U kfree
         U kmalloc
         U pci_enable_device
         U pci_find_device
         U pcibios_present
         U printk
         U request_dma
         U request_irq
         U scsi_mark_host_reset
         U scsi_register
         U scsi_register_module
         U scsi_unregister
         U scsi_unregister_module
         U simple_strtoul
         U sprintf
         U vsprintf

# depmod -a
# modprobe -c
# Generated by modprobe -c (2.3.15)
path[boot]=/lib/modules/boot
path[kernel]=/lib/modules/2.4.0/kernel
path[fs]=/lib/modules/2.4.0/fs
path[net]=/lib/modules/2.4.0/net
path[scsi]=/lib/modules/2.4.0/scsi
path[block]=/lib/modules/2.4.0/block
path[cdrom]=/lib/modules/2.4.0/cdrom
path[ipv4]=/lib/modules/2.4.0/ipv4
path[ipv6]=/lib/modules/2.4.0/ipv6
path[sound]=/lib/modules/2.4.0/sound
path[fc4]=/lib/modules/2.4.0/fc4
path[video]=/lib/modules/2.4.0/video
path[misc]=/lib/modules/2.4.0/misc
path[pcmcia]=/lib/modules/2.4.0/pcmcia
path[atm]=/lib/modules/2.4.0/atm
path[usb]=/lib/modules/2.4.0/usb
path[ide]=/lib/modules/2.4.0/ide
path[ieee1394]=/lib/modules/2.4.0/ieee1394
path[mtd]=/lib/modules/2.4.0/mtd
path[kernel]=/lib/modules/2.4/kernel
path[fs]=/lib/modules/2.4/fs
path[net]=/lib/modules/2.4/net
path[scsi]=/lib/modules/2.4/scsi
path[block]=/lib/modules/2.4/block
path[cdrom]=/lib/modules/2.4/cdrom
path[ipv4]=/lib/modules/2.4/ipv4
path[ipv6]=/lib/modules/2.4/ipv6
path[sound]=/lib/modules/2.4/sound
path[fc4]=/lib/modules/2.4/fc4
path[video]=/lib/modules/2.4/video
path[misc]=/lib/modules/2.4/misc
path[pcmcia]=/lib/modules/2.4/pcmcia
path[atm]=/lib/modules/2.4/atm
path[usb]=/lib/modules/2.4/usb
path[ide]=/lib/modules/2.4/ide
path[ieee1394]=/lib/modules/2.4/ieee1394
path[mtd]=/lib/modules/2.4/mtd
path[kernel]=/lib/modules/default/kernel
path[fs]=/lib/modules/default/fs
path[net]=/lib/modules/default/net
path[scsi]=/lib/modules/default/scsi
path[block]=/lib/modules/default/block
path[cdrom]=/lib/modules/default/cdrom
path[ipv4]=/lib/modules/default/ipv4
path[ipv6]=/lib/modules/default/ipv6
path[sound]=/lib/modules/default/sound
path[fc4]=/lib/modules/default/fc4
path[video]=/lib/modules/default/video
path[misc]=/lib/modules/default/misc
path[pcmcia]=/lib/modules/default/pcmcia
path[atm]=/lib/modules/default/atm
path[usb]=/lib/modules/default/usb
path[ide]=/lib/modules/default/ide
path[ieee1394]=/lib/modules/default/ieee1394
path[mtd]=/lib/modules/default/mtd
path[kernel]=/lib/modules/kernel
path[fs]=/lib/modules/fs
path[net]=/lib/modules/net
path[scsi]=/lib/modules/scsi
path[block]=/lib/modules/block
path[cdrom]=/lib/modules/cdrom
path[ipv4]=/lib/modules/ipv4
path[ipv6]=/lib/modules/ipv6
path[sound]=/lib/modules/sound
path[fc4]=/lib/modules/fc4
path[video]=/lib/modules/video
path[misc]=/lib/modules/misc
path[pcmcia]=/lib/modules/pcmcia
path[atm]=/lib/modules/atm
path[usb]=/lib/modules/usb
path[ide]=/lib/modules/ide
path[ieee1394]=/lib/modules/ieee1394
path[mtd]=/lib/modules/mtd
# Prune
prune modules.dep
prune modules.pcimap
prune System.map
prune .config
prune build
# Aliases
alias binfmt-204 binfmt_aout
alias binfmt-263 binfmt_aout
alias binfmt-264 binfmt_aout
alias binfmt-267 binfmt_aout
alias binfmt-387 binfmt_aout
alias binfmt-332 iBCS
alias binfmt--310 binfmt_java
alias block-major-1 rd
alias block-major-2 floppy
alias block-major-3 ide-probe
alias block-major-7 loop
alias block-major-8 sd_mod
alias block-major-9 md
alias block-major-11 sr_mod
alias block-major-13 xd
alias block-major-15 cdu31a
alias block-major-16 gscd
alias block-major-17 optcd
alias block-major-18 sjcd
alias block-major-20 mcdx
alias block-major-22 ide-probe
alias block-major-23 mcd
alias block-major-24 sonycd535
alias block-major-25 sbpcd
alias block-major-26 sbpcd
alias block-major-27 sbpcd
alias block-major-29 aztcd
alias block-major-32 cm206
alias block-major-33 ide-probe
alias block-major-34 ide-probe
alias block-major-37 ide-tape
alias block-major-44 ftl
alias block-major-93 nftl
alias char-major-4 serial
alias char-major-5 serial
alias char-major-6 lp
alias char-major-9 st
alias char-major-10 misc
alias char-major-10-0 busmouse
alias char-major-10-1 psaux
alias char-major-10-2 msbusmouse
alias char-major-10-3 atixlmouse
alias char-major-10-130 wdt
alias char-major-10-131 wdt
alias char-major-10-135 off
alias char-major-10-139 openprom
alias char-major-10-144 nvram
alias char-major-10-157 applicom
alias char-major-10-175 agpgart
alias char-major-14 sound
alias char-major-19 cyclades
alias char-major-20 cyclades
alias char-major-21 sg
alias char-major-22 pcxx
alias char-major-23 pcxx
alias char-major-27 ftape
alias char-major-34 scc
alias char-major-35 tclmidi
alias char-major-36 netlink
alias char-major-37 ide-tape
alias char-major-48 riscom8
alias char-major-49 riscom8
alias char-major-57 esp
alias char-major-58 esp
alias char-major-63 kdebug
alias char-major-90 mtdchar
alias char-major-99 ppdev
alias char-major-107 3dfx
alias dos msdos
alias dummy0 dummy
alias dummy1 dummy
alias eth0 3c59x
alias iso9660 isofs
alias md-personality-1 linear
alias md-personality-2 raid0
alias md-personality-3 raid1
alias md-personality-4 raid5
alias net-pf-1 unix
alias net-pf-2 ipv4
alias net-pf-3 off
alias net-pf-4 ipx
alias net-pf-5 appletalk
alias net-pf-6 off
alias net-pf-17 af_packet
alias net-pf-19 off
alias netalias-2 ip_alias
alias plip0 plip
alias plip1 plip
alias ppp0 ppp
alias ppp1 ppp
alias scsi_hostadapter BusLogic
alias slip0 slip
alias slip1 slip
alias tty-ldisc-1 slip
alias tty-ldisc-3 ppp
alias ppp-compress-21 bsd_comp
alias ppp-compress-24 ppp_deflate
alias ppp-compress-26 ppp_deflate
alias parport_lowlevel parport_pc
alias binfmt-2 binfmt_aout
alias binfmt-0064 binfmt_aout
alias binfmt-0107 binfmt_aout
alias char-major-127 device
alias char-major-108 ppp-generic
alias dsn0 /lib/modules/net/dosnet
# Options
options dummy0 -o dummy0
options dummy1 -o dummy1
options sb io=0x220 irq=7 dma=1 dma16=5 mpu_io=0x330
# exit
exit

Script done on Mon Nov  6 09:24:34 2000


> >modutils, downloaded and installed today. Also `insmod -f` doesn't
> >work (not a kernel problem, yes, I know).
> 
> Does not work how?  Details please.
> 

According to the documentation '-f' should force the loading of a
module if there is a version mismatch. It doesn't.


> >The only fix I could come up with was to remove EXTRAVERSION=test9 in
> >the top-level Makefile (actually set it to nothing), then recompile
> >the whole kernel. This problem will get others, I am sure.
> 
> I suspect user error, probably old modules lying around somewhere.  A
> compile out of the box for 2.4.0-test9 worked fine for me and AFAICT
> for everybody else.
> 

There is no 'user-error'. The modules that are to be installed during
the initrd process are modules copied by my script from the
new module directory structure. The modules are found, they are
copied, and, during the boot process `insmod` attempts to install them.

If the kernel version number is 2.4.0, everything works fine.
If the kernel version number is 2.4.0-test9, `insmod` fails to find
the kernel version number ...

The kernel version number was changed ONLY by getting rid of "test-9"
in the Makefile and doing:

cp .config ..
make distclean
cp ../.config .
make oldconfig
make dep
make bzImage
make modules
make modules_install


In this manner, nothing was changed except the kernel version number.

The initrd script for making a floppy to try to boot from initrd is:

#!/bin/bash
#
#	This installs the kernel on a system that requires an initial
#	RAM Disk and with an initial SCSI driver.
#

export VER=$1
RAMDISK_DEVICE=/dev/ram0
RAMDISK_MOUNT=/tmp/Ramdisk
RAMDISK_TMP=/mnt
DISKSIZE=1500
SYS=/usr/src/linux-${VER}/arch/i386/boot/bzImage
MAP=/usr/src/linux-${VER}/System.map
if [ "$1" = "" ] ;
   then
       echo "Usage:"
       echo "make_ramdisk <version>"
       exit 1
fi
if [ ! -f ${SYS} ] ;
   then
    echo "File not found, ${SYS}"
    exit 1
fi
if [ ! -f ${MAP} ] ;
   then
    echo "File not found, ${MAP}"
    exit 1
fi
if ! depmod -a ${VER} ;
   then
      echo "This won't work!  There are some unresolved symbols."
      exit 1
fi
mkdir  ${RAMDISK_TMP}    2>/dev/null
umount ${RAMDISK_DEVICE} 2>/dev/null
umount ${RAMDISK_MOUNT}  2>/dev/null
mkdir  ${RAMDISK_MOUNT}  2>/dev/null
dd if=/dev/zero of=${RAMDISK_DEVICE} bs=1k count=${DISKSIZE}
mke2fs -q ${RAMDISK_DEVICE} ${DISKSIZE}
mount -o loop ${RAMDISK_DEVICE} ${RAMDISK_MOUNT}
mke2fs -q /dev/fd0
mount /dev/fd0 ${RAMDISK_TMP}
rmdir ${RAMDISK_MOUNT}/lost+found 
rmdir ${RAMDISK_TMP}/lost+found 
mkdir ${RAMDISK_MOUNT}/dev
mkdir ${RAMDISK_MOUNT}/etc
mkdir ${RAMDISK_MOUNT}/lib
mkdir ${RAMDISK_MOUNT}/bin
mknod ${RAMDISK_MOUNT}/dev/null   c 1 3
mknod ${RAMDISK_MOUNT}/dev/ram0   b 1 0 
mknod ${RAMDISK_MOUNT}/dev/ram1   b 1 1
mknod ${RAMDISK_MOUNT}/dev/tty0   c 4 0
mknod ${RAMDISK_MOUNT}/dev/tty1   c 4 1
mknod ${RAMDISK_MOUNT}/dev/tty2   c 4 2
mknod ${RAMDISK_MOUNT}/dev/tty3   c 4 3
mknod ${RAMDISK_MOUNT}/dev/tty4   c 4 4
ln -s /dev/tty0 ${RAMDISK_MOUNT}/dev/systty
ln -s /dev/tty0 ${RAMDISK_MOUNT}/dev/console
ln -s /dev/ram1 ${RAMDISK_MOUNT}/dev/ram
ln -s /         ${RAMDISK_MOUNT}/dev/root
cp /bin/ash.static ${RAMDISK_MOUNT}/bin/sh
cp /sbin/insmod.static ${RAMDISK_MOUNT}/bin/insmod
#cp /sbin/modprobe-static ${RAMDISK_MOUNT}/bin/modprobe
cp /lib/modules/${VER}/kernel/drivers/scsi/BusLogic.o ${RAMDISK_MOUNT}/lib
cp /lib/modules/${VER}/kernel/drivers/scsi/scsi_mod.o ${RAMDISK_MOUNT}/lib
cp /lib/modules/${VER}/kernel/drivers/scsi/sd_mod.o   ${RAMDISK_MOUNT}/lib
cat >${RAMDISK_MOUNT}/linuxrc <<EOF
#!/bin/sh
/bin/insmod -f /lib/scsi_mod.o
/bin/insmod -f /lib/BusLogic.o
/bin/insmod -f /lib/sd_mod.o
EOF
chmod +x ${RAMDISK_MOUNT}/linuxrc
df ${RAMDISK_MOUNT}
sync
umount ${RAMDISK_MOUNT}
rmdir  ${RAMDISK_MOUNT} 
dd if=${RAMDISK_DEVICE} bs=1k count=${DISKSIZE} | gzip >${RAMDISK_TMP}/initrd-${VER}
cp ${SYS} ${RAMDISK_TMP}/vmlinuz-${VER}
cp ${MAP} ${RAMDISK_TMP}/System.map-${VER}
cp /boot/boot.b ${RAMDISK_TMP}
#
lilo -C - <<EOF
#
#  Lilo boot-configuration script.
#
boot    = /dev/fd0
map     = ${RAMDISK_TMP}/map
install = ${RAMDISK_TMP}/boot.b
backup  = /dev/null
compact
delay = 15	# optional, for systems that boot very quickly
vga = normal	# force sane state
  image = ${RAMDISK_TMP}/vmlinuz-${VER}
  root  = current
  label =  Linux 
  initrd = ${RAMDISK_TMP}/initrd-${VER}
EOF
umount ${RAMDISK_TMP}


`insmod.static` is the latest version of `insmod`, statically linked.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

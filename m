Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135181AbREHWlh>; Tue, 8 May 2001 18:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135548AbREHWlT>; Tue, 8 May 2001 18:41:19 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:38698 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S135181AbREHWlA>; Tue, 8 May 2001 18:41:00 -0400
Message-ID: <041001c0d80f$ff7d88a0$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Subject: `smp_num_cpus' undeclared in 2.4.3
Date: Tue, 8 May 2001 15:41:18 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_040D_01C0D7D5.52F57DC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_040D_01C0D7D5.52F57DC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Dear linux-kernel mailing list,

I am trying to build 2.4.3 for Intel machine .

But i am getting this error when i say no to 'CONFIG_SMP' :-

In file included from ksyms.c:17:
/usr/src/linux-2.4.3/include/linux/kernel_stat.h:48: `smp_num_cpus'
undeclared (first use in this function)
/usr/src/linux-2.4.3/include/linux/kernel_stat.h:48: (Each undeclared
identifier is reported only once
/usr/src/linux-2.4.3/include/linux/kernel_stat.h:48: for each function it
appears in.)
make[2]: *** [ksyms.o] Error 1


but when i say yes to 'CONFIG_SMP' , there is no compilation error.

I am attaching autoconf.h for reference.

Thanks ,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.


------=_NextPart_000_040D_01C0D7D5.52F57DC0
Content-Type: application/octet-stream;
	name="autoconf.h"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="autoconf.h"

/*=0A=
 * Automatically generated C config: don't edit=0A=
 */=0A=
#define AUTOCONF_INCLUDED=0A=
#define CONFIG_X86 1=0A=
#define CONFIG_ISA 1=0A=
#undef  CONFIG_SBUS=0A=
#define CONFIG_UID16 1=0A=
=0A=
/*=0A=
 * Code maturity level options=0A=
 */=0A=
#undef  CONFIG_EXPERIMENTAL=0A=
=0A=
/*=0A=
 * Loadable module support=0A=
 */=0A=
#define CONFIG_MODULES 1=0A=
#define CONFIG_MODVERSIONS 1=0A=
#define CONFIG_KMOD 1=0A=
=0A=
/*=0A=
 * Processor type and features=0A=
 */=0A=
#undef  CONFIG_M386=0A=
#undef  CONFIG_M486=0A=
#define CONFIG_M586 1=0A=
#undef  CONFIG_M586TSC=0A=
#undef  CONFIG_M586MMX=0A=
#undef  CONFIG_M686=0A=
#undef  CONFIG_MPENTIUMIII=0A=
#undef  CONFIG_MPENTIUM4=0A=
#undef  CONFIG_MK6=0A=
#undef  CONFIG_MK7=0A=
#undef  CONFIG_MCRUSOE=0A=
#undef  CONFIG_MWINCHIPC6=0A=
#undef  CONFIG_MWINCHIP2=0A=
#undef  CONFIG_MWINCHIP3D=0A=
#define CONFIG_X86_WP_WORKS_OK 1=0A=
#define CONFIG_X86_INVLPG 1=0A=
#define CONFIG_X86_CMPXCHG 1=0A=
#define CONFIG_X86_BSWAP 1=0A=
#define CONFIG_X86_POPAD_OK 1=0A=
#define CONFIG_X86_L1_CACHE_SHIFT (5)=0A=
#define CONFIG_X86_USE_STRING_486 1=0A=
#define CONFIG_X86_ALIGNMENT_16 1=0A=
#undef  CONFIG_TOSHIBA=0A=
#undef  CONFIG_MICROCODE=0A=
#undef  CONFIG_X86_MSR=0A=
#undef  CONFIG_X86_CPUID=0A=
#define CONFIG_NOHIGHMEM 1=0A=
#undef  CONFIG_HIGHMEM4G=0A=
#undef  CONFIG_HIGHMEM64G=0A=
#undef  CONFIG_MATH_EMULATION=0A=
#undef  CONFIG_MTRR=0A=
#undef  CONFIG_SMP=0A=
#undef  CONFIG_X86_UP_IOAPIC=0A=
=0A=
/*=0A=
 * General setup=0A=
 */=0A=
#define CONFIG_NET 1=0A=
#undef  CONFIG_VISWS=0A=
#define CONFIG_PCI 1=0A=
#undef  CONFIG_PCI_GOBIOS=0A=
#undef  CONFIG_PCI_GODIRECT=0A=
#define CONFIG_PCI_GOANY 1=0A=
#define CONFIG_PCI_BIOS 1=0A=
#define CONFIG_PCI_DIRECT 1=0A=
#define CONFIG_PCI_NAMES 1=0A=
#undef  CONFIG_EISA=0A=
#undef  CONFIG_MCA=0A=
#define CONFIG_HOTPLUG 1=0A=
=0A=
/*=0A=
 * PCMCIA/CardBus support=0A=
 */=0A=
#define CONFIG_PCMCIA 1=0A=
#define CONFIG_CARDBUS 1=0A=
#undef  CONFIG_I82365=0A=
#undef  CONFIG_TCIC=0A=
#define CONFIG_SYSVIPC 1=0A=
#undef  CONFIG_BSD_PROCESS_ACCT=0A=
#define CONFIG_SYSCTL 1=0A=
#define CONFIG_KCORE_ELF 1=0A=
#undef  CONFIG_KCORE_AOUT=0A=
#define CONFIG_BINFMT_AOUT 1=0A=
#define CONFIG_BINFMT_ELF 1=0A=
#define CONFIG_BINFMT_MISC 1=0A=
#define CONFIG_PM 1=0A=
#undef  CONFIG_APM=0A=
=0A=
/*=0A=
 * Memory Technology Devices (MTD)=0A=
 */=0A=
#undef  CONFIG_MTD=0A=
=0A=
/*=0A=
 * Parallel port support=0A=
 */=0A=
#undef  CONFIG_PARPORT=0A=
=0A=
/*=0A=
 * Plug and Play configuration=0A=
 */=0A=
#define CONFIG_PNP 1=0A=
#define CONFIG_ISAPNP 1=0A=
=0A=
/*=0A=
 * Block devices=0A=
 */=0A=
#define CONFIG_BLK_DEV_FD 1=0A=
#undef  CONFIG_BLK_DEV_XD=0A=
#undef  CONFIG_PARIDE=0A=
#undef  CONFIG_BLK_CPQ_DA=0A=
#undef  CONFIG_BLK_CPQ_CISS_DA=0A=
#undef  CONFIG_BLK_DEV_DAC960=0A=
#undef  CONFIG_BLK_DEV_LOOP=0A=
#undef  CONFIG_BLK_DEV_NBD=0A=
#undef  CONFIG_BLK_DEV_RAM=0A=
#undef  CONFIG_BLK_DEV_INITRD=0A=
=0A=
/*=0A=
 * Multi-device support (RAID and LVM)=0A=
 */=0A=
#undef  CONFIG_MD=0A=
#undef  CONFIG_BLK_DEV_MD=0A=
#undef  CONFIG_MD_LINEAR=0A=
#undef  CONFIG_MD_RAID0=0A=
#undef  CONFIG_MD_RAID1=0A=
#undef  CONFIG_MD_RAID5=0A=
#undef  CONFIG_BLK_DEV_LVM=0A=
=0A=
/*=0A=
 * Networking options=0A=
 */=0A=
#define CONFIG_PACKET 1=0A=
#undef  CONFIG_PACKET_MMAP=0A=
#undef  CONFIG_NETLINK=0A=
#undef  CONFIG_NETFILTER=0A=
#undef  CONFIG_FILTER=0A=
#define CONFIG_UNIX 1=0A=
#define CONFIG_INET 1=0A=
#define CONFIG_IP_MULTICAST 1=0A=
#undef  CONFIG_IP_ADVANCED_ROUTER=0A=
#undef  CONFIG_IP_PNP=0A=
#undef  CONFIG_NET_IPIP=0A=
#undef  CONFIG_NET_IPGRE=0A=
#undef  CONFIG_IP_MROUTE=0A=
#undef  CONFIG_INET_ECN=0A=
#undef  CONFIG_SYN_COOKIES=0A=
=0A=
/*=0A=
 *  =0A=
 */=0A=
#undef  CONFIG_IPX=0A=
#undef  CONFIG_ATALK=0A=
#undef  CONFIG_DECNET=0A=
#undef  CONFIG_BRIDGE=0A=
=0A=
/*=0A=
 * QoS and/or fair queueing=0A=
 */=0A=
#undef  CONFIG_NET_SCHED=0A=
=0A=
/*=0A=
 * Telephony Support=0A=
 */=0A=
#undef  CONFIG_PHONE=0A=
#undef  CONFIG_PHONE_IXJ=0A=
=0A=
/*=0A=
 * ATA/IDE/MFM/RLL support=0A=
 */=0A=
#define CONFIG_IDE 1=0A=
=0A=
/*=0A=
 * IDE, ATA and ATAPI Block devices=0A=
 */=0A=
#define CONFIG_BLK_DEV_IDE 1=0A=
=0A=
/*=0A=
 * Please see Documentation/ide.txt for help/info on IDE drives=0A=
 */=0A=
#undef  CONFIG_BLK_DEV_HD_IDE=0A=
#undef  CONFIG_BLK_DEV_HD=0A=
#define CONFIG_BLK_DEV_IDEDISK 1=0A=
#undef  CONFIG_IDEDISK_MULTI_MODE=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_VENDOR=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_FUJITSU=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_IBM=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_MAXTOR=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_QUANTUM=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_SEAGATE=0A=
#undef  CONFIG_BLK_DEV_IDEDISK_WD=0A=
#undef  CONFIG_BLK_DEV_COMMERIAL=0A=
#undef  CONFIG_BLK_DEV_TIVO=0A=
#undef  CONFIG_BLK_DEV_IDECS=0A=
#define CONFIG_BLK_DEV_IDECD 1=0A=
#undef  CONFIG_BLK_DEV_IDETAPE=0A=
#undef  CONFIG_BLK_DEV_IDEFLOPPY=0A=
#undef  CONFIG_BLK_DEV_IDESCSI=0A=
=0A=
/*=0A=
 * IDE chipset support/bugfixes=0A=
 */=0A=
#define CONFIG_BLK_DEV_CMD640 1=0A=
#undef  CONFIG_BLK_DEV_CMD640_ENHANCED=0A=
#undef  CONFIG_BLK_DEV_ISAPNP=0A=
#define CONFIG_BLK_DEV_RZ1000 1=0A=
#define CONFIG_BLK_DEV_IDEPCI 1=0A=
#define CONFIG_IDEPCI_SHARE_IRQ 1=0A=
#undef  CONFIG_BLK_DEV_IDEDMA_PCI=0A=
#undef  CONFIG_BLK_DEV_OFFBOARD=0A=
#undef  CONFIG_IDEDMA_PCI_AUTO=0A=
#undef  CONFIG_BLK_DEV_IDEDMA=0A=
#undef  CONFIG_IDEDMA_PCI_WIP=0A=
#undef  CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=0A=
#undef  CONFIG_BLK_DEV_AEC62XX=0A=
#undef  CONFIG_AEC62XX_TUNING=0A=
#undef  CONFIG_BLK_DEV_ALI15X3=0A=
#undef  CONFIG_WDC_ALI15X3=0A=
#undef  CONFIG_BLK_DEV_AMD7409=0A=
#undef  CONFIG_AMD7409_OVERRIDE=0A=
#undef  CONFIG_BLK_DEV_CMD64X=0A=
#undef  CONFIG_BLK_DEV_CY82C693=0A=
#undef  CONFIG_BLK_DEV_CS5530=0A=
#undef  CONFIG_BLK_DEV_HPT34X=0A=
#undef  CONFIG_HPT34X_AUTODMA=0A=
#undef  CONFIG_BLK_DEV_HPT366=0A=
#undef  CONFIG_BLK_DEV_PIIX=0A=
#undef  CONFIG_PIIX_TUNING=0A=
#undef  CONFIG_BLK_DEV_NS87415=0A=
#undef  CONFIG_BLK_DEV_OPTI621=0A=
#undef  CONFIG_BLK_DEV_PDC202XX=0A=
#undef  CONFIG_PDC202XX_BURST=0A=
#undef  CONFIG_BLK_DEV_OSB4=0A=
#undef  CONFIG_BLK_DEV_SIS5513=0A=
#undef  CONFIG_BLK_DEV_SLC90E66=0A=
#undef  CONFIG_BLK_DEV_TRM290=0A=
#undef  CONFIG_BLK_DEV_VIA82CXXX=0A=
#undef  CONFIG_IDE_CHIPSETS=0A=
#undef  CONFIG_IDEDMA_AUTO=0A=
#undef  CONFIG_DMA_NONPCI=0A=
#define CONFIG_BLK_DEV_IDE_MODES 1=0A=
=0A=
/*=0A=
 * SCSI support=0A=
 */=0A=
#undef  CONFIG_SCSI=0A=
=0A=
/*=0A=
 * I2O device support=0A=
 */=0A=
#undef  CONFIG_I2O=0A=
#undef  CONFIG_I2O_PCI=0A=
#undef  CONFIG_I2O_BLOCK=0A=
#undef  CONFIG_I2O_LAN=0A=
#undef  CONFIG_I2O_SCSI=0A=
#undef  CONFIG_I2O_PROC=0A=
=0A=
/*=0A=
 * Network device support=0A=
 */=0A=
#define CONFIG_NETDEVICES 1=0A=
=0A=
/*=0A=
 * ARCnet devices=0A=
 */=0A=
#undef  CONFIG_ARCNET=0A=
#undef  CONFIG_DUMMY=0A=
#define CONFIG_DUMMY_MODULE 1=0A=
#undef  CONFIG_BONDING=0A=
#undef  CONFIG_EQUALIZER=0A=
#undef  CONFIG_TUN=0A=
#undef  CONFIG_NET_SB1000=0A=
=0A=
/*=0A=
 * Ethernet (10 or 100Mbit)=0A=
 */=0A=
#define CONFIG_NET_ETHERNET 1=0A=
#undef  CONFIG_NET_VENDOR_3COM=0A=
#undef  CONFIG_LANCE=0A=
#undef  CONFIG_NET_VENDOR_SMC=0A=
#undef  CONFIG_NET_VENDOR_RACAL=0A=
#undef  CONFIG_DEPCA=0A=
#undef  CONFIG_HP100=0A=
#undef  CONFIG_NET_ISA=0A=
#define CONFIG_NET_PCI 1=0A=
#undef  CONFIG_PCNET32=0A=
#undef  CONFIG_ADAPTEC_STARFIRE=0A=
#undef  CONFIG_AC3200=0A=
#undef  CONFIG_APRICOT=0A=
#undef  CONFIG_CS89x0=0A=
#undef  CONFIG_TULIP=0A=
#undef  CONFIG_DE4X5=0A=
#undef  CONFIG_DGRS=0A=
#undef  CONFIG_DM9102=0A=
#define CONFIG_EEPRO100 1=0A=
#undef  CONFIG_EEPRO100_PM=0A=
#undef  CONFIG_LNE390=0A=
#undef  CONFIG_NATSEMI=0A=
#undef  CONFIG_NE2K_PCI=0A=
#undef  CONFIG_NE3210=0A=
#undef  CONFIG_ES3210=0A=
#undef  CONFIG_8139TOO=0A=
#undef  CONFIG_8139TOO_PIO=0A=
#undef  CONFIG_8139TOO_TUNE_TWISTER=0A=
#undef  CONFIG_8139TOO_8129=0A=
#undef  CONFIG_SIS900=0A=
#undef  CONFIG_EPIC100=0A=
#undef  CONFIG_SUNDANCE=0A=
#undef  CONFIG_TLAN=0A=
#undef  CONFIG_VIA_RHINE=0A=
#undef  CONFIG_WINBOND_840=0A=
#undef  CONFIG_HAPPYMEAL=0A=
#undef  CONFIG_NET_POCKET=0A=
=0A=
/*=0A=
 * Ethernet (1000 Mbit)=0A=
 */=0A=
#undef  CONFIG_ACENIC=0A=
#undef  CONFIG_HAMACHI=0A=
#undef  CONFIG_SK98LIN=0A=
#undef  CONFIG_FDDI=0A=
#undef  CONFIG_PPP=0A=
#undef  CONFIG_SLIP=0A=
=0A=
/*=0A=
 * Wireless LAN (non-hamradio)=0A=
 */=0A=
#undef  CONFIG_NET_RADIO=0A=
=0A=
/*=0A=
 * Token Ring devices=0A=
 */=0A=
#undef  CONFIG_TR=0A=
#undef  CONFIG_NET_FC=0A=
=0A=
/*=0A=
 * Wan interfaces=0A=
 */=0A=
#undef  CONFIG_WAN=0A=
=0A=
/*=0A=
 * PCMCIA network device support=0A=
 */=0A=
#define CONFIG_NET_PCMCIA 1=0A=
#undef  CONFIG_PCMCIA_3C589=0A=
#undef  CONFIG_PCMCIA_3C574=0A=
#undef  CONFIG_PCMCIA_FMVJ18X=0A=
#define CONFIG_PCMCIA_PCNET 1=0A=
#undef  CONFIG_PCMCIA_NMCLAN=0A=
#undef  CONFIG_PCMCIA_SMC91C92=0A=
#undef  CONFIG_PCMCIA_XIRC2PS=0A=
#undef  CONFIG_ARCNET_COM20020_CS=0A=
#undef  CONFIG_PCMCIA_IBMTR=0A=
#undef  CONFIG_PCMCIA_XIRTULIP=0A=
#define CONFIG_NET_PCMCIA_RADIO 1=0A=
#define CONFIG_PCMCIA_RAYCS 1=0A=
#undef  CONFIG_PCMCIA_HERMES=0A=
#undef  CONFIG_PCMCIA_NETWAVE=0A=
#undef  CONFIG_PCMCIA_WAVELAN=0A=
#undef  CONFIG_AIRONET4500_CS=0A=
#define CONFIG_PCMCIA_NETCARD 1=0A=
=0A=
/*=0A=
 * Amateur Radio support=0A=
 */=0A=
#undef  CONFIG_HAMRADIO=0A=
=0A=
/*=0A=
 * IrDA (infrared) support=0A=
 */=0A=
#undef  CONFIG_IRDA=0A=
=0A=
/*=0A=
 * ISDN subsystem=0A=
 */=0A=
#undef  CONFIG_ISDN=0A=
=0A=
/*=0A=
 * Old CD-ROM drivers (not SCSI, not IDE)=0A=
 */=0A=
#undef  CONFIG_CD_NO_IDESCSI=0A=
=0A=
/*=0A=
 * Input core support=0A=
 */=0A=
#undef  CONFIG_INPUT=0A=
=0A=
/*=0A=
 * Character devices=0A=
 */=0A=
#define CONFIG_VT 1=0A=
#define CONFIG_VT_CONSOLE 1=0A=
#define CONFIG_SERIAL 1=0A=
#undef  CONFIG_SERIAL_CONSOLE=0A=
#undef  CONFIG_SERIAL_EXTENDED=0A=
#undef  CONFIG_SERIAL_NONSTANDARD=0A=
#define CONFIG_UNIX98_PTYS 1=0A=
#define CONFIG_UNIX98_PTY_COUNT (256)=0A=
=0A=
/*=0A=
 * I2C support=0A=
 */=0A=
#undef  CONFIG_I2C=0A=
=0A=
/*=0A=
 * Mice=0A=
 */=0A=
#undef  CONFIG_BUSMOUSE=0A=
#define CONFIG_MOUSE 1=0A=
#define CONFIG_PSMOUSE 1=0A=
#undef  CONFIG_82C710_MOUSE=0A=
#undef  CONFIG_PC110_PAD=0A=
=0A=
/*=0A=
 * Joysticks=0A=
 */=0A=
#undef  CONFIG_JOYSTICK=0A=
=0A=
/*=0A=
 * Input core support is needed for joysticks=0A=
 */=0A=
#undef  CONFIG_QIC02_TAPE=0A=
=0A=
/*=0A=
 * Watchdog Cards=0A=
 */=0A=
#undef  CONFIG_WATCHDOG=0A=
#undef  CONFIG_INTEL_RNG=0A=
#undef  CONFIG_NVRAM=0A=
#undef  CONFIG_RTC=0A=
#undef  CONFIG_DTLK=0A=
#undef  CONFIG_R3964=0A=
#undef  CONFIG_APPLICOM=0A=
=0A=
/*=0A=
 * Ftape, the floppy tape device driver=0A=
 */=0A=
#undef  CONFIG_FTAPE=0A=
#define CONFIG_AGP 1=0A=
#define CONFIG_AGP_INTEL 1=0A=
#define CONFIG_AGP_I810 1=0A=
#define CONFIG_AGP_VIA 1=0A=
#define CONFIG_AGP_AMD 1=0A=
#define CONFIG_AGP_SIS 1=0A=
#define CONFIG_AGP_ALI 1=0A=
#define CONFIG_DRM 1=0A=
#define CONFIG_DRM_TDFX 1=0A=
#undef  CONFIG_DRM_GAMMA=0A=
#undef  CONFIG_DRM_R128=0A=
#define CONFIG_DRM_RADEON 1=0A=
#undef  CONFIG_DRM_I810=0A=
#undef  CONFIG_DRM_MGA=0A=
=0A=
/*=0A=
 * PCMCIA character devices=0A=
 */=0A=
#undef  CONFIG_PCMCIA_SERIAL_CS=0A=
=0A=
/*=0A=
 * Multimedia devices=0A=
 */=0A=
#undef  CONFIG_VIDEO_DEV=0A=
=0A=
/*=0A=
 * File systems=0A=
 */=0A=
#undef  CONFIG_QUOTA=0A=
#undef  CONFIG_AUTOFS_FS=0A=
#define CONFIG_AUTOFS4_FS 1=0A=
#undef  CONFIG_REISERFS_FS=0A=
#undef  CONFIG_REISERFS_CHECK=0A=
#undef  CONFIG_ADFS_FS=0A=
#undef  CONFIG_ADFS_FS_RW=0A=
#undef  CONFIG_AFFS_FS=0A=
#undef  CONFIG_HFS_FS=0A=
#undef  CONFIG_BFS_FS=0A=
#undef  CONFIG_FAT_FS=0A=
#undef  CONFIG_MSDOS_FS=0A=
#undef  CONFIG_UMSDOS_FS=0A=
#undef  CONFIG_VFAT_FS=0A=
#undef  CONFIG_EFS_FS=0A=
#undef  CONFIG_JFFS_FS=0A=
#undef  CONFIG_CRAMFS=0A=
#undef  CONFIG_RAMFS=0A=
#define CONFIG_ISO9660_FS 1=0A=
#undef  CONFIG_JOLIET=0A=
#undef  CONFIG_MINIX_FS=0A=
#undef  CONFIG_NTFS_FS=0A=
#undef  CONFIG_NTFS_RW=0A=
#undef  CONFIG_HPFS_FS=0A=
#define CONFIG_PROC_FS 1=0A=
#undef  CONFIG_DEVFS_FS=0A=
#undef  CONFIG_DEVFS_MOUNT=0A=
#undef  CONFIG_DEVFS_DEBUG=0A=
#define CONFIG_DEVPTS_FS 1=0A=
#undef  CONFIG_QNX4FS_FS=0A=
#undef  CONFIG_QNX4FS_RW=0A=
#undef  CONFIG_ROMFS_FS=0A=
#define CONFIG_EXT2_FS 1=0A=
#undef  CONFIG_SYSV_FS=0A=
#undef  CONFIG_SYSV_FS_WRITE=0A=
#undef  CONFIG_UDF_FS=0A=
#undef  CONFIG_UDF_RW=0A=
#undef  CONFIG_UFS_FS=0A=
#undef  CONFIG_UFS_FS_WRITE=0A=
=0A=
/*=0A=
 * Network File Systems=0A=
 */=0A=
#undef  CONFIG_CODA_FS=0A=
#undef  CONFIG_NFS_FS=0A=
#undef  CONFIG_NFS_V3=0A=
#undef  CONFIG_ROOT_NFS=0A=
#undef  CONFIG_NFSD=0A=
#undef  CONFIG_NFSD_V3=0A=
#undef  CONFIG_SUNRPC=0A=
#undef  CONFIG_LOCKD=0A=
#undef  CONFIG_SMB_FS=0A=
#undef  CONFIG_NCP_FS=0A=
#undef  CONFIG_NCPFS_PACKET_SIGNING=0A=
#undef  CONFIG_NCPFS_IOCTL_LOCKING=0A=
#undef  CONFIG_NCPFS_STRONG=0A=
#undef  CONFIG_NCPFS_NFS_NS=0A=
#undef  CONFIG_NCPFS_OS2_NS=0A=
#undef  CONFIG_NCPFS_SMALLDOS=0A=
#undef  CONFIG_NCPFS_NLS=0A=
#undef  CONFIG_NCPFS_EXTRAS=0A=
=0A=
/*=0A=
 * Partition Types=0A=
 */=0A=
#undef  CONFIG_PARTITION_ADVANCED=0A=
#define CONFIG_MSDOS_PARTITION 1=0A=
#undef  CONFIG_SMB_NLS=0A=
#undef  CONFIG_NLS=0A=
=0A=
/*=0A=
 * Console drivers=0A=
 */=0A=
#define CONFIG_VGA_CONSOLE 1=0A=
#undef  CONFIG_VIDEO_SELECT=0A=
=0A=
/*=0A=
 * Sound=0A=
 */=0A=
#define CONFIG_SOUND 1=0A=
#undef  CONFIG_SOUND_CMPCI=0A=
#undef  CONFIG_SOUND_EMU10K1=0A=
#undef  CONFIG_SOUND_FUSION=0A=
#undef  CONFIG_SOUND_CS4281=0A=
#undef  CONFIG_SOUND_ES1370=0A=
#define CONFIG_SOUND_ES1371 1=0A=
#undef  CONFIG_SOUND_ESSSOLO1=0A=
#undef  CONFIG_SOUND_MAESTRO=0A=
#undef  CONFIG_SOUND_MAESTRO3=0A=
#undef  CONFIG_SOUND_ICH=0A=
#undef  CONFIG_SOUND_SONICVIBES=0A=
#undef  CONFIG_SOUND_TRIDENT=0A=
#undef  CONFIG_SOUND_MSNDCLAS=0A=
#undef  CONFIG_SOUND_MSNDPIN=0A=
#undef  CONFIG_SOUND_VIA82CXXX=0A=
#undef  CONFIG_SOUND_OSS=0A=
#undef  CONFIG_SOUND_TVMIXER=0A=
=0A=
/*=0A=
 * USB support=0A=
 */=0A=
#undef  CONFIG_USB=0A=
=0A=
/*=0A=
 * Kernel hacking=0A=
 */=0A=
#undef  CONFIG_MAGIC_SYSRQ=0A=

------=_NextPart_000_040D_01C0D7D5.52F57DC0--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVJ1HVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVJ1HVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVJ1HVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:21:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60360 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965165AbVJ1HVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:21:39 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14 assorted warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Oct 2005 17:21:19 +1000
Message-ID: <5455.1130484079@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 4.0.1 on i386, 2.6.14 assorted warnings.

arch/i386/kernel/cpu/transmeta.c: In function 'init_transmeta':
arch/i386/kernel/cpu/transmeta.c:11: warning: 'cpu_freq' may be used uninitialized in this function

kernel/kmod.c: In function '____call_usermodehelper':
kernel/kmod.c:138: warning: statement with no effect

fs/bio.c: In function 'bio_alloc_bioset':
fs/bio.c:167: warning: 'idx' may be used uninitialized in this function

fs/nfsd/nfsctl.c: In function 'write_filehandle':
fs/nfsd/nfsctl.c:262: warning: 'maxsize' may be used uninitialized in this function

fs/udf/balloc.c: In function 'udf_table_new_block':
fs/udf/balloc.c:757: warning: 'goal_eloc.logicalBlockNum' may be used uninitialized in this function

fs/udf/super.c: In function 'udf_load_partition':
fs/udf/super.c:1351: warning: 'ino.partitionReferenceNum' may be used uninitialized in this function

fs/xfs/xfs_alloc_btree.c: In function 'xfs_alloc_insrec':
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_startblock' may be used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:622: warning: 'nrec.ar_blockcount' may be used uninitialized in this function

fs/xfs/xfs_bmap.c: In function 'xfs_bmap_alloc':
fs/xfs/xfs_bmap.c:2335: warning: 'rtx' is used uninitialized in this function

fs/xfs/xfs_dir2_sf.c: In function 'xfs_dir2_block_sfsize':
fs/xfs/xfs_dir2_sf.c:110: warning: 'parent' may be used uninitialized in this function

fs/xfs/xfs_dir_leaf.c: In function 'xfs_dir_leaf_to_shortform':
fs/xfs/xfs_dir_leaf.c:653: warning: 'parent' may be used uninitialized in this function

fs/xfs/xfs_ialloc_btree.c: In function 'xfs_inobt_insrec':
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_free' is used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:750: warning: 'nrec.ir_freecount' is used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:567: warning: 'nrec.ir_startino' may be used uninitialized in this function

ipc/msg.c: In function 'sys_msgctl':
ipc/msg.c:333: warning: 'setbuf.qbytes' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/msg.c:333: warning: 'setbuf.mode' may be used uninitialized in this function

ipc/sem.c: In function 'semctl_down':
ipc/sem.c:803: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/sem.c:803: warning: 'setbuf.mode' may be used uninitialized in this function

drivers/net/wireless/ipw2100.c: In function 'store_memory':
drivers/net/wireless/ipw2100.c:3756: warning: unused variable 'dev'
drivers/net/wireless/ipw2100.c: In function 'store_scan_age':
drivers/net/wireless/ipw2100.c:4065: warning: unused variable 'dev'

sound/core/oss/route.c: In function 'route_to_channel':
sound/core/oss/route.c:207: warning: 'src' may be used uninitialized in this function

lib/zlib_inflate/inftrees.c: In function 'huft_build':
lib/zlib_inflate/inftrees.c:121: warning: 'r.base' may be used uninitialized in this function

Stripped .config.

X86=y
SEMAPHORE_SLEEPERS=y
MMU=y
UID16=y
GENERIC_ISA_DMA=y
GENERIC_IOMAP=y
ARCH_MAY_HAVE_PC_FDC=y
EXPERIMENTAL=y
CLEAN_COMPILE=y
LOCK_KERNEL=y
INIT_ENV_ARG_LIMIT=32
LOCALVERSION="kaos"
SWAP=y
SYSVIPC=y
SYSCTL=y
HOTPLUG=y
KOBJECT_UEVENT=y
INITRAMFS_SOURCE=""
KALLSYMS=y
KALLSYMS_ALL=y
PRINTK=y
BUG=y
BASE_FULL=y
FUTEX=y
EPOLL=y
SHMEM=y
CC_ALIGN_FUNCTIONS=0
CC_ALIGN_LABELS=0
CC_ALIGN_LOOPS=0
CC_ALIGN_JUMPS=0
BASE_SMALL=0
MODULES=y
MODULE_UNLOAD=y
OBSOLETE_MODPARM=y
KMOD=y
STOP_MACHINE=y
X86_PC=y
M686=y
X86_CMPXCHG=y
X86_XADD=y
X86_L1_CACHE_SHIFT=5
RWSEM_XCHGADD_ALGORITHM=y
GENERIC_CALIBRATE_DELAY=y
X86_PPRO_FENCE=y
X86_WP_WORKS_OK=y
X86_INVLPG=y
X86_BSWAP=y
X86_POPAD_OK=y
X86_GOOD_APIC=y
X86_USE_PPRO_CHECKSUM=y
SMP=y
NR_CPUS=2
PREEMPT_NONE=y
PREEMPT_BKL=y
X86_LOCAL_APIC=y
X86_IO_APIC=y
X86_TSC=y
X86_MCE=y
X86_MSR=m
X86_CPUID=m
DCDBAS=m
NOHIGHMEM=y
SELECT_MEMORY_MODEL=y
FLATMEM_MANUAL=y
FLATMEM=y
FLAT_NODE_MEM_MAP=y
MTRR=y
IRQBALANCE=y
SECCOMP=y
HZ_250=y
HZ=250
PHYSICAL_START=0x100000
PM=y
ACPI=y
ACPI_AC=m
ACPI_BATTERY=m
ACPI_BUTTON=m
ACPI_VIDEO=m
ACPI_FAN=m
ACPI_PROCESSOR=m
ACPI_THERMAL=m
ACPI_ASUS=m
ACPI_IBM=m
ACPI_TOSHIBA=m
ACPI_BLACKLIST_YEAR=0
ACPI_EC=y
ACPI_POWER=y
ACPI_SYSTEM=y
X86_PM_TIMER=y
CPU_FREQ=y
CPU_FREQ_TABLE=y
CPU_FREQ_STAT=y
CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CPU_FREQ_GOV_PERFORMANCE=y
CPU_FREQ_GOV_POWERSAVE=m
CPU_FREQ_GOV_USERSPACE=m
X86_ACPI_CPUFREQ=m
X86_SPEEDSTEP_ICH=m
X86_SPEEDSTEP_LIB=m
PCI=y
PCI_GOANY=y
PCI_BIOS=y
PCI_DIRECT=y
PCI_MMCONFIG=y
ISA_DMA_API=y
BINFMT_ELF=y
BINFMT_AOUT=m
BINFMT_MISC=m
NET=y
PACKET=m
UNIX=y
INET=y
IP_FIB_HASH=y
SYN_COOKIES=y
INET_DIAG=y
INET_TCP_DIAG=y
TCP_CONG_BIC=y
NETFILTER=y
IP_NF_CONNTRACK=m
IP_NF_FTP=m
IP_NF_IRC=m
IP_NF_QUEUE=m
IP_NF_IPTABLES=m
IP_NF_MATCH_LIMIT=m
IP_NF_MATCH_MAC=m
IP_NF_MATCH_PKTTYPE=m
IP_NF_MATCH_MARK=m
IP_NF_MATCH_MULTIPORT=m
IP_NF_MATCH_TOS=m
IP_NF_MATCH_ECN=m
IP_NF_MATCH_DSCP=m
IP_NF_MATCH_AH_ESP=m
IP_NF_MATCH_LENGTH=m
IP_NF_MATCH_TTL=m
IP_NF_MATCH_TCPMSS=m
IP_NF_MATCH_HELPER=m
IP_NF_MATCH_STATE=m
IP_NF_MATCH_CONNTRACK=m
IP_NF_MATCH_OWNER=m
IP_NF_FILTER=m
IP_NF_TARGET_REJECT=m
IP_NF_TARGET_LOG=m
IP_NF_TARGET_ULOG=m
IP_NF_TARGET_TCPMSS=m
IP_NF_NAT=m
IP_NF_NAT_NEEDED=y
IP_NF_TARGET_MASQUERADE=m
IP_NF_TARGET_REDIRECT=m
IP_NF_NAT_IRC=m
IP_NF_NAT_FTP=m
IP_NF_MANGLE=m
IP_NF_TARGET_TOS=m
IP_NF_TARGET_ECN=m
IP_NF_TARGET_DSCP=m
IP_NF_TARGET_MARK=m
IP_NF_ARPTABLES=m
IP_NF_ARPFILTER=m
VLAN_8021Q=m
IRDA=m
IRLAN=m
IRNET=m
IRCOMM=m
IRDA_ULTRA=y
IRDA_CACHE_LAST_LSAP=y
IRDA_FAST_RR=y
IRTTY_SIR=m
USB_IRDA=m
BT=m
BT_HCIUSB=m
BT_HCIUSB_SCO=y
BT_HCIUART=m
BT_HCIUART_H4=y
BT_HCIUART_BCSP=y
BT_HCIUART_BCSP_TXCRC=y
BT_HCIBCM203X=m
BT_HCIBFUSB=m
BT_HCIVHCI=m
IEEE80211=m
IEEE80211_CRYPT_WEP=m
IEEE80211_CRYPT_CCMP=m
IEEE80211_CRYPT_TKIP=m
STANDALONE=y
PREVENT_FIRMWARE_BUILD=y
FW_LOADER=m
CONNECTOR=m
PARPORT=m
PARPORT_PC=m
PARPORT_NOT_PC=y
BLK_DEV_FD=y
BLK_DEV_LOOP=m
BLK_DEV_RAM=y
BLK_DEV_RAM_COUNT=16
BLK_DEV_RAM_SIZE=4096
IOSCHED_NOOP=y
IOSCHED_AS=y
IOSCHED_DEADLINE=y
IOSCHED_CFQ=y
IDE=y
BLK_DEV_IDE=y
BLK_DEV_IDEDISK=y
BLK_DEV_IDECD=y
BLK_DEV_IDESCSI=y
IDE_GENERIC=y
BLK_DEV_IDEPCI=y
IDEPCI_SHARE_IRQ=y
BLK_DEV_IDEDMA_PCI=y
IDEDMA_PCI_AUTO=y
BLK_DEV_PIIX=y
BLK_DEV_IDEDMA=y
IDEDMA_AUTO=y
SCSI=y
SCSI_PROC_FS=y
BLK_DEV_SD=m
BLK_DEV_SR=m
BLK_DEV_SR_VENDOR=y
CHR_DEV_SG=m
SCSI_CONSTANTS=y
SCSI_LOGGING=y
SCSI_SPI_ATTRS=y
SCSI_SYM53C8XX_2=y
SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
SCSI_SYM53C8XX_DEFAULT_TAGS=16
SCSI_SYM53C8XX_MAX_TAGS=64
SCSI_QLA2XXX=y
NETDEVICES=y
DUMMY=m
NET_ETHERNET=y
MII=m
NET_TULIP=y
TULIP=m
NET_PCI=y
E100=m
TIGON3=m
NET_RADIO=y
STRIP=m
IPW2100=m
IPW2100_MONITOR=y
IPW2200=m
AIRO=m
HERMES=m
PLX_HERMES=m
TMD_HERMES=m
NORTEL_HERMES=m
PCI_HERMES=m
ATMEL=m
PCI_ATMEL=m
PRISM54=m
HOSTAP=m
HOSTAP_FIRMWARE=y
HOSTAP_PLX=m
HOSTAP_PCI=m
NET_WIRELESS=y
PLIP=m
PPP=m
PPP_ASYNC=m
PPP_DEFLATE=m
PPP_BSDCOMP=m
SLIP=m
SLIP_COMPRESSED=y
INPUT=y
INPUT_MOUSEDEV=y
INPUT_MOUSEDEV_PSAUX=y
INPUT_MOUSEDEV_SCREEN_X=1024
INPUT_MOUSEDEV_SCREEN_Y=768
INPUT_KEYBOARD=y
KEYBOARD_ATKBD=y
INPUT_MOUSE=y
MOUSE_PS2=m
MOUSE_SERIAL=m
SERIO=y
SERIO_I8042=y
SERIO_SERPORT=y
SERIO_PCIPS2=m
SERIO_LIBPS2=y
VT=y
VT_CONSOLE=y
HW_CONSOLE=y
SERIAL_8250=y
SERIAL_8250_CONSOLE=y
SERIAL_8250_NR_UARTS=4
SERIAL_CORE=y
SERIAL_CORE_CONSOLE=y
UNIX98_PTYS=y
LEGACY_PTYS=y
LEGACY_PTY_COUNT=256
PRINTER=m
LP_CONSOLE=y
IPMI_HANDLER=m
IPMI_DEVICE_INTERFACE=m
IPMI_SI=m
IPMI_WATCHDOG=m
NVRAM=m
RTC=y
AGP=m
AGP_INTEL=m
DRM=m
DRM_RADEON=m
HPET=y
HPET_RTC_IRQ=y
HPET_MMAP=y
I2C=m
I2C_ALGOBIT=m
I2C_I801=m
I2C_I810=m
W1=m
W1_THERM=m
HWMON=m
VGA_CONSOLE=y
DUMMY_CONSOLE=y
SOUND=m
SND=m
SND_TIMER=m
SND_PCM=m
SND_HWDEP=m
SND_RAWMIDI=m
SND_SEQUENCER=m
SND_SEQ_DUMMY=m
SND_OSSEMUL=y
SND_MIXER_OSS=m
SND_PCM_OSS=m
SND_SEQUENCER_OSS=y
SND_RTCTIMER=m
SND_SEQ_RTCTIMER_DEFAULT=y
SND_GENERIC_DRIVER=y
SND_MPU401_UART=m
SND_DUMMY=m
SND_VIRMIDI=m
SND_MTPAV=m
SND_SERIAL_U16550=m
SND_MPU401=m
SND_AC97_CODEC=m
SND_AC97_BUS=m
SND_INTEL8X0=m
SND_USB_AUDIO=m
USB_ARCH_HAS_HCD=y
USB_ARCH_HAS_OHCI=y
USB=m
USB_DEVICEFS=y
USB_EHCI_HCD=m
USB_OHCI_HCD=m
USB_OHCI_LITTLE_ENDIAN=y
USB_UHCI_HCD=m
USB_ACM=m
USB_PRINTER=m
USB_STORAGE=m
USB_STORAGE_DATAFAB=y
USB_STORAGE_FREECOM=y
USB_STORAGE_ISD200=y
USB_STORAGE_DPCM=y
USB_STORAGE_SDDR09=y
USB_STORAGE_SDDR55=y
USB_STORAGE_JUMPSHOT=y
USB_HID=m
USB_HIDINPUT=y
HID_FF=y
USB_HIDDEV=y
USB_KBD=m
USB_MOUSE=m
USB_AIPTEK=m
USB_WACOM=m
USB_KBTAB=m
USB_POWERMATE=m
USB_MTOUCH=m
USB_EGALAX=m
USB_XPAD=m
USB_ATI_REMOTE=m
USB_MDC800=m
USB_MICROTEK=m
USB_DABUSB=m
USB_CATC=m
USB_KAWETH=m
USB_PEGASUS=m
USB_RTL8150=m
USB_USBNET=m
USB_NET_AX8817X=m
USB_NET_CDCETHER=m
USB_NET_NET1080=m
USB_NET_ZAURUS=m
USB_MON=y
USB_USS720=m
USB_SERIAL=m
USB_SERIAL_GENERIC=y
USB_SERIAL_BELKIN=m
USB_SERIAL_DIGI_ACCELEPORT=m
USB_SERIAL_EMPEG=m
USB_SERIAL_FTDI_SIO=m
USB_SERIAL_VISOR=m
USB_SERIAL_IPAQ=m
USB_SERIAL_IR=m
USB_SERIAL_EDGEPORT=m
USB_SERIAL_EDGEPORT_TI=m
USB_SERIAL_KEYSPAN_PDA=m
USB_SERIAL_KEYSPAN=m
USB_SERIAL_KEYSPAN_MPR=y
USB_SERIAL_KEYSPAN_USA28=y
USB_SERIAL_KEYSPAN_USA28X=y
USB_SERIAL_KEYSPAN_USA28XA=y
USB_SERIAL_KEYSPAN_USA28XB=y
USB_SERIAL_KEYSPAN_USA19=y
USB_SERIAL_KEYSPAN_USA18X=y
USB_SERIAL_KEYSPAN_USA19W=y
USB_SERIAL_KEYSPAN_USA19QW=y
USB_SERIAL_KEYSPAN_USA19QI=y
USB_SERIAL_KEYSPAN_USA49W=y
USB_SERIAL_KEYSPAN_USA49WLC=y
USB_SERIAL_KLSI=m
USB_SERIAL_KOBIL_SCT=m
USB_SERIAL_MCT_U232=m
USB_SERIAL_PL2303=m
USB_SERIAL_SAFE=m
USB_SERIAL_SAFE_PADDED=y
USB_SERIAL_CYBERJACK=m
USB_SERIAL_XIRCOM=m
USB_SERIAL_OMNINET=m
USB_EZUSB=y
USB_EMI62=m
USB_EMI26=m
USB_AUERSWALD=m
USB_RIO500=m
USB_LEGOTOWER=m
USB_LCD=m
USB_LED=m
USB_CYTHERM=m
USB_PHIDGETSERVO=m
USB_TEST=m
EXT2_FS=y
FS_POSIX_ACL=y
XFS_FS=y
XFS_EXPORT=y
XFS_QUOTA=y
MINIX_FS=m
ROMFS_FS=m
INOTIFY=y
QUOTACTL=y
DNOTIFY=y
AUTOFS_FS=m
AUTOFS4_FS=m
FUSE_FS=m
ISO9660_FS=m
JOLIET=y
ZISOFS=y
ZISOFS_FS=m
UDF_FS=m
UDF_NLS=y
FAT_FS=m
MSDOS_FS=m
VFAT_FS=m
FAT_DEFAULT_CODEPAGE=437
FAT_DEFAULT_IOCHARSET="iso8859-1"
NTFS_FS=m
PROC_FS=y
PROC_KCORE=y
SYSFS=y
TMPFS=y
RAMFS=y
RELAYFS_FS=m
EFS_FS=m
HPFS_FS=m
UFS_FS=m
NFS_FS=m
NFS_V3=y
NFS_V4=y
NFSD=m
NFSD_V3=y
NFSD_V4=y
NFSD_TCP=y
LOCKD=m
LOCKD_V4=y
EXPORTFS=y
NFS_COMMON=y
SUNRPC=m
SUNRPC_GSS=m
RPCSEC_GSS_KRB5=m
SMB_FS=m
MSDOS_PARTITION=y
NLS=y
NLS_DEFAULT="iso8859-1"
NLS_CODEPAGE_437=m
NLS_ISO8859_1=m
NLS_UTF8=m
DEBUG_KERNEL=y
MAGIC_SYSRQ=y
LOG_BUF_SHIFT=16
DETECT_SOFTLOCKUP=y
DEBUG_BUGVERBOSE=y
EARLY_PRINTK=y
X86_FIND_SMP_CONFIG=y
X86_MPPARSE=y
KDB=y
KDB_MODULES=y
KDB_CONTINUE_CATASTROPHIC=0
CRYPTO=y
CRYPTO_MD5=y
CRYPTO_DES=m
CRYPTO_AES=m
CRYPTO_ARC4=m
CRYPTO_MICHAEL_MIC=m
CRC_CCITT=m
CRC32=m
ZLIB_INFLATE=m
ZLIB_DEFLATE=m
GENERIC_HARDIRQS=y
GENERIC_IRQ_PROBE=y
GENERIC_PENDING_IRQ=y
X86_SMP=y
X86_HT=y
X86_BIOS_REBOOT=y
X86_TRAMPOLINE=y
PC=y



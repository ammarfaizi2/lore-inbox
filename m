Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbULMJLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbULMJLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 04:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbULMJLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 04:11:22 -0500
Received: from [213.69.232.58] ([213.69.232.58]:60681 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262026AbULMJJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 04:09:26 -0500
Date: Mon, 13 Dec 2004 10:10:28 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG?] [PPC/403/IBM] compile error 2.6.9 and earlier
Message-ID: <20041213091027.GA2384@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I didn't find linux-ppc list on vger, so I hope this list is correct:

When trying to compile a kernel for my ibm thinclient, which has a
403 PPC processor, I get the attached compile error.=20

The error exists since 2.6.X, but the times before I tried to cross-compile,
this time I tried to built the kernel from my 'new' g3-ibook, which
failed again (so this is not a cross-compile error).

Thanks for any hints,

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Log.oak"

  CLEAN   arch/ppc/kernel
  CLEAN   init
  CLEAN   usr
  CLEAN   .tmp_versions
  CLEAN   include/asm-ppc/offsets.h arch/ppc/kernel/asm-offsets.s
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/genksyms/genksyms.o
  HOSTCC  scripts/genksyms/lex.o
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  CC      arch/ppc/kernel/asm-offsets.s
  CHK     include/asm-ppc/offsets.h
  UPD     include/asm-ppc/offsets.h
  CC      init/main.o
  CHK     include/linux/compile.h
dnsdomainname: No address associated with name
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_devfs.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  AS      arch/ppc/kernel/entry.o
  CC      arch/ppc/kernel/traps.o
  CC      arch/ppc/kernel/irq.o
  CC      arch/ppc/kernel/idle.o
  CC      arch/ppc/kernel/time.o
  AS      arch/ppc/kernel/misc.o
  CC      arch/ppc/kernel/process.o
  CC      arch/ppc/kernel/signal.o
  CC      arch/ppc/kernel/ptrace.o
  CC      arch/ppc/kernel/align.o
  CC      arch/ppc/kernel/semaphore.o
  CC      arch/ppc/kernel/syscalls.o
  CC      arch/ppc/kernel/setup.o
  CC      arch/ppc/kernel/cputable.o
  CC      arch/ppc/kernel/ppc_htab.o
  CC      arch/ppc/kernel/module.o
  CC      arch/ppc/kernel/ppc_ksyms.o
  CC      arch/ppc/kernel/dma-mapping.o
  CC      arch/ppc/kernel/pci.o
  LD      arch/ppc/kernel/built-in.o
  AS      arch/ppc/kernel/head_4xx.o
  LDS     arch/ppc/kernel/vmlinux.lds
  LD      arch/ppc/platforms/built-in.o
  CC      arch/ppc/mm/fault.o
  CC      arch/ppc/mm/init.o
  CC      arch/ppc/mm/mem_pieces.o
  CC      arch/ppc/mm/mmu_context.o
  CC      arch/ppc/mm/pgtable.o
  CC      arch/ppc/mm/4xx_mmu.o
  LD      arch/ppc/mm/built-in.o
  AS      arch/ppc/lib/checksum.o
  AS      arch/ppc/lib/string.o
  CC      arch/ppc/lib/strcase.o
  CC      arch/ppc/lib/dec_and_lock.o
  AS      arch/ppc/lib/div64.o
  LD      arch/ppc/lib/built-in.o
  CC      arch/ppc/syslib/ppc4xx_pic.o
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_uic_enable':
arch/ppc/syslib/ppc4xx_pic.c:164: warning: implicit declaration of function `DCRN_UIC_ER'
arch/ppc/syslib/ppc4xx_pic.c:164: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c:164: error: (Each undeclared identifier is reported only once
arch/ppc/syslib/ppc4xx_pic.c:164: error: for each function it appears in.)
arch/ppc/syslib/ppc4xx_pic.c:165: warning: implicit declaration of function `DCRN_UIC_TR'
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_uic_disable':
arch/ppc/syslib/ppc4xx_pic.c:202: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_uic_disable_and_ack':
arch/ppc/syslib/ppc4xx_pic.c:228: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c:229: warning: implicit declaration of function `DCRN_UIC_SR'
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_uic_end':
arch/ppc/syslib/ppc4xx_pic.c:270: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_pic_get_irq':
arch/ppc/syslib/ppc4xx_pic.c:352: warning: implicit declaration of function `DCRN_UIC_MSR'
arch/ppc/syslib/ppc4xx_pic.c:352: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_extpic_init':
arch/ppc/syslib/ppc4xx_pic.c:442: warning: implicit declaration of function `DCRN_UIC_PR'
arch/ppc/syslib/ppc4xx_pic.c:442: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c: In function `ppc4xx_pic_init':
arch/ppc/syslib/ppc4xx_pic.c:509: error: `UIC0' undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_pic.c:510: warning: implicit declaration of function `DCRN_UIC_CR'
make[1]: *** [arch/ppc/syslib/ppc4xx_pic.o] Error 1
make: *** [arch/ppc/syslib] Error 2

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.9-config-oak"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9
# Mon Dec 13 10:45:14 2004
#
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION="eiche"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor
#
# CONFIG_6xx is not set
CONFIG_40x=y
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_E500 is not set
CONFIG_MATH_EMULATION=y
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_4xx=y

#
# IBM 4xx options
#
# CONFIG_ASH is not set
# CONFIG_BUBINGA is not set
# CONFIG_CPCI405 is not set
# CONFIG_EP405 is not set
CONFIG_OAK=y
# CONFIG_REDWOOD_5 is not set
# CONFIG_REDWOOD_6 is not set
# CONFIG_SYCAMORE is not set
# CONFIG_WALNUT is not set
CONFIG_IBM405_ERR51=y
CONFIG_403GCX=y
CONFIG_PPC4xx_DMA=y
CONFIG_PPC4xx_EDMA=y
CONFIG_PM=y
CONFIG_UART0_TTYS0=y
# CONFIG_UART0_TTYS1 is not set
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
# CONFIG_PPC_MULTIPLATFORM is not set
# CONFIG_APUS is not set
# CONFIG_WILLOW is not set
# CONFIG_PCORE is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_EV64260 is not set
# CONFIG_SPRUCE is not set
# CONFIG_LOPEC is not set
# CONFIG_MCPN765 is not set
# CONFIG_MVME5100 is not set
# CONFIG_PPLUS is not set
# CONFIG_PRPMC750 is not set
# CONFIG_PRPMC800 is not set
# CONFIG_SANDPOINT is not set
# CONFIG_ADIR is not set
# CONFIG_K2 is not set
# CONFIG_PAL4 is not set
# CONFIG_GEMINI is not set
# CONFIG_EST8260 is not set
# CONFIG_SBC82xx is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX8260 is not set
# CONFIG_TQM8260 is not set
# CONFIG_ADS8272 is not set
# CONFIG_LITE5200 is not set
CONFIG_PC_KEYBOARD=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_HIGHMEM is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""

#
# Bus options
#
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_TCIC=m

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
# CONFIG_CONSISTENT_START_BOOL is not set
CONFIG_CONSISTENT_START=0xff100000
# CONFIG_CONSISTENT_SIZE_BOOL is not set
CONFIG_CONSISTENT_SIZE=0x00200000
# CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=0x00400000

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_IBM_EMAC=y
CONFIG_IBM_EMAC_ERRMSG=y
CONFIG_IBM_EMAC_RXB=64
CONFIG_IBM_EMAC_TXB=8
CONFIG_IBM_EMAC_FGAP=8
CONFIG_IBM_EMAC_SKBRES=0
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_GEN_RTC=y
# CONFIG_GEN_RTC_X is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_RAW_DRIVER is not set

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_CT65550=y
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G450 is not set
CONFIG_FB_MATROX_G100A=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=y
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_MULTIHEAD is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_XL_INIT is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf-8"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf-8"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# IBM 40x options
#

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_INFO=y
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SERIAL_TEXT_DEBUG is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

--vkogqOf2sHV7VnPd--

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQb1cgrOTBMvCUbrlAQK2Dg//YncHjL5EuG83FREjNPH/iTwh2Zvtt+mq
IIsVsiCdkKO8/DtbVwRLvJK/cLM/tmBdQ2BfuDZeq4jPSbMf6nAwiawGkOxNbH89
WAAuBq343cxyos9yHrJ579Bm3AVe85gYEeB1SeJFXkN5XnEkxPcyyHdgdK8k05vB
DIqBSgFTWuNKt7lanOMmUxlOp6640dRoQtxFWqsV8L5gCgTbzf6X45+dyou/+YZE
Jm/hCIf1AHJofGdZctNzI3eMTtZbZV3tVXhRZqYAn5r+EE8ORI6pxEd8U1ZOqdro
ieP4I9bosr//9OM1zaqvRnIDt18EMhYibZSUVW/Wq5GNWbUrOHO7GJrJcj+hdwwY
BroUiufZjyShYnWQpvOYBkB1Y99NSlEFvrj/QMNXL5GsU9iK1fApTw9FGnbhDRiS
MPBdVxvJdyLCjIdnwoKIsSzKazWzgaeTkd5CDkHFgkwPSRlhd7q8XkIwirrHd+aG
hhKRsFmXWxQx3C+vkV1snfUo/4ldIvLaCs6wtcGIn0Wwi4uBzbaTSIL6wsxcY6u0
kBLqOkczsDU2EULKCGBD0sLKr7L0Pdz/DtFAonQCTcX7UuTjRJ+kiqkHqRd3UsVT
sC0UmyUFX1Eq8VCBOpP0FihnP6S55E0nbHZhxetYzTkG5s5pDKeIfueplnLrqfnS
rtwogBMIC+A=
=r5yO
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSBXBvJ>; Sat, 23 Feb 2002 20:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSBXBvD>; Sat, 23 Feb 2002 20:51:03 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:27776 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S289099AbSBXBuv>; Sat, 23 Feb 2002 20:50:51 -0500
Subject: Re: [PATCHSET] Linux 2.4.18-rc4-jam1
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: =?ISO-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>,
        "J.A. Magallon" <jamagallon@able.es>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1014514801.492.14.camel@psuedomode>
In-Reply-To: <20020223234217.C2023@werewolf.able.es>
	<3C782531.6050701@wanadoo.fr>  <1014514801.492.14.camel@psuedomode>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 20:50:42 -0500
Message-Id: <1014515447.491.16.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this seems to happen with 2.4.17 too.   Seems to be a debian
problem not kernel.   Gah. 

On Sat, 2002-02-23 at 20:39, Ed Sweetman wrote:
> I get this when trying to compile Linux 2.4.18-rc4-jam1 using debian
> unstable. I'm positive i applied all of the patches in order. I'm
> attaching my config 
> 
> this is from compiling in ./fs   using 2.95.4-11
> 
> buffer.c: In function `show_buffers':
> buffer.c:2746: warning: int format, long int arg (arg 2)
> 
> 
> namei.c:1625: parse error before `z'
> namei.c:1626: syntax error before `int'
> namei.c:1627: parse error before `*'
> namei.c:1627: warning: type defaults to `int' in declaration of `from'
> namei.c:1627: warning: data definition has no type or storage class
> namei.c:1630: warning: type defaults to `int' in declaration of `from'
> namei.c:1630: conflicting types for `from'
> namei.c:1627: previous declaration of `from'
> namei.c:1630: `oldname' undeclared here (not in a function)
> namei.c:1630: warning: initialization makes integer from pointer without
> a cast
> namei.c:1630: initializer element is not constant
> namei.c:1630: warning: data definition has no type or storage class
> namei.c:1631: parse error before `if'
> namei.c:1633: warning: type defaults to `int' in declaration of `to'
> namei.c:1633: conflicting types for `to'
> namei.c:1628: previous declaration of `to'
> namei.c:1633: `newname' undeclared here (not in a function)
> namei.c:1633: warning: initialization makes integer from pointer without
> a cast
> namei.c:1633: initializer element is not constant
> namei.c:1633: warning: data definition has no type or storage class
> namei.c:1634: warning: type defaults to `int' in declaration of `error'
> namei.c:1634: warning: passing arg 1 of `PTR_ERR' makes pointer from
> integer without a cast
> namei.c:1634: initializer element is not constant
> namei.c:1634: warning: data definition has no type or storage class
> namei.c:1635: parse error before `if'
> namei.c:1639: warning: type defaults to `int' in declaration of `error'
> namei.c:1639: redefinition of `error'
> namei.c:1634: `error' previously defined here
> namei.c:1639: warning: data definition has no type or storage class
> namei.c:1640: parse error before `if'
> namei.c:1648: warning: type defaults to `int' in declaration of `error'
> namei.c:1648: redefinition of `error'
> namei.c:1639: `error' previously defined here
> namei.c:1648: warning: data definition has no type or storage class
> namei.c:1649: parse error before `if'
> namei.c:1651: warning: type defaults to `int' in declaration of
> `new_dentry'
> namei.c:1651: warning: initialization makes integer from pointer without
> a cast
> namei.c:1651: initializer element is not constant
> namei.c:1651: warning: data definition has no type or storage class
> namei.c:1652: warning: type defaults to `int' in declaration of `error'
> namei.c:1652: redefinition of `error'
> namei.c:1648: `error' previously defined here
> namei.c:1652: warning: passing arg 1 of `PTR_ERR' makes pointer from
> integer without a cast
> namei.c:1652: initializer element is not constant
> namei.c:1652: warning: data definition has no type or storage class
> namei.c:1653: parse error before `if'
> namei.c:1655: warning: type defaults to `int' in declaration of `dput'
> namei.c:1655: warning: parameter names (without types) in function
> declaration
> namei.c:1655: conflicting types for `dput'
> /usr/src/linux/include/linux/dcache.h:267: previous declaration of
> `dput'
> namei.c:1655: warning: data definition has no type or storage class
> namei.c:1656: parse error before `}'
> namei.c:1657: parse error before `&'
> namei.c:1657: warning: type defaults to `int' in declaration of `up'
> namei.c:1657: warning: function declaration isn't a prototype
> namei.c:1657: conflicting types for `up'
> /usr/src/linux/include/asm/semaphore.h:207: previous declaration of `up'
> namei.c:1657: warning: data definition has no type or storage class
> namei.c:1658: parse error before `:'
> namei.c:1665: parse error before `('
> namei.c:1665: parse error before `)'
> gcc: Internal compiler error: program cc1 got fatal signal 11
> make[2]: *** [namei.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/fs'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/fs'
> make: *** [_dir_fs] Error 2
> cpp0: output pipe has been closed
> psuedomode:/usr/src/linux# {standard input}: Assembler messages:
> {standard input}:2356: Warning: end of file not at end of a line;
> newline inserted
> {standard input}:3725: Error: end of file inside conditional
> {standard input}:3724: Error: here is the start of the unterminated
> conditional 
> 
> ----
> 

> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_ISA=y
> # CONFIG_SBUS is not set
> CONFIG_UID16=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> # CONFIG_MODVERSIONS is not set
> CONFIG_KMOD=y
> 
> #
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> CONFIG_MK7=y
> # CONFIG_MELAN is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_USE_3DNOW=y
> CONFIG_X86_PGE=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> # CONFIG_SMP is not set
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> #
> # General setup
> #
> CONFIG_NET=y
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GODIRECT is not set
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> # CONFIG_EISA is not set
> # CONFIG_MCA is not set
> # CONFIG_HOTPLUG is not set
> # CONFIG_PCMCIA is not set
> # CONFIG_HOTPLUG_PCI is not set
> CONFIG_SYSVIPC=y
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_BPROC is not set
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> # CONFIG_KCORE_AOUT is not set
> CONFIG_BINFMT_AOUT=y
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PM=y
> CONFIG_ACPI=y
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_BUSMGR=y
> CONFIG_ACPI_SYS=y
> CONFIG_ACPI_CPU=y
> # CONFIG_ACPI_BUTTON is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_EC is not set
> # CONFIG_APM is not set
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
> 
> #
> # Plug and Play configuration
> #
> # CONFIG_PNP is not set
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_BLK_DEV_XD is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> CONFIG_BLK_DEV_LOOP=m
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_RAM is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> # CONFIG_NETLINK_DEV is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_FILTER is not set
> CONFIG_UNIX=y
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_ARPD is not set
> CONFIG_INET_ECN=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_IPV6 is not set
> # CONFIG_KHTTPD is not set
> # CONFIG_ATM is not set
> # CONFIG_VLAN_8021Q is not set
> 
> #
> #  
> #
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_DECNET is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_LLC is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
> 
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> # CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
> # CONFIG_BLK_DEV_COMMERIAL is not set
> CONFIG_BLK_DEV_IDECD=m
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> CONFIG_BLK_DEV_IDESCSI=m
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_BLK_DEV_CMD640 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_PCI_WIP=y
> # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
> CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_PIIX is not set
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_PDC_ADMA is not set
> CONFIG_BLK_DEV_PDC202XX=y
> # CONFIG_PDC202XX_BURST is not set
> # CONFIG_PDC202XX_FORCE is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> CONFIG_BLK_DEV_VIA82CXXX=y
> # CONFIG_IDE_CHIPSETS is not set
> # CONFIG_BLK_DEV_ELEVATOR_NOOP is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> # CONFIG_BLK_DEV_ATARAID is not set
> 
> #
> # SCSI support
> #
> CONFIG_SCSI=m
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> # CONFIG_BLK_DEV_SD is not set
> # CONFIG_CHR_DEV_ST is not set
> # CONFIG_CHR_DEV_OSST is not set
> # CONFIG_BLK_DEV_SR is not set
> CONFIG_CHR_DEV_SG=m
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> CONFIG_SCSI_DEBUG_QUEUES=y
> CONFIG_SCSI_MULTI_LUN=y
> CONFIG_SCSI_CONSTANTS=y
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_7000FASST is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AHA152X is not set
> # CONFIG_SCSI_AHA1542 is not set
> # CONFIG_SCSI_AHA1740 is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_IN2000 is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_MEGARAID is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_DTC3280 is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_DMA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_GENERIC_NCR5380 is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_NCR53C406A is not set
> # CONFIG_SCSI_NCR53C7xx is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_NCR53C8XX is not set
> # CONFIG_SCSI_SYM53C8XX is not set
> # CONFIG_SCSI_PAS16 is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_PSI240I is not set
> # CONFIG_SCSI_QLOGIC_FAS is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_SEAGATE is not set
> # CONFIG_SCSI_SIM710 is not set
> # CONFIG_SCSI_SYM53C416 is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_T128 is not set
> # CONFIG_SCSI_U14_34F is not set
> # CONFIG_SCSI_ULTRASTOR is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION_BOOT is not set
> # CONFIG_FUSION_ISENSE is not set
> # CONFIG_FUSION_CTL is not set
> # CONFIG_FUSION_LAN is not set
> 
> #
> # IEEE 1394 (FireWire) support (EXPERIMENTAL)
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Network device support
> #
> CONFIG_NETDEVICES=y
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> CONFIG_DUMMY=m
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> # CONFIG_ETHERTAP is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_LANCE is not set
> # CONFIG_NET_VENDOR_SMC is not set
> # CONFIG_NET_VENDOR_RACAL is not set
> # CONFIG_AT1700 is not set
> # CONFIG_DEPCA is not set
> # CONFIG_HP100 is not set
> # CONFIG_NET_ISA is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_AC3200 is not set
> # CONFIG_APRICOT is not set
> # CONFIG_CS89x0 is not set
> CONFIG_TULIP=m
> CONFIG_TULIP_MWI=y
> CONFIG_TULIP_MMIO=y
> # CONFIG_DE4X5 is not set
> # CONFIG_DGRS is not set
> # CONFIG_DM9102 is not set
> # CONFIG_EEPRO100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> CONFIG_8139TOO=m
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> # CONFIG_8139TOO_8129 is not set
> CONFIG_8139_NEW_RX_RESET=y
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> # CONFIG_WINBOND_840 is not set
> # CONFIG_NET_POCKET is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> # CONFIG_NET_FC is not set
> # CONFIG_RCPCI is not set
> # CONFIG_SHAPER is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> 
> #
> # Amateur Radio support
> #
> # CONFIG_HAMRADIO is not set
> 
> #
> # IrDA (infrared) support
> #
> # CONFIG_IRDA is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Old CD-ROM drivers (not SCSI, not IDE)
> #
> # CONFIG_CD_NO_IDESCSI is not set
> 
> #
> # Input core support
> #
> # CONFIG_INPUT is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> # CONFIG_SERIAL_CONSOLE is not set
> # CONFIG_SERIAL_ACPI is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # I2C support
> #
> CONFIG_I2C=m
> CONFIG_I2C_ALGOBIT=m
> # CONFIG_I2C_BITELV is not set
> # CONFIG_I2C_BITVELLE is not set
> CONFIG_I2C_ALGOPCF=m
> # CONFIG_I2C_PCFISA is not set
> CONFIG_I2C_MAINBOARD=y
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_HYDRA is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_TSUNAMI is not set
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_I810 is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_VIA is not set
> CONFIG_I2C_VIAPRO=m
> # CONFIG_I2C_VOODOO3 is not set
> CONFIG_I2C_ISA=m
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_PROC=m
> 
> #
> # Hardware sensors support
> #
> CONFIG_SENSORS=y
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1024 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_FSCPOS is not set
> # CONFIG_SENSORS_FSCSCY is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_MAXILIFE is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_MTP008 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_THMC50 is not set
> CONFIG_SENSORS_VIA686A=m
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_OTHER is not set
> 
> #
> # Mice
> #
> # CONFIG_BUSMOUSE is not set
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> # CONFIG_82C710_MOUSE is not set
> # CONFIG_PC110_PAD is not set
> 
> #
> # Joysticks
> #
> # CONFIG_INPUT_GAMEPORT is not set
> 
> #
> # Input core support is needed for gameports
> #
> 
> #
> # Input core support is needed for joysticks
> #
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_INTEL_RNG is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> # CONFIG_AGP_INTEL is not set
> # CONFIG_AGP_I810 is not set
> CONFIG_AGP_VIA=y
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_SWORKS is not set
> CONFIG_DRM=y
> # CONFIG_DRM_OLD is not set
> 
> #
> # DRM 4.1 drivers
> #
> CONFIG_DRM_NEW=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_I810 is not set
> CONFIG_DRM_MGA=m
> # CONFIG_DRM_SIS is not set
> # CONFIG_MWAVE is not set
> 
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=m
> 
> #
> # Video For Linux
> #
> CONFIG_VIDEO_PROC_FS=y
> 
> #
> # Video Adapters
> #
> CONFIG_VIDEO_BT848=m
> # CONFIG_VIDEO_PMS is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_STRADIS is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_ZR36120 is not set
> 
> #
> # Radio Adapters
> #
> # CONFIG_RADIO_CADET is not set
> # CONFIG_RADIO_RTRACK is not set
> # CONFIG_RADIO_RTRACK2 is not set
> # CONFIG_RADIO_AZTECH is not set
> # CONFIG_RADIO_GEMTEK is not set
> # CONFIG_RADIO_GEMTEK_PCI is not set
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_MAESTRO is not set
> # CONFIG_RADIO_SF16FMI is not set
> # CONFIG_RADIO_TERRATEC is not set
> # CONFIG_RADIO_TRUST is not set
> # CONFIG_RADIO_TYPHOON is not set
> # CONFIG_RADIO_ZOLTRIX is not set
> 
> #
> # File systems
> #
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_REISERFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_BFS_FS is not set
> CONFIG_EXT3_FS=y
> CONFIG_JBD=y
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> # CONFIG_UMSDOS_FS is not set
> CONFIG_VFAT_FS=m
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_TMPFS is not set
> # CONFIG_RAMFS is not set
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_HPFS_FS is not set
> CONFIG_PROC_FS=y
> # CONFIG_DEVFS_FS is not set
> CONFIG_DEVPTS_FS=y
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_EXT2_FS=m
> # CONFIG_SYSV_FS is not set
> # CONFIG_UDF_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> # CONFIG_CODA_FS is not set
> # CONFIG_INTERMEZZO_FS is not set
> # CONFIG_NFS_FS is not set
> # CONFIG_NFSD is not set
> # CONFIG_SUNRPC is not set
> # CONFIG_LOCKD is not set
> CONFIG_SMB_FS=m
> # CONFIG_SMB_NLS_DEFAULT is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_ZISOFS_FS is not set
> # CONFIG_ZLIB_FS_INFLATE is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_SMB_NLS=y
> CONFIG_NLS=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> CONFIG_NLS_ISO8859_1=m
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Console drivers
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_VIDEO_SELECT is not set
> # CONFIG_MDA_CONSOLE is not set
> 
> #
> # Frame-buffer support
> #
> # CONFIG_FB is not set
> 
> #
> # Sound
> #
> CONFIG_SOUND=m
> # CONFIG_SOUND_BT878 is not set
> # CONFIG_SOUND_CMPCI is not set
> # CONFIG_SOUND_EMU10K1 is not set
> # CONFIG_SOUND_FUSION is not set
> # CONFIG_SOUND_CS4281 is not set
> # CONFIG_SOUND_ES1370 is not set
> # CONFIG_SOUND_ES1371 is not set
> # CONFIG_SOUND_ESSSOLO1 is not set
> # CONFIG_SOUND_MAESTRO is not set
> # CONFIG_SOUND_MAESTRO3 is not set
> # CONFIG_SOUND_ICH is not set
> # CONFIG_SOUND_RME96XX is not set
> # CONFIG_SOUND_SONICVIBES is not set
> # CONFIG_SOUND_TRIDENT is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_VIA82CXXX is not set
> # CONFIG_SOUND_OSS is not set
> # CONFIG_SOUND_TVMIXER is not set
> 
> #
> # USB support
> #
> # CONFIG_USB is not set
> 
> #
> # USB Controllers
> #
> 
> #
> # USB Device Class drivers
> #
> 
> #
> # USB Human Interface Devices (HID)
> #
> 
> #
> #   Input core support is needed for USB HID
> #
> 
> #
> # USB Imaging devices
> #
> 
> #
> # USB Multimedia devices
> #
> 
> #
> # USB Network adaptors
> #
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Serial Converter support
> #
> 
> #
> # USB Miscellaneous drivers
> #
> 
> #
> # Bluetooth support
> #
> # CONFIG_BLUEZ is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_DEBUG_KERNEL is not set



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTFBOuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTFBOuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:50:44 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:4042 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262386AbTFBOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:50:16 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.70bk7] Unresolved symbols
Date: Mon, 2 Jun 2003 17:06:53 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ng22+mBv5vsJQCM"
Message-Id: <200306021706.53118@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Ng22+mBv5vsJQCM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

make rpm complains a lot about unresolved symbols:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /var/tmp/kernel-2.5.70bk7-root -r 2.5.70-bk7; fi
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/drivers/char/lp.ko
depmod:         parport_set_timeout
depmod:         parport_unregister_device
depmod:         parport_write
depmod:         parport_unregister_driver
depmod:         parport_claim_or_block
depmod:         parport_register_driver
depmod:         parport_negotiate
depmod:         parport_register_device
depmod:         parport_release
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/drivers/parport/parport_pc.ko
depmod:         parport_ieee1284_epp_read_data
depmod:         parport_ieee1284_write_compat
depmod:         parport_ieee1284_epp_write_addr
depmod:         parport_parse_irqs
depmod:         parport_ieee1284_ecp_read_data
depmod:         parport_enumerate
depmod:         parport_ieee1284_ecp_write_data
depmod:         parport_ieee1284_read_nibble
depmod:         parport_ieee1284_epp_read_addr
depmod:         parport_wait_peripheral
depmod:         parport_ieee1284_ecp_write_addr
depmod:         parport_parse_dmas
depmod:         parport_proc_unregister
depmod:         parport_register_port
depmod:         parport_announce_port
depmod:         parport_wait_event
depmod:         parport_proc_register
depmod:         parport_ieee1284_read_byte
depmod:         parport_unregister_port
depmod:         parport_ieee1284_interrupt
depmod:         parport_ieee1284_epp_write_data
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/drivers/scsi/sr_mod.ko
depmod:         cdrom_open
depmod:         cdrom_release
depmod:         register_cdrom
depmod:         cdrom_ioctl
depmod:         cdrom_media_changed
depmod:         unregister_cdrom
depmod:         cdrom_number_of_slots
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/fs/lockd/lockd.ko
depmod:         rpciod_up
depmod:         rpciod_down
depmod:         xdr_decode_string_inplace
depmod:         xdr_encode_string
depmod:         rpc_restart_call
depmod:         svc_exit_thread
depmod:         nlm_debug
depmod:         svc_wake_up
depmod:         svc_makesock
depmod:         svc_destroy
depmod:         rpc_create_client
depmod:         svc_create_thread
depmod:         rpc_call_async
depmod:         xdr_encode_netobj
depmod:         svc_recv
depmod:         svc_process
depmod:         rpc_delay
depmod:         rpc_destroy_client
depmod:         xdr_decode_netobj
depmod:         svc_create
depmod:         rpc_call_sync
depmod:         xprt_set_timeout
depmod:         xprt_destroy
depmod:         xprt_create_proto
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/fs/msdos/msdos.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/fs/nfs/nfs.ko
depmod:         rpc_wake_up_task
depmod:         rpc_killall_tasks
depmod:         rpc_init_task
depmod:         xdr_encode_pages
depmod:         rpc_setbufsize
depmod:         nlmclnt_proc
depmod:         rpc_shutdown_client
depmod:         rpciod_up
depmod:         rpc_new_task
depmod:         rpciod_down
depmod:         xdr_inline_pages
depmod:         lockd_down
depmod:         rpc_unlink
depmod:         xdr_read_pages
depmod:         rpc_restart_call
depmod:         rpc_clnt_sigmask
depmod:         lockd_up
depmod:         rpc_queue_upcall
depmod:         rpc_mkpipe
depmod:         rpc_proc_unregister
depmod:         xdr_encode_array
depmod:         nfs_debug
depmod:         rpc_create_client
depmod:         rpc_sleep_on
depmod:         rpcauth_lookupcred
depmod:         rpc_clnt_sigunmask
depmod:         rpc_delay
depmod:         rpc_call_setup
depmod:         rpc_call_sync
depmod:         __rpc_purge_current_upcall
depmod:         put_rpccred
depmod:         xprt_destroy
depmod:         rpc_execute
depmod:         rpc_proc_register
depmod:         xdr_write_pages
depmod:         xdr_shift_buf
depmod:         xprt_create_proto
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/fs/nfsd/nfsd.ko
depmod:         nlmsvc_ops
depmod:         auth_domain_find
depmod:         lockd_down
depmod:         cache_fresh
depmod:         unix_domain_find
depmod:         auth_domain_put
depmod:         xdr_decode_string_inplace
depmod:         svc_reserve
depmod:         cache_flush
depmod:         cache_unregister
depmod:         svc_exit_thread
depmod:         svc_proc_unregister
depmod:         cache_check
depmod:         lockd_up
depmod:         svcauth_unix_purge
depmod:         xdr_encode_array
depmod:         svc_makesock
depmod:         svc_destroy
depmod:         svc_create_thread
depmod:         svc_recv
depmod:         cache_purge
depmod:         svc_process
depmod:         find_exported_dentry
depmod:         cache_clean
depmod:         svc_create
depmod:         cache_register
depmod:         auth_unix_lookup
depmod:         auth_unix_add_addr
depmod:         qword_add
depmod:         cache_init
depmod:         qword_get
depmod:         auth_unix_forget_old
depmod:         nfsd_debug
depmod:         svc_proc_register
depmod:         export_op_default
depmod:         qword_addhex
depmod:         svc_proc_read
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/fs/vfat/vfat.ko
depmod:         fat_scan
depmod:         fat_dir_empty
depmod:         fat_add_entries
depmod:         fat__get_entry
depmod:         fat_notify_change
depmod:         fat_date_unix2dos
depmod:         fat_build_inode
depmod:         fat_search_long
depmod:         fat_detach
depmod:         fat_attach
depmod:         fat_new_dir
depmod:         fat_fill_super
depmod: *** Unresolved symbols in /var/tmp/kernel-2.5.70bk7-root/lib/modules/2.5.70-bk7/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko
depmod:         rpc_release_client
depmod:         rpc_unlink
depmod:         rpc_wake_up
depmod:         rpcauth_lookup_credcache
depmod:         rpc_debug
depmod:         rpc_queue_upcall
depmod:         rpc_mkpipe
depmod:         rpcauth_free_credcache
depmod:         xdr_encode_netobj
depmod:         rpc_sleep_on
depmod:         rpcauth_register
depmod:         rpcauth_unregister
depmod:         rpcauth_init_credcache

--Boundary-00=_Ng22+mBv5vsJQCM
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_EMBEDDED is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
# CONFIG_PCI is not set
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
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
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_53C700_IO_MAPPED=y
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_SEAGATE is not set
CONFIG_SCSI_SIM710=y
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# I2O device support
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
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

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
CONFIG_NET_VENDOR_SMC=y
# CONFIG_WD80x3 is not set
CONFIG_ULTRA=y
# CONFIG_ULTRA32 is not set
# CONFIG_SMC9194 is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#
# CONFIG_FDDI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

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
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

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
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
# CONFIG_SMB_FS is not set
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
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
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_KALLSYMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y

--Boundary-00=_Ng22+mBv5vsJQCM--

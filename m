Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTJIJY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 05:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJIJY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 05:24:56 -0400
Received: from fep01.swip.net ([130.244.199.129]:49280 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP id S261953AbTJIJYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 05:24:46 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: error compiling
Date: Thu, 9 Oct 2003 11:24:40 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310091124.40820.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't compile 2.4.22 and 2.4.23-pre6 with this options:

cat .config|grep -v ^#|grep [[:alnum:]]
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M386=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_MCE=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_CPQ_DA=y
CONFIG_BLK_CPQ_CISS_DA=y
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_BLK_DEV_LVM=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=15000
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_I2O=y
CONFIG_I2O_PCI=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_LAN=y
CONFIG_I2O_SCSI=y
CONFIG_I2O_PROC=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_E100=y
CONFIG_ACENIC=y
CONFIG_E1000=y
CONFIG_FDDI=y
CONFIG_DEFXX=y
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_INTEL_RNG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_ZISOFS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_ISO8859_2=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDDEV=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m


        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o 
drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o 
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o 
drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o 
drivers/media/media.o drivers/input/inputdrv.o drivers/message/i2o/i2o.o 
drivers/md/mddev.o arch/i386/math-emu/math.o \
        net/network.o \
        /usr/src/linux-2.4.22/arch/i386/lib/lib.a 
/usr/src/linux-2.4.22/lib/lib.a /usr/src/linux-2.4.22/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
kernel/kernel.o(.data+0x61c): undefined reference to `net_table'
drivers/block/block.o(.text.init+0xaf): In function `device_init':
: undefined reference to `net_dev_init'
drivers/net/net.o(.text+0x1587): In function `e1000_82547_tx_fifo_stall':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1590): In function `e1000_82547_tx_fifo_stall':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1652): In function `e1000_watchdog':
: undefined reference to `__netdev_watchdog_up'
drivers/net/net.o(.text+0x168c): In function `e1000_watchdog':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1695): In function `e1000_watchdog':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x18e6): In function `e1000_xmit_frame':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x18f2): In function `e1000_xmit_frame':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1e53): In function `e1000_tx_timeout_task':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1e5c): more undefined references to `softnet_data' 
follow
drivers/net/net.o(.text+0x1e72): In function `e1000_tx_timeout_task':
: undefined reference to `__netdev_watchdog_up'
drivers/net/net.o(.text+0x2613): In function `e1000_clean_tx_irq':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x261b): In function `e1000_clean_tx_irq':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x2709): In function `e1000_clean_tx_irq':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x2712): In function `e1000_clean_tx_irq':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x27d4): In function `e1000_clean_rx_irq':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x27dc): more undefined references to `softnet_data' 
follow
drivers/net/net.o(.text+0x29bb): In function `e1000_clean_rx_irq':
: undefined reference to `eth_type_trans'
drivers/net/net.o(.text+0x2a99): In function `e1000_clean_rx_irq':
: undefined reference to `netif_rx'
drivers/net/net.o(.text+0xbb88): In function `ace_load_jumbo_rx_ring':
: undefined reference to `net_ratelimit'
drivers/net/net.o(.text+0xbf87): In function `ace_rx_int':
: undefined reference to `eth_type_trans'
drivers/net/net.o(.text+0xbfb6): In function `ace_rx_int':
: undefined reference to `netif_rx'
drivers/net/net.o(.text+0xc115): In function `ace_interrupt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xc11d): In function `ace_interrupt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xc18a): In function `ace_interrupt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xc197): In function `ace_interrupt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xc895): In function `ace_start_xmit':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xc8a2): more undefined references to `softnet_data' 
follow
drivers/net/net.o(.text+0xed98): In function `e100_rx_srv':
: undefined reference to `eth_type_trans'
drivers/net/net.o(.text+0xeeb8): In function `e100_rx_srv':
: undefined reference to `netif_rx'
drivers/net/net.o(.text+0xf738): In function `e100_exec_non_cu_cmd':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xf741): In function `e100_exec_non_cu_cmd':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xfd67): In function `e100_deisolate_driver':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0xfd70): In function `e100_deisolate_driver':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x11f34): In function `e100_non_tx_background':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x11f3d): more undefined references to `softnet_data' 
follow
drivers/net/net.o(.text+0x1413d): In function `e100_update_link_state':
: undefined reference to `__netdev_watchdog_up'
drivers/net/net.o(.text+0x153cc): In function `init_netdev':
: undefined reference to `dev_alloc_name'
drivers/net/net.o(.text+0x153f6): In function `init_netdev':
: undefined reference to `netdev_boot_setup_check'
drivers/net/net.o(.text+0x15405): In function `init_netdev':
: undefined reference to `rtnl_lock'
drivers/net/net.o(.text+0x1540b): In function `init_netdev':
: undefined reference to `register_netdevice'
drivers/net/net.o(.text+0x15412): In function `init_netdev':
: undefined reference to `rtnl_unlock'
drivers/net/net.o(.text+0x15531): In function `ether_setup':
: undefined reference to `eth_header'
drivers/net/net.o(.text+0x1553b): In function `ether_setup':
: undefined reference to `eth_rebuild_header'
drivers/net/net.o(.text+0x1554f): In function `ether_setup':
: undefined reference to `eth_header_cache'
drivers/net/net.o(.text+0x15559): In function `ether_setup':
: undefined reference to `eth_header_cache_update'
drivers/net/net.o(.text+0x15563): In function `ether_setup':
: undefined reference to `eth_header_parse'
drivers/net/net.o(.text+0x155c1): In function `fddi_setup':
: undefined reference to `fddi_header'
drivers/net/net.o(.text+0x155cb): In function `fddi_setup':
: undefined reference to `fddi_rebuild_header'
drivers/net/net.o(.text+0x1561c): In function `register_netdev':
: undefined reference to `rtnl_lock'
drivers/net/net.o(.text+0x15641): In function `register_netdev':
: undefined reference to `dev_alloc_name'
drivers/net/net.o(.text+0x1565f): In function `register_netdev':
: undefined reference to `dev_alloc_name'
drivers/net/net.o(.text+0x1566e): In function `register_netdev':
: undefined reference to `register_netdevice'
drivers/net/net.o(.text+0x15678): In function `register_netdev':
: undefined reference to `rtnl_unlock'
drivers/net/net.o(.text+0x1568a): In function `unregister_netdev':
: undefined reference to `rtnl_lock'
drivers/net/net.o(.text+0x15690): In function `unregister_netdev':
: undefined reference to `unregister_netdevice'
drivers/net/net.o(.text+0x15695): In function `unregister_netdev':
: undefined reference to `rtnl_unlock'
drivers/net/net.o(.text+0x15734): In function `loopback_xmit':
: undefined reference to `eth_type_trans'
drivers/net/net.o(.text+0x1575e): In function `loopback_xmit':
: undefined reference to `netif_rx'
drivers/net/net.o(.text+0x16344): In function `dfx_int_common':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1634d): In function `dfx_int_common':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x171e2): In function `dfx_rcv_queue_process':
: undefined reference to `fddi_type_trans'
drivers/net/net.o(.text+0x171f9): In function `dfx_rcv_queue_process':
: undefined reference to `netif_rx'
drivers/net/net.o(.text+0x172c2): In function `dfx_xmt_queue_pkt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x172cb): In function `dfx_xmt_queue_pkt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1749d): In function `dfx_xmt_queue_pkt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x174a6): In function `dfx_xmt_queue_pkt':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x1752e): In function `dfx_xmt_done':
: undefined reference to `softnet_data'
drivers/net/net.o(.text+0x17536): more undefined references to `softnet_data' 
follow
drivers/net/net.o(.text.init+0x153d): In function `loopback_init':
: undefined reference to `eth_header'
drivers/net/net.o(.text.init+0x1547): In function `loopback_init':
: undefined reference to `eth_header_cache'
drivers/net/net.o(.text.init+0x1551): In function `loopback_init':
: undefined reference to `eth_header_cache_update'
drivers/net/net.o(.text.init+0x1578): In function `loopback_init':
: undefined reference to `eth_rebuild_header'
drivers/message/i2o/i2o.o(.text+0x69d3): In function `i2o_lan_handle_failure':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x69db): In function `i2o_lan_handle_failure':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x6a43): In function `i2o_lan_handle_failure':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x6a50): In function `i2o_lan_handle_failure':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x6a9a): In function `i2o_lan_handle_failure':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x6aa2): more undefined references to 
`softnet_data' follow
drivers/message/i2o/i2o.o(.text+0x7043): In function 
`i2o_lan_receive_post_reply':
: undefined reference to `netif_rx'
drivers/message/i2o/i2o.o(.text+0x7203): In function 
`i2o_lan_release_buckets':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x720b): In function 
`i2o_lan_release_buckets':
: undefined reference to `softnet_data'
drivers/message/i2o/i2o.o(.text+0x73bb): In function `i2o_lan_handle_event':
: undefined reference to `__netdev_watchdog_up'
drivers/message/i2o/i2o.o(.text+0x81b7): In function 
`i2o_lan_register_device':
: undefined reference to `eth_type_trans'
drivers/message/i2o/i2o.o(.text+0x8202): In function 
`i2o_lan_register_device':
: undefined reference to `dev_alloc_name'
drivers/message/i2o/i2o.o(.text+0x8221): In function 
`i2o_lan_register_device':
: undefined reference to `fddi_type_trans'
drivers/message/i2o/i2o.o(.text+0x8229): In function 
`i2o_lan_register_device':
: undefined reference to `unregister_netdevice'
drivers/message/i2o/i2o.o(.text+0x8482): In function `i2o_lan_exit':
: undefined reference to `unregister_netdevice'
net/network.o(.text+0x205c): In function `sock_setsockopt':
: undefined reference to `tcp_set_keepalive'
net/network.o(.text+0x2282): In function `sock_setsockopt':
: undefined reference to `dev_get_by_name'
net/network.o(.text+0x22ba): In function `sock_setsockopt':
: undefined reference to `netdev_finish_unregister'
net/network.o(.text+0x2326): In function `sock_setsockopt':
: undefined reference to `sk_attach_filter'
net/network.o(.text.init+0x51): In function `sock_init':
: undefined reference to `rtnetlink_init'
net/network.o(.text.init+0x56): In function `sock_init':
: undefined reference to `init_netlink'
net/network.o(.text.init+0x5b): In function `sock_init':
: undefined reference to `netfilter_init'
make: *** [vmlinux] Error 1
tata:/usr/src/linux-2.4.22# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)


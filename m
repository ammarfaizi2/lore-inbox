Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265169AbUELTN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUELTN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265194AbUELTN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:13:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:34555 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S265169AbUELS4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:56:00 -0400
From: mporter@kernel.crashing.org
Message-Id: <200405121855.LAA13603@liberty.homelinux.org>
Subject: [PATCH 2/8] PPC32: Bubinga/405EP for new OCP
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 11:55:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge Bubinga/405EP support against new OCP.
Please apply.

diff -Nru a/arch/ppc/configs/bubinga_defconfig b/arch/ppc/configs/bubinga_defconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/configs/bubinga_defconfig	Wed May 12 09:24:09 2004
@@ -0,0 +1,593 @@
+#
+# Automatically generated make config: don't edit
+#
+CONFIG_MMU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+# CONFIG_STANDALONE is not set
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_HOTPLUG is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+# CONFIG_KALLSYMS is not set
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+# CONFIG_6xx is not set
+CONFIG_40x=y
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_CPU_FREQ is not set
+CONFIG_4xx=y
+
+#
+# IBM 4xx options
+#
+# CONFIG_ASH is not set
+CONFIG_BUBINGA=y
+# CONFIG_CPCI405 is not set
+# CONFIG_EP405 is not set
+# CONFIG_OAK is not set
+# CONFIG_REDWOOD_5 is not set
+# CONFIG_REDWOOD_6 is not set
+# CONFIG_SYCAMORE is not set
+# CONFIG_WALNUT is not set
+CONFIG_IBM405_ERR77=y
+CONFIG_IBM405_ERR51=y
+CONFIG_IBM_OCP=y
+CONFIG_BIOS_FIXUP=y
+CONFIG_405EP=y
+CONFIG_IBM_OPENBIOS=y
+# CONFIG_PM is not set
+CONFIG_UART0_TTYS0=y
+# CONFIG_UART0_TTYS1 is not set
+CONFIG_NOT_COHERENT_CACHE=y
+
+#
+# Platform options
+#
+# CONFIG_PC_KEYBOARD is not set
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_HIGHMEM is not set
+CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
+# CONFIG_PCI_NAMES is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_LBD is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_PACKET is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_IPV6 is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NETFILTER is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_OAKNET is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+CONFIG_IBM_EMAC=y
+# CONFIG_IBM_EMAC_ERRMSG is not set
+CONFIG_IBM_EMAC_RXB=64
+CONFIG_IBM_EMAC_TXB=8
+CONFIG_IBM_EMAC_FGAP=8
+CONFIG_IBM_EMAC_SKBRES=0
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+# CONFIG_RCPCI is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# Amateur Radio support
+#
+# CONFIG_HAMRADIO is not set
+
+#
+# IrDA (infrared) support
+#
+# CONFIG_IRDA is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+# CONFIG_SERIO_CT82C710 is not set
+# CONFIG_SERIO_PCIPS2 is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_QIC02_TAPE is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_JBD is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_FAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+# CONFIG_DEVFS_FS is not set
+# CONFIG_DEVPTS_FS_XATTR is not set
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+# CONFIG_EXPORTFS is not set
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_INTERMEZZO_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_NEC98_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# IBM 40x options
+#
+
+#
+# Library routines
+#
+CONFIG_CRC32=y
+
+#
+# Kernel hacking
+#
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
+CONFIG_PPC_OCP=y
+
+#
+# Security options
+#
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
diff -Nru a/arch/ppc/platforms/4xx/bubinga.c b/arch/ppc/platforms/4xx/bubinga.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/platforms/4xx/bubinga.c	Wed May 12 09:24:09 2004
@@ -0,0 +1,263 @@
+/*
+ * Support for IBM PPC 405EP evaluation board (Bubinga).
+ *
+ * Author: SAW (IBM), derived from walnut.c.
+ *         Maintained by MontaVista Software <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/blkdev.h>
+#include <linux/pci.h>
+#include <linux/rtc.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+
+#include <asm/system.h>
+#include <asm/pci-bridge.h>
+#include <asm/processor.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/todc.h>
+#include <asm/kgdb.h>
+#include <asm/ocp.h>
+#include <asm/ibm_ocp_pci.h>
+
+#include <platforms/4xx/ibm405ep.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+extern bd_t __res;
+
+void *bubinga_rtc_base;
+
+/* Some IRQs unique to the board
+ * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
+ */
+int __init
+ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	    /*
+	     *      PCI IDSEL/INTPIN->INTLINE
+	     *      A       B       C       D
+	     */
+	{
+		{28, 28, 28, 28},	/* IDSEL 1 - PCI slot 1 */
+		{29, 29, 29, 29},	/* IDSEL 2 - PCI slot 2 */
+		{30, 30, 30, 30},	/* IDSEL 3 - PCI slot 3 */
+		{31, 31, 31, 31},	/* IDSEL 4 - PCI slot 4 */
+	};
+
+	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+};
+
+/* The serial clock for the chip is an internal clock determined by
+ * different clock speeds/dividers.
+ * Calculate the proper input baud rate and setup the serial driver.
+ */
+static void __init
+bubinga_early_serial_map(void)
+{
+	u32 uart_div;
+	int uart_clock;
+	struct uart_port port;
+
+         /* Calculate the serial clock input frequency
+          *
+          * The base baud is the PLL OUTA (provided in the board info
+          * structure) divided by the external UART Divisor, divided
+          * by 16.
+          */
+	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
+	uart_clock = __res.bi_pllouta_freq / uart_div;
+
+	/* Setup serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = (void*)ACTING_UART0_IO_BASE;
+	port.irq = ACTING_UART0_INT;
+	port.uartclk = uart_clock;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}	
+	
+	port.membase = (void*)ACTING_UART1_IO_BASE;
+	port.irq = ACTING_UART1_INT;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}	
+}
+
+void __init
+bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
+{
+
+	unsigned int bar_response, bar;
+	/*
+	 * Expected PCI mapping:
+	 *
+	 *  PLB addr             PCI memory addr
+	 *  ---------------------       ---------------------
+	 *  0000'0000 - 7fff'ffff <---  0000'0000 - 7fff'ffff
+	 *  8000'0000 - Bfff'ffff --->  8000'0000 - Bfff'ffff
+	 *
+	 *  PLB addr             PCI io addr
+	 *  ---------------------       ---------------------
+	 *  e800'0000 - e800'ffff --->  0000'0000 - 0001'0000
+	 *
+	 * The following code is simplified by assuming that the bootrom
+	 * has been well behaved in following this mapping.
+	 */
+
+#ifdef DEBUG
+	int i;
+
+	printk("ioremap PCLIO_BASE = 0x%x\n", pcip);
+	printk("PCI bridge regs before fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+	}
+	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
+	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
+	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
+	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
+
+#endif
+
+	/* added for IBM boot rom version 1.15 bios bar changes  -AK */
+
+	/* Disable region first */
+	out_le32((void *) &(pcip->pmm[0].ma), 0x00000000);
+	/* PLB starting addr, PCI: 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].la), 0x80000000);
+	/* PCI start addr, 0x80000000 */
+	out_le32((void *) &(pcip->pmm[0].pcila), PPC405_PCI_MEM_BASE);
+	/* 512MB range of PLB to PCI */
+	out_le32((void *) &(pcip->pmm[0].pciha), 0x00000000);
+	/* Enable no pre-fetch, enable region */
+	out_le32((void *) &(pcip->pmm[0].ma), ((0xffffffff -
+						(PPC405_PCI_UPPER_MEM -
+						 PPC405_PCI_MEM_BASE)) | 0x01));
+
+	/* Disable region one */
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[1].ma), 0x00000000);
+	out_le32((void *) &(pcip->ptm1ms), 0x00000001);
+
+	/* Disable region two */
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].la), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pcila), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].pciha), 0x00000000);
+	out_le32((void *) &(pcip->pmm[2].ma), 0x00000000);
+	out_le32((void *) &(pcip->ptm2ms), 0x00000000);
+	out_le32((void *) &(pcip->ptm2la), 0x00000000);
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+		DBG("BUS %d, device %d, Function %d bar 0x%8.8x is 0x%8.8x\n",
+		    hose->first_busno, PCI_SLOT(hose->first_busno),
+		    PCI_FUNC(hose->first_busno), bar, bar_response);
+	}
+	/* end work arround */
+
+#ifdef DEBUG
+	printk("PCI bridge regs after fixup \n");
+	for (i = 0; i <= 3; i++) {
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].ma)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].la)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pcila)));
+		printk(" pmm%dma\t0x%x\n", i, in_le32(&(pcip->pmm[i].pciha)));
+	}
+	printk(" ptm1ms\t0x%x\n", in_le32(&(pcip->ptm1ms)));
+	printk(" ptm1la\t0x%x\n", in_le32(&(pcip->ptm1la)));
+	printk(" ptm2ms\t0x%x\n", in_le32(&(pcip->ptm2ms)));
+	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
+
+#endif
+}
+
+void __init
+bubinga_setup_arch(void)
+{
+	ppc4xx_setup_arch();
+
+	ibm_ocp_set_emac(0, 1);
+
+        bubinga_early_serial_map();
+
+        /* RTC step for the evb405ep */
+        bubinga_rtc_base = (void *) BUBINGA_RTC_VADDR;
+        TODC_INIT(TODC_TYPE_DS1743, bubinga_rtc_base, bubinga_rtc_base,
+                  bubinga_rtc_base, 8);
+        /* Identify the system */
+        printk("IBM Bubinga port (MontaVista Software, Inc. <source@mvista.com>)\n");
+}
+
+void __init
+bubinga_map_io(void)
+{
+	ppc4xx_map_io();
+     	io_block_mapping(BUBINGA_RTC_VADDR,
+                         BUBINGA_RTC_PADDR, BUBINGA_RTC_SIZE, _PAGE_IO);
+}
+
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = bubinga_setup_arch;
+	ppc_md.setup_io_mappings = bubinga_map_io;
+
+#ifdef CONFIG_GEN_RTC
+	ppc_md.time_init = todc_time_init;
+	ppc_md.set_rtc_time = todc_set_rtc_time;
+	ppc_md.get_rtc_time = todc_get_rtc_time;
+	ppc_md.nvram_read_val = todc_direct_read_val;
+	ppc_md.nvram_write_val = todc_direct_write_val;
+#endif
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = bubinga_early_serial_map;
+#endif
+}
+
diff -Nru a/arch/ppc/platforms/4xx/bubinga.h b/arch/ppc/platforms/4xx/bubinga.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/platforms/4xx/bubinga.h	Wed May 12 09:24:09 2004
@@ -0,0 +1,69 @@
+/*
+ * Support for IBM PPC 405EP evaluation board (Bubinga).
+ *
+ * Author: SAW (IBM), derived from walnut.h.
+ *         Maintained by MontaVista Software <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __BUBINGA_H__
+#define __BUBINGA_H__
+
+/* 405EP */
+#include <platforms/4xx/ibm405ep.h>
+
+#ifndef __ASSEMBLY__
+/*
+ * Data structure defining board information maintained by the boot
+ * ROM on IBM's evaluation board. An effort has been made to
+ * keep the field names consistent with the 8xx 'bd_t' board info
+ * structures.
+ */
+
+typedef struct board_info {
+        unsigned char    bi_s_version[4];       /* Version of this structure */
+        unsigned char    bi_r_version[30];      /* Version of the IBM ROM */
+        unsigned int     bi_memsize;            /* DRAM installed, in bytes */
+        unsigned char    bi_enetaddr[2][6];     /* Local Ethernet MAC address */        unsigned char    bi_pci_enetaddr[6];    /* PCI Ethernet MAC address */
+        unsigned int     bi_intfreq;            /* Processor speed, in Hz */
+        unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
+        unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
+        unsigned int     bi_opb_busfreq;        /* OPB Bus speed, in Hz */
+        unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
+} bd_t;
+
+/* Some 4xx parts use a different timebase frequency from the internal clock.
+*/
+#define bi_tbfreq bi_intfreq
+
+
+/* Memory map for the Bubinga board.
+ * Generic 4xx plus RTC.
+ */
+
+extern void *bubinga_rtc_base;
+#define BUBINGA_RTC_PADDR	((uint)0xf0000000)
+#define BUBINGA_RTC_VADDR	BUBINGA_RTC_PADDR
+#define BUBINGA_RTC_SIZE	((uint)8*1024)
+
+/* The UART clock is based off an internal clock -
+ * define BASE_BAUD based on the internal clock and divider(s).
+ * Since BASE_BAUD must be a constant, we will initialize it
+ * using clock/divider values which OpenBIOS initializes
+ * for typical configurations at various CPU speeds.
+ * The base baud is calculated as (FWDA / EXT UART DIV / 16)
+ */
+#define BASE_BAUD       0
+
+#define BUBINGA_FPGA_BASE      0xF0300000
+
+#define PPC4xx_MACHINE_NAME     "IBM Bubinga"
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __BUBINGA_H__ */
+#endif /* __KERNEL__ */
diff -Nru a/arch/ppc/platforms/4xx/ibm405ep.c b/arch/ppc/platforms/4xx/ibm405ep.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/platforms/4xx/ibm405ep.c	Wed May 12 09:24:09 2004
@@ -0,0 +1,134 @@
+/*
+ * arch/ppc/platforms/ibm405ep.c
+ *
+ * Support for IBM PPC 405EP processors.
+ *
+ * Author: SAW (IBM), derived from ibmnp405l.c.
+ *         Maintained by MontaVista Software <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/param.h>
+#include <linux/string.h>
+
+#include <asm/ibm4xx.h>
+#include <asm/ocp.h>
+
+#include <platforms/4xx/ibm405ep.h>
+
+static struct ocp_func_mal_data ibm405ep_mal0_def = {
+	.num_tx_chans	= 4,		/* Number of TX channels */
+	.num_rx_chans	= 2,		/* Number of RX channels */
+	.txeob_irq	= 11,		/* TX End Of Buffer IRQ  */	
+	.rxeob_irq	= 12,		/* RX End Of Buffer IRQ  */
+	.txde_irq	= 13,		/* TX Descriptor Error IRQ */
+	.rxde_irq	= 14,		/* RX Descriptor Error IRQ */
+	.serr_irq	= 10,		/* MAL System Error IRQ    */
+};
+OCP_SYSFS_MAL_DATA()
+
+static struct ocp_func_emac_data ibm405ep_emac0_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= -1,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 0,		/* MAL rx channel number */
+	.mal_tx_chan	= 0,		/* MAL tx channel number */
+	.wol_irq	= 9,		/* WOL interrupt number */
+	.mdio_idx	= 0,		/* MDIO via EMAC0 */
+	.tah_idx	= -1,		/* No TAH */
+};
+
+static struct ocp_func_emac_data ibm405ep_emac1_def = {
+	.rgmii_idx	= -1,		/* No RGMII */
+	.rgmii_mux	= -1,		/* No RGMII */
+	.zmii_idx	= -1,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 1,		/* MAL rx channel number */
+	.mal_tx_chan	= 2,		/* MAL tx channel number */
+	.wol_irq	= 9,		/* WOL interrupt number */
+	.mdio_idx	= 0,		/* MDIO via EMAC0 */
+	.tah_idx	= -1,		/* No TAH */
+};
+OCP_SYSFS_EMAC_DATA()
+
+static struct ocp_func_iic_data ibm405ep_iic0_def = {
+	.fast_mode	= 0,		/* Use standad mode (100Khz) */
+};
+OCP_SYSFS_IIC_DATA()
+
+struct ocp_def core_ocp[] = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= 0xEF600000,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= 0xEF600500,
+	  .irq		= 2,
+	  .pm		= IBM_CPM_IIC0,
+	  .additions	= &ibm405ep_iic0_def,
+	  .show		= &ocp_show_iic_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= 0xEF600700,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm405ep_mal0_def,
+	  .show		= &ocp_show_mal_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= EMAC0_BASE,
+	  .irq		= 15,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm405ep_emac0_def,
+	  .show		= &ocp_show_emac_data
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 1,
+	  .paddr	= 0xEF600900,
+	  .irq		= 17,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm405ep_emac1_def,
+	  .show		= &ocp_show_emac_data
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
diff -Nru a/arch/ppc/platforms/4xx/ibm405ep.h b/arch/ppc/platforms/4xx/ibm405ep.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/platforms/4xx/ibm405ep.h	Wed May 12 09:24:09 2004
@@ -0,0 +1,148 @@
+/*
+ * arch/ppc/platforms/4xx/ibm405ep.h
+ *
+ * IBM PPC 405EP processor defines.
+ *
+ * Author: SAW (IBM), derived from ibm405gp.h.
+ *         Maintained by MontaVista Software <source@mvista.com>
+ *
+ * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_IBM405EP_H__
+#define __ASM_IBM405EP_H__
+
+#include <linux/config.h>
+
+/* ibm405.h at bottom of this file */
+
+/* PCI
+ * PCI Bridge config reg definitions
+ * see 17-19 of manual
+ */
+
+#define PPC405_PCI_CONFIG_ADDR	0xeec00000
+#define PPC405_PCI_CONFIG_DATA	0xeec00004
+
+#define PPC405_PCI_PHY_MEM_BASE	0x80000000	/* hose_a->pci_mem_offset */
+						/* setbat */
+#define PPC405_PCI_MEM_BASE	PPC405_PCI_PHY_MEM_BASE	/* setbat */
+#define PPC405_PCI_PHY_IO_BASE	0xe8000000	/* setbat */
+#define PPC405_PCI_IO_BASE	PPC405_PCI_PHY_IO_BASE	/* setbat */
+
+#define PPC405_PCI_LOWER_MEM	0x80000000	/* hose_a->mem_space.start */
+#define PPC405_PCI_UPPER_MEM	0xBfffffff	/* hose_a->mem_space.end */
+#define PPC405_PCI_LOWER_IO	0x00000000	/* hose_a->io_space.start */
+#define PPC405_PCI_UPPER_IO	0x0000ffff	/* hose_a->io_space.end */
+
+#define PPC405_ISA_IO_BASE	PPC405_PCI_IO_BASE
+
+#define PPC4xx_PCI_IO_PADDR	((uint)PPC405_PCI_PHY_IO_BASE)
+#define PPC4xx_PCI_IO_VADDR	PPC4xx_PCI_IO_PADDR
+#define PPC4xx_PCI_IO_SIZE	((uint)64*1024)
+#define PPC4xx_PCI_CFG_PADDR	((uint)PPC405_PCI_CONFIG_ADDR)
+#define PPC4xx_PCI_CFG_VADDR	PPC4xx_PCI_CFG_PADDR
+#define PPC4xx_PCI_CFG_SIZE	((uint)4*1024)
+#define PPC4xx_PCI_LCFG_PADDR	((uint)0xef400000)
+#define PPC4xx_PCI_LCFG_VADDR	PPC4xx_PCI_LCFG_PADDR
+#define PPC4xx_PCI_LCFG_SIZE	((uint)4*1024)
+#define PPC4xx_ONB_IO_PADDR	((uint)0xef600000)
+#define PPC4xx_ONB_IO_VADDR	PPC4xx_ONB_IO_PADDR
+#define PPC4xx_ONB_IO_SIZE	((uint)4*1024)
+
+/* serial port defines */
+#define RS_TABLE_SIZE	2
+
+#define UART0_INT	0
+#define UART1_INT	1
+
+#define PCIL0_BASE	0xEF400000
+#define UART0_IO_BASE	0xEF600300
+#define UART1_IO_BASE	0xEF600400
+#define EMAC0_BASE	0xEF600800
+
+#define BD_EMAC_ADDR(e,i) bi_enetaddr[e][i]
+
+#if defined(CONFIG_UART0_TTYS0)
+#define ACTING_UART0_IO_BASE	UART0_IO_BASE
+#define ACTING_UART1_IO_BASE	UART1_IO_BASE
+#define ACTING_UART0_INT	UART0_INT
+#define ACTING_UART1_INT	UART1_INT
+#else
+#define ACTING_UART0_IO_BASE	UART1_IO_BASE
+#define ACTING_UART1_IO_BASE	UART0_IO_BASE
+#define ACTING_UART0_INT	UART1_INT
+#define ACTING_UART1_INT	UART0_INT
+#endif
+
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, ACTING_UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: (u8 *)ACTING_UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_DEBUG_IO_BASE	ACTING_UART0_IO_BASE
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)
+
+/* DCR defines */
+#define DCRN_CPMSR_BASE         0x0BA
+#define DCRN_CPMFR_BASE         0x0B9
+
+#define DCRN_CPC0_PLLMR0_BASE   0x0F0
+#define DCRN_CPC0_BOOT_BASE     0x0F1
+#define DCRN_CPC0_CR1_BASE      0x0F2
+#define DCRN_CPC0_EPRCSR_BASE   0x0F3
+#define DCRN_CPC0_PLLMR1_BASE   0x0F4
+#define DCRN_CPC0_UCR_BASE      0x0F5
+#define DCRN_CPC0_UCR_U0DIV     0x07F
+#define DCRN_CPC0_SRR_BASE      0x0F6
+#define DCRN_CPC0_JTAGID_BASE   0x0F7
+#define DCRN_CPC0_SPARE_BASE    0x0F8
+#define DCRN_CPC0_PCI_BASE      0x0F9
+
+
+#define IBM_CPM_GPT             0x80000000      /* GPT interface */
+#define IBM_CPM_PCI             0x40000000      /* PCI bridge */
+#define IBM_CPM_UIC             0x00010000      /* Universal Int Controller */
+#define IBM_CPM_CPU             0x00008000      /* processor core */
+#define IBM_CPM_EBC             0x00002000      /* EBC controller */
+#define IBM_CPM_SDRAM0          0x00004000      /* SDRAM memory controller */
+#define IBM_CPM_GPIO0           0x00001000      /* General Purpose IO */
+#define IBM_CPM_TMRCLK          0x00000400      /* CPU timers */
+#define IBM_CPM_PLB             0x00000100      /* PLB bus arbiter */
+#define IBM_CPM_OPB             0x00000080      /* PLB to OPB bridge */
+#define IBM_CPM_DMA             0x00000040      /* DMA controller */
+#define IBM_CPM_IIC0            0x00000010      /* IIC interface */
+#define IBM_CPM_UART1           0x00000002      /* serial port 0 */
+#define IBM_CPM_UART0           0x00000001      /* serial port 1 */
+#define DFLT_IBM4xx_PM          ~(IBM_CPM_PCI | IBM_CPM_CPU | IBM_CPM_DMA \
+                                        | IBM_CPM_OPB | IBM_CPM_EBC \
+                                        | IBM_CPM_SDRAM0 | IBM_CPM_PLB \
+                                        | IBM_CPM_UIC | IBM_CPM_TMRCLK)
+#define DCRN_DMA0_BASE          0x100
+#define DCRN_DMA1_BASE          0x108
+#define DCRN_DMA2_BASE          0x110
+#define DCRN_DMA3_BASE          0x118
+#define DCRNCAP_DMA_SG          1       /* have DMA scatter/gather capability */
+#define DCRN_DMASR_BASE         0x120
+#define DCRN_EBC_BASE           0x012
+#define DCRN_DCP0_BASE          0x014
+#define DCRN_MAL_BASE           0x180
+#define DCRN_OCM0_BASE          0x018
+#define DCRN_PLB0_BASE          0x084
+#define DCRN_PLLMR_BASE         0x0B0
+#define DCRN_POB0_BASE          0x0A0
+#define DCRN_SDRAM0_BASE        0x010
+#define DCRN_UIC0_BASE          0x0C0
+#define UIC0 DCRN_UIC0_BASE
+
+#include <asm/ibm405.h>
+
+#endif				/* __ASM_IBM405EP_H__ */
+#endif				/* __KERNEL__ */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTFGHwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTFGHvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:51:32 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:45837 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262720AbTFGHvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:51:02 -0400
Date: Sat, 7 Jun 2003 10:04:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Docbook update
Message-ID: <20030607080436.GC8943@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030607080226.GA8943@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607080226.GA8943@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1316.1.1 -> 1.1316.1.2
#	drivers/net/sis900.c	1.36    -> 1.37   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/07	sam@mars.ravnborg.org	1.1316.1.2
# docbook: Recognize sis900 functions
# 
# Adapted comments to follow what kernel-doc (docbook) understands
# --------------------------------------------
#
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Sat Jun  7 09:53:46 2003
+++ b/drivers/net/sis900.c	Sat Jun  7 09:53:46 2003
@@ -211,7 +211,7 @@
 static void sis900_set_mode (long ioaddr, int speed, int duplex);
 
 /**
- *	sis900_get_mac_addr: - Get MAC address for stand alone SiS900 model
+ *	sis900_get_mac_addr - Get MAC address for stand alone SiS900 model
  *	@pci_dev: the sis900 pci device
  *	@net_dev: the net device to get address for 
  *
@@ -241,7 +241,7 @@
 }
 
 /**
- *	sis630e_get_mac_addr: - Get MAC address for SiS630E model
+ *	sis630e_get_mac_addr - Get MAC address for SiS630E model
  *	@pci_dev: the sis900 pci device
  *	@net_dev: the net device to get address for 
  *
@@ -274,7 +274,7 @@
 
 
 /**
- *	sis635_get_mac_addr: - Get MAC address for SIS635 model
+ *	sis635_get_mac_addr - Get MAC address for SIS635 model
  *	@pci_dev: the sis900 pci device
  *	@net_dev: the net device to get address for 
  *
@@ -310,7 +310,7 @@
 }
 
 /**
- *	sis96x_get_mac_addr: - Get MAC address for SiS962 or SiS963 model
+ *	sis96x_get_mac_addr - Get MAC address for SiS962 or SiS963 model
  *	@pci_dev: the sis900 pci device
  *	@net_dev: the net device to get address for 
  *
@@ -352,7 +352,7 @@
 }
 
 /**
- *	sis900_probe: - Probe for sis900 device
+ *	sis900_probe - Probe for sis900 device
  *	@pci_dev: the sis900 pci device
  *	@pci_id: the pci device ID
  *
@@ -498,7 +498,7 @@
 }
 
 /**
- *	sis900_mii_probe: - Probe MII PHY for sis900
+ *	sis900_mii_probe - Probe MII PHY for sis900
  *	@net_dev: the net device to probe for
  *	
  *	Search for total of 32 possible mii phy addresses.
@@ -618,7 +618,7 @@
 }
 
 /**
- *	sis900_default_phy: - Select default PHY for sis900 mac.
+ *	sis900_default_phy - Select default PHY for sis900 mac.
  *	@net_dev: the net device to probe for
  *
  *	Select first detected PHY with link as default.
@@ -671,7 +671,7 @@
 
 
 /**
- * 	sis900_set_capability: - set the media capability of network adapter.
+ * 	sis900_set_capability - set the media capability of network adapter.
  *	@net_dev : the net device to probe for
  *	@phy : default PHY
  *
@@ -701,7 +701,7 @@
 #define eeprom_delay()  inl(ee_addr)
 
 /**
- *	read_eeprom: - Read Serial EEPROM
+ *	read_eeprom - Read Serial EEPROM
  *	@ioaddr: base i/o address
  *	@location: the EEPROM location to read
  *
@@ -776,7 +776,7 @@
 }
 
 /**
- *	mdio_read: - read MII PHY register
+ *	mdio_read - read MII PHY register
  *	@net_dev: the net device to read
  *	@phy_id: the phy address to read
  *	@location: the phy regiester id to read
@@ -818,7 +818,7 @@
 }
 
 /**
- *	mdio_write: - write MII PHY register
+ *	mdio_write - write MII PHY register
  *	@net_dev: the net device to write
  *	@phy_id: the phy address to write
  *	@location: the phy regiester id to write
@@ -872,7 +872,7 @@
 
 
 /**
- *	sis900_reset_phy: - reset sis900 mii phy.
+ *	sis900_reset_phy - reset sis900 mii phy.
  *	@net_dev: the net device to write
  *	@phy_addr: default phy address
  *
@@ -895,7 +895,7 @@
 }
 
 /**
- *	sis900_open: - open sis900 device
+ *	sis900_open - open sis900 device
  *	@net_dev: the net device to open
  *
  *	Do some initialization and start net interface.
@@ -952,7 +952,7 @@
 }
 
 /**
- *	sis900_init_rxfilter: - Initialize the Rx filter
+ *	sis900_init_rxfilter - Initialize the Rx filter
  *	@net_dev: the net device to initialize for
  *
  *	Set receive filter address to our MAC address
@@ -990,7 +990,7 @@
 }
 
 /**
- *	sis900_init_tx_ring: - Initialize the Tx descriptor ring
+ *	sis900_init_tx_ring - Initialize the Tx descriptor ring
  *	@net_dev: the net device to initialize for
  *
  *	Initialize the Tx descriptor ring, 
@@ -1023,7 +1023,7 @@
 }
 
 /**
- *	sis900_init_rx_ring: - Initialize the Rx descriptor ring
+ *	sis900_init_rx_ring - Initialize the Rx descriptor ring
  *	@net_dev: the net device to initialize for
  *
  *	Initialize the Rx descriptor ring, 
@@ -1077,7 +1077,7 @@
 }
 
 /**
- *	sis630_set_eq: - set phy equalizer value for 630 LAN
+ *	sis630_set_eq - set phy equalizer value for 630 LAN
  *	@net_dev: the net device to set equalizer value
  *	@revision: 630 LAN revision number
  *
@@ -1165,7 +1165,7 @@
 }
 
 /**
- *	sis900_timer: - sis900 timer routine
+ *	sis900_timer - sis900 timer routine
  *	@data: pointer to sis900 net device
  *
  *	On each timer ticks we check two things, 
@@ -1235,7 +1235,7 @@
 }
 
 /**
- *	sis900_check_mode: - check the media mode for sis900
+ *	sis900_check_mode - check the media mode for sis900
  *	@net_dev: the net device to be checked
  *	@mii_phy: the mii phy
  *
@@ -1266,7 +1266,7 @@
 }
 
 /**
- *	sis900_set_mode: - Set the media mode of mac register.
+ *	sis900_set_mode - Set the media mode of mac register.
  *	@ioaddr: the address of the device
  *	@speed : the transmit speed to be determined
  *	@duplex: the duplex mode to be determined
@@ -1310,7 +1310,7 @@
 }
 
 /**
- *	sis900_auto_negotiate:  Set the Auto-Negotiation Enable/Reset bit.
+ *	sis900_auto_negotiate - Set the Auto-Negotiation Enable/Reset bit.
  *	@net_dev: the net device to read mode for
  *	@phy_addr: mii phy address
  *
@@ -1344,7 +1344,7 @@
 
 
 /**
- *	sis900_read_mode: - read media mode for sis900 internal phy
+ *	sis900_read_mode - read media mode for sis900 internal phy
  *	@net_dev: the net device to read mode for
  *	@speed  : the transmit speed to be determined
  *	@duplex : the duplex mode to be determined
@@ -1401,7 +1401,7 @@
 }
 
 /**
- *	sis900_tx_timeout: - sis900 transmit timeout routine
+ *	sis900_tx_timeout - sis900 transmit timeout routine
  *	@net_dev: the net device to transmit
  *
  *	print transmit timeout status
@@ -1456,7 +1456,7 @@
 }
 
 /**
- *	sis900_start_xmit: - sis900 start transmit routine
+ *	sis900_start_xmit - sis900 start transmit routine
  *	@skb: socket buffer pointer to put the data being transmitted
  *	@net_dev: the net device to transmit with
  *
@@ -1526,7 +1526,7 @@
 }
 
 /**
- *	sis900_interrupt: - sis900 interrupt handler
+ *	sis900_interrupt - sis900 interrupt handler
  *	@irq: the irq number
  *	@dev_instance: the client data object
  *	@regs: snapshot of processor context
@@ -1587,7 +1587,7 @@
 }
 
 /**
- *	sis900_rx: - sis900 receive routine
+ *	sis900_rx - sis900 receive routine
  *	@net_dev: the net device which receives data
  *
  *	Process receive interrupt events, 
@@ -1726,7 +1726,7 @@
 }
 
 /**
- *	sis900_finish_xmit: - finish up transmission of packets
+ *	sis900_finish_xmit - finish up transmission of packets
  *	@net_dev: the net device to be transmitted on
  *
  *	Check for error condition and free socket buffer etc 
@@ -1796,7 +1796,7 @@
 }
 
 /**
- *	sis900_close: - close sis900 device 
+ *	sis900_close - close sis900 device 
  *	@net_dev: the net device to be closed
  *
  *	Disable interrupts, stop the Tx and Rx Status Machine 
@@ -1852,7 +1852,7 @@
 }
 
 /**
- *	netdev_ethtool_ioctl: - For the basic support of ethtool
+ *	netdev_ethtool_ioctl - For the basic support of ethtool
  *	@net_dev: the net device to command for
  *	@useraddr: start address of interface request
  *
@@ -1886,7 +1886,7 @@
 }
 
 /**
- *	mii_ioctl: - process MII i/o control command 
+ *	mii_ioctl - process MII i/o control command 
  *	@net_dev: the net device to command for
  *	@rq: parameter for command
  *	@cmd: the i/o command
@@ -1922,7 +1922,7 @@
 }
 
 /**
- *	sis900_get_stats: - Get sis900 read/write statistics 
+ *	sis900_get_stats - Get sis900 read/write statistics 
  *	@net_dev: the net device to get statistics for
  *
  *	get tx/rx statistics for sis900
@@ -1937,7 +1937,7 @@
 }
 
 /**
- *	sis900_set_config: - Set media type by net_device.set_config 
+ *	sis900_set_config - Set media type by net_device.set_config 
  *	@dev: the net device for media type change
  *	@map: ifmap passed by ifconfig
  *
@@ -2034,7 +2034,7 @@
 }
 
 /**
- *	sis900_mcast_bitnr: - compute hashtable index 
+ *	sis900_mcast_bitnr - compute hashtable index 
  *	@addr: multicast address
  *	@revision: revision id of chip
  *
@@ -2057,7 +2057,7 @@
 }
 
 /**
- *	set_rx_mode: - Set SiS900 receive mode 
+ *	set_rx_mode - Set SiS900 receive mode 
  *	@net_dev: the net device to be set
  *
  *	Set SiS900 receive mode for promiscuous, multicast, or broadcast mode.
@@ -2131,7 +2131,7 @@
 }
 
 /**
- *	sis900_reset: - Reset sis900 MAC 
+ *	sis900_reset - Reset sis900 MAC 
  *	@net_dev: the net device to reset
  *
  *	reset sis900 MAC and wait until finished
@@ -2166,7 +2166,7 @@
 }
 
 /**
- *	sis900_remove: - Remove sis900 device 
+ *	sis900_remove - Remove sis900 device 
  *	@pci_dev: the pci device to be removed
  *
  *	remove and release SiS900 net device

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbVLAKFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbVLAKFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbVLAKFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:05:52 -0500
Received: from havoc.gtf.org ([69.61.125.42]:19437 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751668AbVLAKFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:05:51 -0500
Date: Thu, 1 Dec 2005 05:05:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: netdev queue updated
Message-ID: <20051201100546.GA24087@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the current contents of netdev-2.6.git#ALL, which is
auto-propagated to Andrew Morton's -mm tree.

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.15-rc4-netdev1.patch.bz2

Adrian Bunk:
      drivers/net/sk98lin/skge.c: make SkPciWriteCfgDWord() a static inline
      hostap: rename hostap.c to hostap_main.c

Ananda Raju:
      s2io: UFO support

Andrew Morton:
      sky2 needs dma_mapping.h

Andy Fleming:
      Gianfar update and sysfs support

Brice Goglin:
      Duplicate IPW_DEBUG option for ipw2100 and 2200

Carlo Perassi:
      atmel: CodingStyle cleanup

Christophe Lucas:
      atmel: audit return code of create_proc_read_entry

Dan Streetman:
      airo.c: add support for IW_ENCODE_TEMP (i.e. xsupplicant)

Daniele Venzano:
      Add Wake on LAN support to sis900 (2)

Eugene Surovegin:
      ibm_emac: fix graceful stop timeout handling

Francois Romieu:
      b44: early return in dev->do_ioctl when the device is not up
      b44: increase version number

Jeff Garzik:
      [netdrvr 8139too] replace hand-crafted kernel thread with workqueue
      [netdrvr 8139too] use cancel_rearming_delayed_work() to cancel thread
      [netdrvr 8139too] use rtnl_shlock_nowait() rather than rtnl_lock_interruptible()
      [netdrvr 8139too] fast poll for thread, if an unlikely race occurs
      [bonding] Remove superfluous changelog.
      [netdrvr skge] fix typo, fix build

Jesse Brandeburg:
      e1000: fix for dhcp issue

John W. Linville:
      skge: fix warning from inlining SkPciWriteCfgDWord()
      e1000: avoid leak when e1000_setup_loopback_test fails
      e1000: zero-out pointers in e1000_free_desc_rings

Komuro:
      [netdrvr fmvj18x_cs] fix multicast bug

Lennert Buytenhek:
      intel ixp2000 network driver
      ixp2000: register netdevices last
      pm3386: zero stats properly
      pm3386: remove unnecessary udelays
      caleb/pm3386: include proper header files
      ixp2000: use netif_rx_schedule_test
      enp2611: don't check netif_running() in link status timer
      enp2611: use 'dev' in link status timer
      enp2611: report link up/down events
      ixp2000: report MAC addresses for each port on init
      pm3386: add hook for setting MAC address
      pm3386: add hook for setting carrier
      pm3386: implement reset
      enp2611: disable/enable SERDES carrier on interface down/up
      ixp2000: add netpoll support
      ixp2000: add driver version, bump version to 0.2

Mark Lord:
      b44: missing netif_wake_queue() in b44_open()

Matthieu CASTET:
      [wireless airo] reset card in init

Mitch Williams:
      net: allow newline terminated IP addresses in in_aton
      net: make dev_valid_name public
      bonding: add bond name to all error messages
      bonding: expand module param descriptions
      bonding: Add transmit policy to /proc
      bonding: get slave name from actual slave instead of param list
      bonding: move kmalloc out of spinlock in ALB init
      bonding: explicitly clear RLB flag during ALB init
      bonding: expose some structs
      bonding: make functions not static
      bonding: move bond creation into separate function
      bonding: make bond_init not __init
      bonding: Allow ARP target table to have empty entries
      bonding: add ARP entries to /proc
      bonding: add sysfs functionality to bonding (large)
      bonding: version update
      bonding: spelling and whitespace corrections
      bonding: comments and changelog

Pavel Roskin:
      orinoco: fix setting power management parameters

Ralf Baechle:
      mipsnet: Fix Copyright notice.
      jazzsonic: Fix build error.
      jazzsonic: Fix platform device code

Scott Feldman:
      [netdrvr e100] experiment with doing RX in a similar manner to eepro100

shemminger@osdl.org:
      sky2: changing mtu doesn't have to reset link
      sky2: cleanup interrupt processing
      sky2: add hardware VLAN acceleration support
      sky2: explicit set power state
      sky2: version 0.6
      sky2: remove unused definitions
      sky2: use kzalloc
      sky2: spelling fixes
      sky2: fix NAPI and receive handling
      sky2: version 0.7
      sky2: eliminate special case for EC-A1
      sky2: add MII support
      sky2: fix receive flush/pause issues
      sky2: improve receive performance
      sky2: add Yukon-EC ultra support
      sky2: handle DMA boundary crossing
      sky2: change netif_rx_schedule_test to __netif_schedule_prep
      sky2: race with MTU change
      sky2: dual port tx completion
      sky2: byteorder annotation
      sky2: remove pci-express hacks
      sky2: use pci_register_driver
      sky2: update version number
      sk98lin: fix checksumming code
      sk98lin: add permanent address support
      sk98lin: avoid message confusion with skge
      sk98lin: allow ethtool checksum on/off per port
      sk98lin: remove redundant fields in device info
      sk98lin: remove /proc interface

Stephen Hemminger:
      sky2: new experimental Marvell Yukon2 driver
      sky2: driver update.
      sky2: fix FIFO DMA alignment problems
      sky2: allow ethtool debug access to all of PCI space
      sky2: version 0.5
      sky2: nway reset (BONUS FEATURE)
      sky2: add permanent address support.
      skge: handle VLAN checksum correctly on yukon rev 0

Takis:
      ipw2200: kzalloc conversion and Kconfig dependency fix

Tobias Klauser:
      Remove drivers/net/wan/lmc/lmc_prot.h

 drivers/net/sk98lin/skcsum.c              |  871 --------
 drivers/net/sk98lin/skproc.c              |  265 --
 drivers/net/wan/lmc/lmc_prot.h            |   15 
 Documentation/networking/gianfar.txt      |   72 
 drivers/net/8139too.c                     |   86 
 drivers/net/Kconfig                       |   15 
 drivers/net/Makefile                      |    7 
 drivers/net/b44.c                         |   13 
 drivers/net/bonding/Makefile              |    2 
 drivers/net/bonding/bond_3ad.c            |  106 -
 drivers/net/bonding/bond_3ad.h            |   13 
 drivers/net/bonding/bond_alb.c            |   75 
 drivers/net/bonding/bond_alb.h            |    9 
 drivers/net/bonding/bond_main.c           |  781 +------
 drivers/net/bonding/bond_sysfs.c          | 1358 +++++++++++++
 drivers/net/bonding/bonding.h             |   52 
 drivers/net/e100.c                        |   72 
 drivers/net/e1000/e1000_ethtool.c         |   16 
 drivers/net/e1000/e1000_main.c            |   14 
 drivers/net/gianfar.c                     |  233 +-
 drivers/net/gianfar.h                     |   69 
 drivers/net/gianfar_ethtool.c             |    2 
 drivers/net/gianfar_mii.h                 |    1 
 drivers/net/gianfar_sysfs.c               |  311 ++
 drivers/net/ibm_emac/ibm_emac_core.c      |   38 
 drivers/net/ibm_emac/ibm_emac_core.h      |    2 
 drivers/net/ixp2000/Kconfig               |    6 
 drivers/net/ixp2000/Makefile              |    3 
 drivers/net/ixp2000/caleb.c               |  137 +
 drivers/net/ixp2000/caleb.h               |   22 
 drivers/net/ixp2000/enp2611.c             |  245 ++
 drivers/net/ixp2000/ixp2400-msf.c         |  213 ++
 drivers/net/ixp2000/ixp2400-msf.h         |  115 +
 drivers/net/ixp2000/ixp2400_rx.uc         |  408 +++
 drivers/net/ixp2000/ixp2400_rx.ucode      |  130 +
 drivers/net/ixp2000/ixp2400_tx.uc         |  272 ++
 drivers/net/ixp2000/ixp2400_tx.ucode      |   98 
 drivers/net/ixp2000/ixpdev.c              |  421 ++++
 drivers/net/ixp2000/ixpdev.h              |   27 
 drivers/net/ixp2000/ixpdev_priv.h         |   57 
 drivers/net/ixp2000/pm3386.c              |  334 +++
 drivers/net/ixp2000/pm3386.h              |   28 
 drivers/net/jazzsonic.c                   |    4 
 drivers/net/mipsnet.h                     |   30 
 drivers/net/pcmcia/fmvj18x_cs.c           |   32 
 drivers/net/s2io.c                        |  186 +
 drivers/net/s2io.h                        |    3 
 drivers/net/sis900.c                      |   73 
 drivers/net/sis900.h                      |   45 
 drivers/net/sk98lin/Makefile              |    6 
 drivers/net/sk98lin/h/skdrv2nd.h          |   13 
 drivers/net/sk98lin/h/skvpd.h             |    8 
 drivers/net/sk98lin/skethtool.c           |   50 
 drivers/net/sk98lin/skge.c                |  388 +--
 drivers/net/skge.c                        |    4 
 drivers/net/sky2.c                        | 3123 ++++++++++++++++++++++++++++++
 drivers/net/sky2.h                        | 1917 ++++++++++++++++++
 drivers/net/wireless/Kconfig              |    6 
 drivers/net/wireless/airo.c               |   19 
 drivers/net/wireless/atmel.c              | 1490 +++++++-------
 drivers/net/wireless/hostap/Makefile      |    1 
 drivers/net/wireless/hostap/hostap_main.c |    0 
 drivers/net/wireless/ipw2100.c            |   40 
 drivers/net/wireless/ipw2100.h            |    2 
 drivers/net/wireless/ipw2200.c            |   21 
 drivers/net/wireless/ipw2200.h            |    6 
 drivers/net/wireless/orinoco.c            |    3 
 include/linux/netdevice.h                 |   11 
 net/core/dev.c                            |    3 
 net/core/utils.c                          |    2 
 70 files changed, 11156 insertions(+), 3344 deletions(-)

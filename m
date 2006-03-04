Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWCDR2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWCDR2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWCDR2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:28:42 -0500
Received: from havoc.gtf.org ([69.61.125.42]:48012 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751890AbWCDR2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:28:41 -0500
Date: Sat, 4 Mar 2006 12:28:37 -0500
From: Jeff Garzik <jeff@garzik.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT] netdev queue contents
Message-ID: <20060304172837.GA28239@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following stuff is queued for 2.6.17 [really 2.6.16-git1] at
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
branch 'upstream':

 Documentation/DocBook/sis900.tmpl          |  585 ----------
 Documentation/networking/sis900.txt        |  257 ----
 Documentation/DocBook/Makefile             |    2 
 Documentation/feature-removal-schedule.txt |    7 
 Documentation/networking/00-INDEX          |    2 
 arch/ppc/platforms/hdpu.c                  |    5 
 drivers/net/3c523.c                        |    9 
 drivers/net/3c59x.c                        |    7 
 drivers/net/7990.c                         |    2 
 drivers/net/8139cp.c                       |    2 
 drivers/net/8139too.c                      |    4 
 drivers/net/82596.c                        |    2 
 drivers/net/Kconfig                        |   25 
 drivers/net/apne.c                         |    7 
 drivers/net/arcnet/Kconfig                 |    4 
 drivers/net/arcnet/arc-rawmode.c           |    2 
 drivers/net/arcnet/arc-rimi.c              |   68 -
 drivers/net/arcnet/arcnet.c                |   20 
 drivers/net/arcnet/com90xx.c               |  132 +-
 drivers/net/arcnet/rfc1051.c               |    2 
 drivers/net/arcnet/rfc1201.c               |    2 
 drivers/net/arm/etherh.c                   |    3 
 drivers/net/bnx2.c                         |   10 
 drivers/net/bnx2_fw.h                      |   84 -
 drivers/net/bonding/bond_alb.c             |    2 
 drivers/net/bonding/bond_main.c            |   45 
 drivers/net/bonding/bond_sysfs.c           |    6 
 drivers/net/bonding/bonding.h              |   33 
 drivers/net/chelsio/subr.c                 |    2 
 drivers/net/dgrs.c                         |    2 
 drivers/net/dgrs_firmware.c                |    4 
 drivers/net/dl2k.c                         |    4 
 drivers/net/e100.c                         |    6 
 drivers/net/e1000/e1000.h                  |   46 
 drivers/net/e1000/e1000_ethtool.c          |   97 -
 drivers/net/e1000/e1000_hw.c               |  734 +++++++++++++
 drivers/net/e1000/e1000_hw.h               |  319 +++++
 drivers/net/e1000/e1000_main.c             |  589 ++++------
 drivers/net/e1000/e1000_param.c            |    2 
 drivers/net/eepro100.c                     |    4 
 drivers/net/epic100.c                      |    4 
 drivers/net/eth16i.c                       |   11 
 drivers/net/fealnx.c                       |    2 
 drivers/net/forcedeth.c                    |  593 ++++++++++-
 drivers/net/hamachi.c                      |    2 
 drivers/net/hamradio/baycom_epp.c          |    2 
 drivers/net/hp100.c                        |   35 
 drivers/net/ibm_emac/ibm_emac_core.c       |   40 
 drivers/net/ibm_emac/ibm_emac_core.h       |    2 
 drivers/net/ibm_emac/ibm_emac_debug.c      |    2 
 drivers/net/ibm_emac/ibm_emac_rgmii.h      |    2 
 drivers/net/ibm_emac/ibm_emac_zmii.c       |    7 
 drivers/net/ibm_emac/ibm_emac_zmii.h       |    2 
 drivers/net/irda/Kconfig                   |    4 
 drivers/net/macsonic.c                     |    2 
 drivers/net/mv643xx_eth.c                  | 1560 ++++++++++-------------------
 drivers/net/mv643xx_eth.h                  |  250 +---
 drivers/net/natsemi.c                      |  192 ++-
 drivers/net/ne-h8300.c                     |    5 
 drivers/net/ne.c                           |    7 
 drivers/net/ne2.c                          |    7 
 drivers/net/ne2k-pci.c                     |    2 
 drivers/net/ns83820.c                      |    7 
 drivers/net/oaknet.c                       |    3 
 drivers/net/pcmcia/3c574_cs.c              |    2 
 drivers/net/pcmcia/3c589_cs.c              |    5 
 drivers/net/pcmcia/fmvj18x_cs.c            |    2 
 drivers/net/pcmcia/nmclan_cs.c             |    2 
 drivers/net/pcmcia/pcnet_cs.c              |    3 
 drivers/net/pcmcia/smc91c92_cs.c           |    4 
 drivers/net/pcmcia/xirc2ps_cs.c            |    2 
 drivers/net/pcnet32.c                      |    6 
 drivers/net/phy/phy.c                      |    2 
 drivers/net/plip.c                         |    4 
 drivers/net/ppp_async.c                    |    3 
 drivers/net/ppp_synctty.c                  |    2 
 drivers/net/r8169.c                        |    4 
 drivers/net/s2io.c                         |  618 ++++++++++-
 drivers/net/s2io.h                         |   55 -
 drivers/net/sb1000.c                       |    2 
 drivers/net/sb1250-mac.c                   |  109 +-
 drivers/net/seeq8005.c                     |    5 
 drivers/net/shaper.c                       |    3 
 drivers/net/sis190.c                       |    2 
 drivers/net/sis900.c                       |    8 
 drivers/net/sk98lin/h/skaddr.h             |   48 
 drivers/net/sk98lin/h/skcsum.h             |    6 
 drivers/net/sk98lin/h/skgeinit.h           |   56 -
 drivers/net/sk98lin/h/skgepnmi.h           |    4 
 drivers/net/sk98lin/h/skgesirq.h           |    1 
 drivers/net/sk98lin/h/ski2c.h              |    3 
 drivers/net/sk98lin/h/skvpd.h              |   15 
 drivers/net/sk98lin/skaddr.c               |   35 
 drivers/net/sk98lin/skgeinit.c             |  148 --
 drivers/net/sk98lin/skgemib.c              |    7 
 drivers/net/sk98lin/skgepnmi.c             |  153 --
 drivers/net/sk98lin/skgesirq.c             |   24 
 drivers/net/sk98lin/ski2c.c                |    6 
 drivers/net/sk98lin/sklm80.c               |   72 -
 drivers/net/sk98lin/skrlmt.c               |    1 
 drivers/net/sk98lin/skvpd.c                |  108 --
 drivers/net/sk98lin/skxmac2.c              |  461 --------
 drivers/net/skfp/fplustm.c                 |   14 
 drivers/net/skfp/pcmplc.c                  |    4 
 drivers/net/skfp/skfddi.c                  |    2 
 drivers/net/starfire.c                     |   40 
 drivers/net/sundance.c                     |   10 
 drivers/net/sungem_phy.c                   |    2 
 drivers/net/tg3.c                          |    4 
 drivers/net/tokenring/lanstreamer.c        |    3 
 drivers/net/tokenring/olympic.c            |    9 
 drivers/net/tulip/de2104x.c                |   18 
 drivers/net/tulip/pnic.c                   |    3 
 drivers/net/tulip/winbond-840.c            |    2 
 drivers/net/tulip/xircom_cb.c              |    9 
 drivers/net/typhoon.c                      |    2 
 drivers/net/wan/Kconfig                    |    2 
 drivers/net/wan/hostess_sv11.c             |    1 
 drivers/net/wan/sealevel.c                 |    1 
 drivers/net/wireless/Kconfig               |   32 
 drivers/net/wireless/airo.c                |  338 +++++-
 drivers/net/wireless/atmel.c               |  110 --
 drivers/net/wireless/ipw2100.c             |   48 
 drivers/net/wireless/ipw2100.h             |    6 
 drivers/net/wireless/ipw2200.c             |  881 ++++++++--------
 drivers/net/wireless/ipw2200.h             |   64 -
 drivers/net/wireless/netwave_cs.c          |    2 
 drivers/net/wireless/strip.c               |    4 
 drivers/net/wireless/wavelan.p.h           |    6 
 drivers/net/wireless/wavelan_cs.p.h        |    9 
 drivers/net/yellowfin.c                    |    6 
 drivers/net/zorro8390.c                    |    7 
 include/linux/arcdevice.h                  |    9 
 include/linux/if.h                         |    3 
 include/linux/if_ether.h                   |    1 
 include/linux/mv643xx.h                    |   27 
 include/net/ieee80211.h                    |  177 +++
 include/net/ieee80211_crypt.h              |    3 
 net/Kconfig                                |    3 
 net/core/Makefile                          |    2 
 net/core/dev.c                             |   36 
 net/ieee80211/ieee80211_crypt.c            |   11 
 net/ieee80211/ieee80211_crypt_ccmp.c       |    8 
 net/ieee80211/ieee80211_crypt_tkip.c       |   56 -
 net/ieee80211/ieee80211_crypt_wep.c        |    5 
 net/ieee80211/ieee80211_geo.c              |   48 
 net/ieee80211/ieee80211_module.c           |   20 
 net/ieee80211/ieee80211_rx.c               |  153 ++
 net/ieee80211/ieee80211_tx.c               |   30 
 net/ieee80211/ieee80211_wx.c               |  152 ++
 net/socket.c                               |    9 
 151 files changed, 5390 insertions(+), 4874 deletions(-)

Adrian Bunk:
      drivers/net/sk98lin/: possible cleanups
      drivers/net/arcnet/: possible cleanups
      drivers/net/s2io.c: make code static
      net/: fix the WIRELESS_EXT abuse
      AIRO{,_CS} <-> CRYPTO fixes
      drivers/net/wireless/ipw2100.c: make ipw2100_wpa_assoc_frame() static
      drivers/net/wireless/ipw2200: possible cleanups
      [netdrvr] schedule eepro100 for removal
      remove obsolete sis900 documentation

Al Viro:
      arcnet probing cleanups and fixes
      ibm_emac sparse annotations
      appletalk/cops.h: missing const in struct ltfirmware
      macsonic.c: missed s/driver_unregister/platform_driver_unregister/
      missing include of asm/irq.h in drivers/net
      bogus include of linux/irq.h in 7990.c
      wrong ifdefs in 82596.c
      dead code removed in hp100

Andreas Happe:
      ipw2200: add monitor and qos entries to Kconfig

Andrew Morton:
      git-netdev-all: s2io fixes
      s2io c99 warning fix

Arjan van de Ven:
      Massive net driver const-ification.

Arnaldo Carvalho de Melo:
      sundance: Really read addr 0

Ayaz Abdulla:
      forcedeth: Add vlan support
      forcedeth: Add support for 64bit rings
      forcedeth: Add support for MSI/MSIX

Catalin(ux aka Dino) BOIE:
      Fix io ordering problems in e100

Dale Farnsworth:
      mv643xx_eth: Remove needless mp->port_mac_addr
      mv643xx_eth: Merge unicast and multicast address filtering code
      mv643xx_eth: Rename mp->tx_ring_skbs to mp->tx_desc_count
      mv643xx_eth: Make port queue enable/disable code consistent
      mv643xx_eth: Clean up platform_data configuration
      mv643xx_eth: Remove duplicate includes of linux/in.h and linux/ip.h
      mv643xx_eth: Fix misplaced parenthesis in mv643xx_eth_port_disable_rx
      mv643xx_eth: Rename "channels" to "queues"
      mv643xx_eth: Select CONFIG_MII on CONFIG_MV643XX_ETH
      mv643xx_eth: Refactor tx command queuing code
      mv643xx_eth: Refactor/clean up tx queue handling
      mv643xx_eth: Move #defines of constants to mv643xx_eth.h
      mv643xx_eth: Clean up interrupt handling
      mv643xx_eth: Remove non-working feature: task level rx queue refill
      mv643xx_eth: Remove BIT0-BIT31 #defines

Dan Williams:
      wireless/airo: add IWENCODEEXT and IWAUTH support
      wireless/ipw2200: support WE-18 WPA enc_capa
      wireless/atmel: convert constants to ieee80211 layer equivalents
      wireless/airo: fix setting TX key index plus key in ENCODEEXT
      wireless/airo: Remove 'Setting transmit key' info messages

Denis Vlasenko:
      WEP fields are incorrectly shown to be INSIDE snap in the doc
      ieee80211: trivial fix for misplaced ()'s

Eric Sesterhenn / snakebyte:
      BUG_ON() Conversion in net/tulip/xircom_cb.c
      BUG_ON() Conversion in net/tulip/de2104x.c
      BUG_ON() Conversion in net/tulip/winbond-840.c

James Chapman:
      mv643xx_eth: use MII library for PHY management
      mv643xx_eth: use MII library for ethtool functions

Jan Niehusmann:
      let IPW2{1,2}00 select IEEE80211

Jay Vosburgh:
      bonding: suppress duplicate packets

Jeff Garzik:
      s2io: set_multicast_list bug

Jeff Kirsher:
      e1000: Remove Multiqueue code until we have support for MSI-X in our hardware
      e1000: Fix dead counters
      e1000: Fix lock up while setting ring parameters
      e1000: Fix unecessary delay for 82573 controllers
      e1000: Fix AMT losing connectivity when switching VLAN in passive mode
      e1000: Fix dhcp issue when the skb structure fields are not filled properly
      e1000: Fix 82543 issue when reading eeprom
      e1000: Fix RSS if enabled in mid-connection
      e1000: Fix Quadport Wake on LAN
      e1000: Fix network problems when forced at 100Mb/s and to fix TSO when forced at 100Mb/s
      e1000: Fix filling skb descriptors while using packet split
      e1000: Add 82573 controller support to TSO fix
      e1000: Add enabled Jumbo frame support for 82573L
      e1000: Add performance enahancement by balancing TX and RX
      e1000: Add support for new hardware (ESB2)
      e1000: Fixed the following issues with ESB2 (requires ESB2 support):
      e1000: Add copybreak when using packet split
      e1000: Added a performance enhancement - prefetch
      e1000: Added driver comments and whitespace changes.  Modified long lines of code to ensure they would not wrap beyond 80 characters.

Johannes Berg:
      ieee80211: fix sparse warning about missing "static"

Jon Mason:
      trivial: fix spelling errors in Kconfigs

Komuro:
      pcnet_cs: add new id (Logitec LPM-LN100TE)

Larry Finger:
      ieee80211: common wx auth code
      Add two management functions to ieee80211_rx.c

Marcelo Feitoza Parisi:
      drivers/net/*: use time_after() and friends

Mark Brown:
      natsemi: NAPI and a bugfix
      natsemi: NAPI and a bugfix

Pete Zaitcev:
      ieee80211_geo.c: remove frivolous BUG_ON's

Ralf Baechle:
      sb1250-mac: Add support for the BCM1480

Ravinandan Arakali:
      S2io: Large Receive Offload (LRO) feature(v2) for Neterion (s2io) 10GbE Xframe PCI-X and PCI-E NICs

Stefan Rompf:
      starfire: Implement suspend/resume
      ipw2200: Fix WPA network selection problem

Zhu Yi:
      ieee80211: Log if netif_rx() drops the packet
      ieee80211: Add LEAP authentication type
      ieee80211: add flags for all geo channels
      ieee80211: Add spectrum management information
      ieee80211: kmalloc+memset -> kzalloc cleanups
      ieee80211: TIM information element parsing
      ieee80211: Add TKIP crypt->build_iv
      ieee80211: Add 802.11h data type and structures
      ieee80211: Add helpers for IBSS DFS handling
      ieee80211: Add 802.11h information element parsing
      ipw2100: Add LEAP authentication algorithm support
      ipw2100: Make iwconfig txpower setting consistent with user input
      ipw2100: Add generic geo information
      ipw2100: remove white space and better format the code
      increase ipw2100 driver version to git-1.1.4
      ipw2200: Fix indirect SRAM/register 8/16-bit write routines
      ipw2200: Mask out the WEP_KEY command dump from debug log for security reason
      ipw2200: Add LEAP authentication algorithm support
      ipw2200: Bluetooth coexistence support
      ipw2200: use jiffies_to_msec() wherever possible
      ipw2200: Make LED blinking frequency independent of HZ
      ipw2200: add module parameter to enable/disable roaming
      ipw2200: Scale firmware loading watchdog with the firmware size
      ipw2200: stack reduction
      ipw2200: Fix qos_cmd param switch bug
      ipw2200: increase ipw2200 driver version
      ipw2200: remove white space and better format the code
      ipw2200: Semaphore to mutexes conversion
      ipw2200: Disable hwcrypto by default
      ieee80211: Use IWEVGENIE to set WPA IE
      ipw2200: Fix software crypto shared WEP authentication problem


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbTLPGlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTLPGlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 01:41:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265118AbTLPGlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 01:41:07 -0500
Message-ID: <3FDEA8F5.1020201@pobox.com>
Date: Tue, 16 Dec 2003 01:40:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       davem@redhat.com
Subject: [FYI] 2.6.x exp net drivers changelog
Content-Type: multipart/mixed;
 boundary="------------080204080305050801080809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080204080305050801080809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


By request, here is the "shortlog" summary of the entire 
net-drivers-2.5-exp patchkit (attached).


Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp1.patch.bz2

Full changelog:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-bk11-netdrvr-exp1.log

BK repo:
bk://gkernel.bkbits.net/net-drivers-2.5-exp



--------------080204080305050801080809
Content-Type: text/plain;
 name="2.6.0-test11-bk11-netdrvr-exp1.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="2.6.0-test11-bk11-netdrvr-exp1.txt"


<prasanna:in.ibm.com>:
  o [netdrvr tlan] netpoll support
  o [netdrvr smc-ultra] netpoll support

<rnp:paradise.net.nz>:
  o [netdrvr 3c527] fix race
  o [netdrvr 3c527] whitespace changes (sync up with maintainer)

Alexander Viro:
  o [netdrvr axnet_cs] use embedded private struct
  o [NET] s/kfree/free_netdev/ in bridge driver
  o [netdrvr bonding] use destructor to properly free net device
  o [netdrvr 8390] convert 8390 lib to use const-offset priv struct
  o [netdrvr pcnet_cs] alloc_ei_netdev-associated cleanups
  o [netdrvr smc-mca] alloc_ei_netdev(), other fixes
  o [netdrvr] convert most 8390 drivers to using alloc_ei_netdev()
  o [wireless wl3501_cs] remove unused constructor
  o [netdrvr] s/kfree/free_netdev/ where appropriate
  o [atm clip] convert to using alloc_netdev(), const-offset priv
  o [pcmcia] synclink_cs] convert net_device to dynamic allocation
  o [char synclinkmp] convert net_device to dynamic allocation
  o [hamradio dmascc] convert embedded net_device to dynamic allocation
  o net_device and netdev private struct allocation improvements
  o [netdrvr] remove manual driver poisoning of net_device
  o [wan cosa] netdev dyamic alloc
  o [wan synclink] netdev dynamic alloc
  o [netdrvr ppp] netdev dynamic alloc; convert ppp_net_init to alloc_netdev setup function
  o [arcnet] create and use alloc_arcdev helper
  o [arcnet com90xx] netdev dynamic alloc; module params; fix bugs
  o [arcnet com20020] netdev dynamic alloc; module params; fix bugs
  o [arcnet arc-rimi] use alloc_netdev; module params; fix bugs on error/cleanup
  o [arcnet com90io] use alloc_netdev
  o [appletalk ipddp] dynamically allocate struct net_device
  o [netdrvr ne3210] remove #if 0'd code
  o [wireless ray_cs] use alloc_etherdev
  o [netdrvr meth] use alloc_etherdev; fix leaks on error/cleanup
  o [netdrvr qeth] use alloc_etherdev instead of hand-allocating struct net_device
  o [netdrvr lasi_82596] remove ether_setup() call, fix leak in probe
  o [netdrvr] alloc_etherdev-related cleanups
  o [netdrvr xircom_tulip_cb] remove bogus unregister_netdev call; use free_netdev
  o [netdrvr stnic] fix typo from last stnic cset
  o [netdrvr iph5526] use SET_MODULE_OWNER; small typedef cleanup
  o [netdrvr pcmcia] s/kfree/free_netdev/
  o [netdrvr ether00] s/kfree/free_netdev/ ; remove redundant memset() calls
  o [netdrvr] s/kfree/free_netdev/ where appropriate
  o [wireless wavelan{_cs}] use alloc_etherdev; remove useless net_device* typedef
  o [netdrvr de600] use alloc_etherdev; request_region fixes
  o [netdrvr atp] use alloc_etherdev, clean up probing
  o [netdrvr depca] fix leaks on error
  o [netdrvr saa9730] use alloc_etherdev, annotate bugs found but not fixed
  o [netdrvr stnic] use alloc_etherdev
  o [netdrvr sgiseeq] alloc_etherdev, SET_MODULE_OWNER, fix leaks on error
  o [netdrvr sb1250-mac] alloc_etherdev, fix leaks on error
  o [netdrvr au1000_eth] alloc_etherdev, SET_MODULE_OWNER, fix leaks/small bugs
  o [netdrvr zorro8390] alloc_etherdev, SET_MODULE_OWNER
  o [netdrvr mace] alloc_etherdev, fix leaks on error
  o [netdrvr znet] alloc_etherdev, SET_MODULE_OWNER, remove #ifdef MODULE
  o [netdrvr oaknet] use alloc_etherdev, fix leaks
  o [netdrvr hydra] use alloc_etherdev
  o [netdrvr gt96100eth] use alloc_etherdev, fix leaks
  o [netdrvr declance] use alloc_etherdev
  o [netdrvr ariadne] use alloc_etherdev
  o [netdrvr a2065] convert to alloc_etherdev

Andi Kleen:
  o netpoll for eepro100
  o fix tg3 netpoll
  o Netpoll for pcnet32
  o netpoll for amd8111e
  o netpoll for tulip
  o netpoll for 3c59x

Andrew Morton:
  o Re: Deadlock in 3c574_cs.c (fwd)

David Dillow:
  o Bug fixes

David S. Miller:
  o [TG3]: Update to latest non-5705 TSO firmware
  o [TG3]: Update version and release date
  o [TG3]: Clear on-chip stats/status block after resetting flow-through queues
  o [TG3]: Do not set RX_MODE_KEEP_VLAN_TAG when ASF is enabled
  o [TG3]: Do not drop existing GRC_MODE_HOST_STACKUP when writing to GRC_MODE

Dmitry Torokhov:
  o Fwd: Re: Atmel - possible SKB leak?

Felipe Damasio:
  o release region in skfddi driver
  o [netdrvr 3c527] remove cli/sti

Fran�ois Romieu:
  o [netdrvr r8169] Stats fix (Fernando Alencar Marótica <famarost@unimep.br>)
  o [netdrvr r8169] Endianness update (original idea from Alexandra N. Kossovsky)
  o [netdrvr r8169] fix RX
  o [netdrvr r8169] Suspend/resume code (Fernando Alencar Marótica)
  o [netdrvr r8169] Modification of the interrupt mask (RealTek)
  o [netdrvr r8169] Driver forgot to update the transmitted bytes counter
  o [netdrvr r8169] Merge of changes from Realtek
  o [netdrvr r8169] Merge of timer related changes from Realtek
  o [netdrvr r8169] Merge of changes done by Realtek to rtl8169_init_one()
  o [netdrvr r8169] Add {mac/phy}_version
  o [netdrvr r8169] Rx copybreak for small packets
  o [netdrvr r8169] Conversion of Tx data buffers to PCI DMA
  o [netdrvr r8169] rtl8169_start_xmit fixes
  o [netdrvr r8169] Conversion of Rx data buffers to PCI DMA
  o [netdrvr r8169] Conversion of Rx/Tx descriptors to consistent DMA
  o 2.6.0-test6 - more free_netdev() conversion

Geert Uytterhoeven:
  o 2.6.x experimental net driver queue fix
  o sun3-related net driver fixes
  o m68k-related net driver fixes

Hirofumi Ogawa:
  o 8139too tx queue handling fix
  o 8139too warning fix (1/2)
  o 8139too NAPI for net-drivers-2.5-exp

Javier Achirica:
  o [wireless airo] Delay MIC activation to prevent Oops
  o [wireless airo] Fix PCI registration

Jeff Garzik:
  o Cset exclude: shemminger@osdl.org|ChangeSet|20031029195339|20158
  o Merge master.kernel.org:/home/davem/BK/tg3-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/net-drivers-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/net-drivers-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Cset exclude: felipewd@terra.com.br|ChangeSet|20031014182245|09592
  o Merge redhat.com:/spare/repo/net-drivers-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/net-drivers-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/linux-2.5 into redhat.com:/spare/repo/net-drivers-2.5
  o [netdrvr pcnet32] fix oops on unload
  o [netdrvr e100] complete rewrite of e100 driver
  o Merge redhat.com:/spare/repo/linux-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/linux-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o [netdrvr] remove init_etherdev mentions in Doc/SubmittingPatches, atari_pamsnet.c
  o [netdrvr] remove Documentation/networking/8139too.txt
  o [netdrvr 3c527] applied missing pieces of Richard Proctor's 3c527 SMP update
  o [netdrvr tulip] clean up tulip NAPI poll disable
  o [netdrvr tc35815] switch to using alloc_etherdev
  o [netdrvr tc35815] many fixes, major and minor
  o [netdrvr] Remove never-referenced 68360enet.c
  o [netdrvr 3c515] fix non-modular build
  o Merge redhat.com:/spare/repo/linux-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/netpoll-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o Merge redhat.com:/spare/repo/linux-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o [netdrvr tulip] support NAPI

Krishna Kumar:
  o [netdrvr 8139too] support netif_msg_* interface

Krzysztof Halasa:
  o [wan] add new pc200syn driver

Manfred Spraul:
  o [netdrvr] add "forcedeth" driver for nVidia nForce NICs

Matt Mackall:
  o netpoll: push zap_completion_queue for lkcd
  o netpoll: fix compilation with CONFIG_NETPOLL_RX
  o [NET] use the netpoll API to transmit kernel printks over UDP
  o [NET] Add netpoll support for tg3
  o [NET] add netpoll API

Mirko Lindner:
  o sk98lin-2.6: pci.ids Update to Driver Version v6.21
  o sk98lin-2.6: Kconfig Update to Driver Version v6.21
  o sk98lin-2.6: Readme Update to Driver Version v6.21
  o sk98lin-2.6: Kernel Update to Driver Version v6.21

Randy Dunlap:
  o janitor: insert missing iounmap(), add error handling

Russell King:
  o [netdrvr pcmcia] fix hot unplugging

Scott Feldman:
  o ICH6 IDs + ia64 memcpy fix + module_param
  o [e100] missed a kfree -> free_netdev
  o [e100] add extended device-specific ethtool stats
  o [e100] remove __devinit from mis-marked funcs
  o [e1000] Internal SERDES link detect; delay after SPI
  o [e1000] exit polling loop if interface is brought down
  o [e1000] improve Tx flush method
  o [e1000] print message if user overrides default ITR
  o [e1000] 82547 interrupt assert/de-assert re-ordering
  o [e1000] use unsigned long for I/O base addr
  o [e1000] loopback diag test failing on big-endian
  o [e1000] use pdev->irq rather than netdev->irq for
  o [e1000] add ethtool ring param support

Stephen Hemminger:
  o pc300 - get rid of MOD_INC/MOD_DEC
  o get rid of MOD INC/DEC for farsync
  o (3/3) 8139too -- poll_controller
  o (2/3) 8139too -- configurable receive ring
  o (1/3) 8139too -- put back old assert
  o 8139too NAPI for net-drivers-2.5-exp
  o (42/42) atari_lance
  o (41/42) sun3_lance
  o (40/42) sun3_82586
  o (39/42) apne
  o (38/42) bionet
  o (37/42) pamsnet
  o (36/42) hplance
  o (35/42) mvme147
  o (34/42) mac_mace
  o (33/42) macsonic
  o (32/42) mac8390
  o (31/42) mac89x0
  o (30/42) jazzsonic
  o (29/42) bagetlance
  o (28/42) ultra32
  o (27/42) ac3200
  o (26/42) es3210
  o (25/42) lne390
  o (24/42) ne2
  o (23/42) 3c523
  o (22/42) 3c527
  o (21/42) sk_mca
  o (20/42) hp100-T10
  o (19/42) 3c515-T10
  o (18/42) ultra
  o (17/42) wd
  o (16/42) 3c503
  o (15/42) hp
  o (14/42) hpplus
  o (13/42) e2100
  o (12/42) ne
  o (11/42) lance
  o (10/42) smc
  o (9/42) seeq8005
  o (8/42) at1500
  o (7/42) cs89x0
  o (6/42) at1700
  o (5/42) fmv18
  o (4/42) eth16i
  o (3/42) eexpress
  o (2/42) eepro
  o (1/42) ewrk3
  o sk_g16 missing declaration
  o arlan new probe code needs to register
  o 3c59x netpoll typo
  o typo in net-drivers-2.5-exp 3c507
  o trivial -- skfp_probe should be static
  o (4/6) skisa -- probe2
  o (3/6) proteon -- probe2
  o (2/6) smctr -- probe2
  o (1/6) tokenring probing change
  o (12/12) Probe2 -- 82596
  o (11/12) Probe2 -- 3c501
  o (10/12) Probe2 -- wavelan
  o (09/12) Probe2 -- arlan
  o (08/12) Probe2 -- 3c507
  o (07/12) Probe2 -- 3c505
  o (06/12) Probe2 -- sk16
  o (05/12) Probe2 -- ni5010
  o (04/12) Probe2 -- ni52
  o (03/12) Probe2 -- ni65
  o (2/12) Probe2 -- de620
  o (1/12) Probe2 infrastructure for 2.6 experimental
  o smctr - get rid of MOD_INC/DEC
  o remove dev_get from wanrouter
  o wan/lmc -- convert to new network device model

Xose Vazquez Perez:
  o [TG3]: Add new device IDs
  o more ne2k-pci clone boards
  o more RTL-8139 clone boards


--------------080204080305050801080809--


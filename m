Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUDVNFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUDVNFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbUDVNFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:05:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34789 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264012AbUDVNFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:05:30 -0400
Date: Thu, 22 Apr 2004 10:06:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-pre1
Message-ID: <20040422130651.GB18358@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes the 2.4.27-pre1... Most importantly it contains the addition 
of SATA drivers backport from v2.6. 

Also network driver updates, USB updates, etc.

Detailed changelog follows

Summary of changes from v2.4.26 to v2.4.27-pre1
============================================

<khawar.chaudhry:amd.com>:
  o Update amd8111 net driver

<kirillx:7ka.mipt.ru>:
  o Fix potential memory leak in devpts
  o Fix potential memory access to free memory in /proc handling

<lkml:lievin.net>:
  o tipar char driver (divide by zero)

<maragato:gmx.net>:
  o Add ATI IGP 345M rev2 ID's

<mhf:linuxmail.org>:
  o Update codingstyle to 2.6 level

<sezero:superonline.com>:
  o megaraid2 compilation fix

<tmattox:engr.uky.edu>:
  o [netdrvr tulip] add MII support for Comet chips

<vda:port.imtp.ilyichevsk.odessa.ua>:
  o gcc3 does not inline some functions

Atul Mukker:
  o megaraid2 driver version 2.10.3

Chris Wright:
  o e1000: fix probable security hole

Don Fry:
  o resync pcnet32.c with 2.6.x
  o netdevice.h add netif_msg_init helper
  o pcnet32 fix hang/crash with loopback test

Ganesh Venkatesan:
  o e100: NFS/TCO related Firmware update
  o e100: change log + version update
  o e100: use new API, SET_NETDEV_DEV, rx_bytes stat to include MAC header fix
  o e1000: ethtool set/get ring param support
  o e1000: backoff Tanacross missed interrupt workaround
  o e1000: Changed E1000_COLLISION_THRESHOLD from 16 to 15
  o e1000: use E1000_PBA_BYTES_SHIFT instead of E1000_TX_FIFO_SIZE
  o e1000: remove polarity reversal workaround for forced 10H/10F links
  o e1000: fix eeprom update to include e1000_standby_eeprom
  o e1000: new bit definitions, fix comments
  o e1000: ethtool set/get eeprom fixes
  o e1000: use new API, SET_NETDEV_DEV, check register_netdev retval
  o e1000: all other white space fixes, changelog
  o e1000: Disable TSO - till TSO related Tx hangs are root caused/fixed
  o e1000: msec_delay fix
  o e1000: phy fix, and cleanup

Jeff Garzik:
  o [netdrvr 8139cp] trivial syncing with 2.6.x
  o [netdrvr 8139cp] rearrange priv struct, add cacheline-align markers
  o [netdrvr 8139cp] locking cleanups
  o [NET] forward-compat definition of netdev_priv()
  o [netdrvr 8139cp] minor cleanups
  o [netdrvr 8139cp] use netdev_priv()
  o [netdrvr 8139cp] complete 64-bit DMA (PCI DAC) support
  o [netdrvr 8139cp] better dev->close() handling, and misc related stuff
  o [netdrvr natsemi] correct DP83816 IntrHoldoff register offset
  o [netdrvr tulip] remove ChangeLog file, we have BitKeeper logs now
  o Add SATA support
  o Add Promise SX8 SATA driver
  o [netdrvr via-rhine] Fix MII phy scanning bug, whitespace cleanups

Marcelo Tosatti:
  o Herbert Xu: Delete unused drivers/sound/Hwmcode.h, drivers/sound/724hwmcode.h
  o Cset exclude: loftin@ldl.fc.hp.com|ChangeSet|20040414205510|54931
  o Changed EXTRAVERSION to 2.4.27-pre1
  o Fix drmP.h fix typo

Meelis Roos:
  o Kaupo Arulo: only use set_max when it is present

Paul Gortmaker:
  o [netdrvr 8390] Fix 8390 log spam

Pavel Roskin:
  o Tulip endianess fix

Pete Zaitcev:
  o Improve USB printer locking
  o More USB storage locking fixes

Randy Dunlap:
  o drmP.h doesn't need local cmpxchg() and __cmpxchg()

Scott Feldman:
  o Update MAINTAINERS with new e100/e100 maintainers

Zwane Mwaikambo:
  o fix module load with gcc3.3.3


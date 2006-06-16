Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWFPSN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWFPSN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 14:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFPSN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 14:13:28 -0400
Received: from kanga.kvack.org ([66.96.29.28]:198 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750970AbWFPSN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 14:13:28 -0400
Date: Fri, 16 Jun 2006 15:14:19 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>
Subject: Linux 2.4.33-rc1
Message-ID: <20060616181419.GA15734@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here is 2.4.33-rc1.

Spread collection of fixes, including a number of security fixes
in networking.

Refer to the changelog for details.


Summary of changes from v2.4.33-pre3 to v2.4.33-rc1
============================================

Jean Delvare:
      scx200_acb: Fix resource name use after free
      i2c: Delete 2 out-of-date, colliding ioctl defines

Jesper Juhl:
      fix mem-leak in netfilter

Kirill Korotaev:
      [NETFILTER]: Fix possible overflow in netfilters do_replace()

Marcelo Tosatti:
      Contact information update
      Vadim Egorov: ext3 link/unlink race
      Fix vfs_unlink issue introduced by link/unlink race correction
      Merge master.kernel.org:/.../davem/net-2.4
      Update VERSION to v2.4.33-rc1

Olaf Kirch:
      smbfs chroot issue (CVE-2006-1864)

Patrick McHardy:
      [NETFILTER]: SNMP NAT: fix memory corruption

Pradeep Vincent:
      Neighbour Cache (ARP) State machine bug Fixed

Sergei Shtylyov:
      AMD Au1xx0: fix ethernet TX stats

Shaun Tancheff:
      USB: Gadget RNDIS fix alloc bug. (buffer overflow)

Sridhar Samudrala:
      [SCTP]: Fix state table entries for chunks received in CLOSED state. (CVE-2006-2271)
      [SCTP]: Fix panic's when receiving fragmented SCTP control chunks. (CVE-2006-2272)

Stephen Hemminger:
      [IPV4]: ip_route_input panic fix (CVE-2006-1525)

Theodore Ts'o:
      Fix memory leak when the ext3's journal file is corrupted

Vladislav Yasevich:
      [SCTP]: Prevent possible infinite recursion with multiple bundled DATA. (CVE-2006-2274)

Willy TARREAU:
      fix /proc/partitions display with USB-FDD geometry
      Merge branch 'origin'
      fix /proc/partitions display with USB-FDD geometry
      ext2: update inode ctime on rename()
      bonding: remove a warning with gcc 3
      block: remove the annoying 'blk: queue %p I/O limit %luMb' messages
      scripts : ver_linux does not report recent binutils version
      3c59x: reload EEPROM values at rmmod for needy cards
      netdrv: fix b44 loading after bcm4400
      netdrv: b44 driver must ignore carrier lost errors
      drm: gcc complains that print_heap() in radeon_mem.c is not used.
      ide: trying to enable DMA may cause an oops
      Merge branch 'updates'
      JBD: avoid panic on corrupted journal superblock (from akpm)

Willy Tarreau:
      forcedeth update to 0.50


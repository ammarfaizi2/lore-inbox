Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263547AbSJHUEC>; Tue, 8 Oct 2002 16:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263549AbSJHUDA>; Tue, 8 Oct 2002 16:03:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20658 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S263547AbSJHUBq>; Tue, 8 Oct 2002 16:01:46 -0400
Date: Tue, 8 Oct 2002 16:29:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre10
Message-ID: <Pine.LNX.4.44L.0210081626550.15300-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes pre10.

This version fixes the NFS hang which was introduced in early 2.4.20-pre's
plus some smaller fixes.


Summary of changes from v2.4.20-pre9 to v2.4.20-pre10
============================================

<bjorn.andersson@erc.ericsson.se>:
  o net/8021q/vlan_dev.c: Fix lockup when setting egress priority

<devik@cdi.cz>:
  o net/sched/sch_htb.c: Check that node is really leaf before modifying cl->un.leaf

<hch@sgi.com>:
  o remove a dead extern
  o fix some O_DIRECT read cornercases

<marcelo@freak.distro.conectiva>:
  o Changed EXTRAVERSION to pre10

<rbh00@utsglobal.com>:
  o Several S390 3270 fixes

<yoshfuji@linux-ipv6.org>:
  o [IPV4/IPV6]: General cleanups

Adrian Bunk <bunk@fs.tum.de>:
  o Configure.help entries for BeFS
  o trivial Configure.help bits from -ac

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Fusion driver fixes

Ben Collins <bcollins@debian.org>:
  o IEEE1394 updates

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o PPC32: Tweak the way various PPC cpus (750FX, 750CX, 745x) are set up
  o PPC32: Better support for the 750FX and 7455 PPC cpus
  o PPC32: support for new powermacs including the Xserve and eMac
  o PPC32: idle loop improvements for PPC 6xx/7xx/7xxx processors
  o PPC32: PCI fix for PCI-PCI bridges with the I/O window closed
  o PPC32: Fix race in i2c-keywest
  o PPC32: ide-pmac update
  o PPC32: ADB core locking fix
  o PPC32: Update net driver config description

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o JFS: Releasing LOGGC_LOCK too early

David S. Miller <davem@nuts.ninka.net>:
  o [VLAN]: Accept zero vlan at unregister
  o net/core/dev.c: Print lethal dev/protocol errors with KERN_CRIT
  o net/8021q/vlan.c: Unsigned value may never be < 0

David Woodhouse <dwmw2@infradead.org>:
  o JFFS2 updates

Ingo Molnar <mingo@elte.hu>:
  o Fix speed braindamage of mass exit of thread groups

Lennert Buytenhek <buytenh@gnu.org>:
  o [NET]: Remove net_call_rx_atomic
  o [BRIDGE]: Skip the LISTENING_STP state if STP is disabled
  o [BRIDGE]: take BR_NETPROTO_LOCK for unlinking bridge device slaves

Paul Mackerras <paulus@samba.org>:
  o PPC32: Make the heartbeat count and reset variables be per-cpu
  o PPC32: update the default configs in arch/ppc/configs
  o PPC32: define register numbers for extra BATs; patch from Cort Dougan
  o PPC32: define TIOCM_MODEM_BITS, irda wants it
  o PPC32: Add support for the Total Impact BRIQ platform

Robert Love <rml@tech9.net>:
  o get_pid() typo fix

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Workaround NFS hangs introduced in 2.4.20-pre



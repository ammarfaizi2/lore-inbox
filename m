Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132872AbRDEMP5>; Thu, 5 Apr 2001 08:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132873AbRDEMPh>; Thu, 5 Apr 2001 08:15:37 -0400
Received: from rdu163-40-153.nc.rr.com ([24.163.40.153]:16651 "EHLO
	kaitan.hacknslash.net") by vger.kernel.org with ESMTP
	id <S132872AbRDEMPQ>; Thu, 5 Apr 2001 08:15:16 -0400
Date: Thu, 5 Apr 2001 08:14:33 -0400 (EDT)
From: Jeff Layton <jtlayton@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: unresolved symbols on SPARC with depmod -ae
Message-ID: <Pine.LNX.4.21.0104050804120.26901-100000@kaitan.hacknslash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last few kernels, I seem to always get the following message when
doing make modules_install or depmod -a on both my SPARC boxes. Does this
have something to do with FPU emulation perhaps? The kernels seem to run
fine afterward, but things like SSH seem to be a bit slower
(qualtitatively, I havent checked any hard numbers for it).

Anyway here's what I get, should I be concerned about this?


caladan:~# /sbin/depmod -ae -F /boot/System.map-2.4.2
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/block/loop.o
depmod:         .div
depmod:         .urem
depmod:         .umul
depmod:         .udiv
depmod:         .rem
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/cdrom/cdrom.o
depmod:         .div
depmod:         .umul
depmod:         .rem
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/char/lp.o
depmod:         .div
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/parport/parport.o
depmod:         .div
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/scsi/qlogicpti.o
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/scsi/sg.o
depmod:         .div
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/scsi/sr_mod.o
depmod:         .div
depmod:         .urem
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/drivers/scsi/st.o
depmod:         .div
depmod:         .urem
depmod:         .umul
depmod: *** Unresolved symbols in /lib/modules/2.4.2/kernel/fs/fat/fat.o
depmod:         .div
depmod:         .umul
depmod:         .udiv
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.2/kernel/fs/nfsd/nfsd.o
depmod:         .urem
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/fs/smbfs/smbfs.o
depmod:         .div
depmod:         .umul
depmod:         .udiv
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.2/kernel/fs/vfat/vfat.o
depmod:         .div
depmod:         .rem
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipsec/ipsec.o
depmod:         .urem
depmod:         .umul
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod:         .urem
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv4/netfilter/ip_tables.o
depmod:         .umul
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv4/netfilter/ipt_limit.o
depmod:         .umul
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv4/netfilter/ipt_state.o
depmod:         .urem
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv4/netfilter/iptable_nat.o
depmod:         .urem
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv6/netfilter/ip6_tables.o
depmod:         .umul
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/ipv6/netfilter/ip6t_limit.o
depmod:         .umul
depmod:         .udiv
depmod: *** Unresolved symbols in
/lib/modules/2.4.2/kernel/net/sunrpc/sunrpc.o
depmod:         .umul
depmod:         .udiv



--
Jeff Layton (jtlayton@bigfoot.com)

    "In order for you to profit from your mistakes, you have to get out and
     make some."
        -- Anonymous


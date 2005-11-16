Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbVKPTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbVKPTNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbVKPTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:13:41 -0500
Received: from hera.kernel.org ([140.211.167.34]:34984 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751497AbVKPTNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:13:40 -0500
Date: Wed, 16 Nov 2005 11:13:39 -0800
From: Marcelo Tosatti <marcelo@hera.kernel.org>
Message-Id: <200511161913.jAGJDdQa030411@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.32 released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

final:

- 2.4.32-rc3 was released as 2.4.32 with no changes.


Summary of changes from v2.4.32-rc2 to v2.4.32-rc3
============================================

Marcelo Tosatti:
      only disallow _setting_ of function key string
      Change VERSION to 2.4.32-rc3

Roberto Nibali:
      fix missing refcnt put with expire_nodest_conn


Summary of changes from v2.4.32-rc1 to v2.4.32-rc2
============================================

Aleksey Gorelov:
      asus vt8235 router buggy bios workaround

Alexey Kuznetsov:
      [TCP]: Don't over-clamp window in tcp_clamp_window()

Andrew Morton:
      loadkeys requires root priviledges

Dan Aloni:
      fix memory leak in sd_mod.o

Denis Lukianov:
      [MCAST]: Fix MCAST_EXCLUDE line dupes

Herbert Xu:
      Clear stale pred_flags when snd_wnd change

Horms:
      [IPVS]: Add netdev and me as maintainer contacts
      Fix infinite loop in udp_v6_get_port()

Julian Anastasov:
      [IPVS]: ip_vs_ftp breaks connections using persistence
      [IPVS]: really invalidate persistent templates

Marcelo Tosatti:
      Change VERSION to 2.4.32-rc2

Marcus Sundberg:
      [NETFILTER]: this patch fixes a compilation issue with gcc 3.4.3.

Nick Piggin:
      possible memory ordering bug in page reclaim

Pete Zaitcev:
      usb: regression in usb-ohci

Ralf Baechle:
      AX.25: signed char bug

Willy Tarreau:
      Fix jiffies overflow in delay.h


Summary of changes from v2.4.32-pre3 to v2.4.32-rc1
============================================

Andrey J. Melnikoff:
  Remove isofs useless unsigned " < 0" comparison

Assar:
  nfs client: handle long symlinks properly

Chuck Ebbert:
  i386: fix incorrect FP signal delivery

Dave Johnson:
  [IPV4]: Fix negative timer loop with lots of ipv4 peers.

Gustavo Zacarias:
  [SPARC64]: Use vmalloc() in do_netfilter_replace()

Hasso Tepper:
  [IPV6]: Route events reported with wrong netlink PID and seq number

Horms:
  CAN-2005-0204: AMD64, allows local users to write to privileged IO ports via OUTS instruction
  isofs driver ignore parameters

Jean Delvare:
  update lm_sensors mailing list address

Kirill Korotaev:
  Lost sockfd_put() in routing_ioctl()
  lost fput in 32bit ioctl on x86-64

Kiyoshi Ueda:
  IA64: page_not_present fault in region 5 is normal

M.Baris Demiray:
  Update PPPoE's configuration documentation

Marcelo Tosatti:
  NFS: dprintk on -ENAMETOOLONG error handling
  Update VERSION to 2.4.32-rc1
  Andrea Arcangeli: avoid size_buffers_type overflow
  Merge master.kernel.org:/.../davem/net-2.4
  Revert unnecessary arch/ppc64/boot/zlib.c
  Revert unnecessary zlib_inflate/inftress.c fix

mikem:
  cciss 2.4.60

Patrick McHardy:
  [NETFILTER]: Handle NAT module load race

Summary of changes from v2.4.32-pre2 to v2.4.32-pre3
============================================

Aaron Grothe:
  Fix XTEA implementation

Alan Stern:
  Revert USB UHCI changes

Aleksey Gorelov:
  Fix incorrect Asus k7m irq router detection

bdupree@techfinesse.com:
  Fix Alpha AXP Cabriolet build

deep-blue@t-online.de:
  fix RedBlackTree rb_next/rb_prev functions

Harald Welte:
  Remove bogus declaration of ipt_mutex

Horms:
  ppc32: stop misusing ntps time_offset value

Jeff Garzik:
  libata: update to 2.6.x latest

John W. Linville:
  i810_audio: use MMIO on systems that support it
  i810_audio: offset LVI from CIV to avoid stalled start

Ju, Seokmann:
  megaraid2 v2.10.10.1

Lars Marowsky-Bree:
  fix oops when starting md multipath 2.4 kernel

Linus Torvalds:
  PATCH: Fix outstanding gzip/zlib security issues

Marcelo Tosatti:
  Change VERSION to v2.4.32-pre3
  Change VERSION to v2.4.32-pre2
  Merge rsync://rsync.kernel.org/.../davem/net-2.4

Patrick McHardy:
  [NETFILTER]: Use correct byteorder in ICMP NAT
  [NETFILTER]: Fix potential memory corruption in NAT code (aka memory NAT)
  [NETFILTER]: Fix ip6t_LOG sit tunnel logging
  [NETFILTER]: Restore netfilter assumption in IPv6 multicast
  [NETFILTER]: Fix deadlock with ip_queue/ip6_queue
  [NETFILTER]: Ignore PSH on SYN/ACK in ipt_unclean

Willy TARREAU:
  fix potential NULL dereferences in several serial driver methods (Julien Tinnes)

Summary of changes from v2.4.32-pre1 to v2.4.32-pre2
============================================

Alan Stern:
  file_storage and UHCI bugfixes

David S. Miller:
  [NETLINK]: Fix two socket hashing bugs.

Jakub Bogusz:
  [SPARC64]: fix sys32_utimes(somefile, NULL)

Larry Woodman:
  workaround inode cache (prune_icache/__refile_inode) SMP races

Marcelo Tosatti:
  Change VERSION to 2.4.32-pre2
  Merge with rsync://rsync.kernel.org/.../davem/net-2.4.git
  Revert [NETLINK]: Fix two socket hashing bugs.

Neil Horman:
  [IPVS]: Close race conditions on ip_vs_conn_tab list modification

Pete Zaitcev:
  usb: printer double up()

Tim Yamin:
  Merge with rsync://rsync.kernel.org/.../davem/sparc-2.4.git/
  The gzip description is as good as the ChangeLog says it is -: "Set n to


Summary of changes from v2.4.31 to v2.4.32-pre1
============================================

Andi Kleen <ak@suse.de>:
  x86-64: Enable Nvidia timer override workaround for SMP kernels too
  x86-64: Fix build with !CONFIG_SWIOTLB
  x86_64: Disable exception stack for stack faults
  Fix canonical checking for segment registers in ptrace
  Check for canonical addresses in ptrace
  Fix buffer overflow in x86-64/ia64 32bit execve

David S. Miller <davem@davemloft.net>:
  [NETLINK]: Fix two socket hashing bugs.
  [SPARC64]: Fix cmsg length checks in Solaris emulation layer.
  [SPARC64]: Fix conflicting __bzero_noasi() prototypes.

H. J. Lu <hjl@lucon.org>:
  newer i386/x86_64 assemblers prohibit instructions for moving between a seg register and a 32bit location

Marcel Holtmann <marcel@holtmann.org>:
  Fix" introduced in 2.4.27pre2 for bluetooth hci_usb race causes kernel hang

Marcelo <marcelo@xeon.cnet>:
  Change VERSION to 2.4.32-pre1

NeilBrown <neilb@cse.unsw.edu.au>:
  Claim i_alloc_sem while changing file size in nfsd
  Don't drop setuid on directories when ownership changed by NFSd

Pete Zaitcev <zaitcev@redhat.com>:
  USB 2.4.31: ftdi_sio fixes

Ralf Baechle <ralf@linux-mips.org>:
  update netdev address


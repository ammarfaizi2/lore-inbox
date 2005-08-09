Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVHICyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVHICyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 22:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVHICyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 22:54:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28291 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932425AbVHICyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 22:54:44 -0400
Date: Mon, 8 Aug 2005 23:49:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.32-pre3
Message-ID: <20050809024948.GN9569@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here goes v2.4.32-pre3. It contains several v2.6 backported fixes, amongst
them:

- libata update
- networking fixes (most notably Netfilter)

Please refer to the changelog for the detailed information

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


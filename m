Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVJaXLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVJaXLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVJaXLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:11:17 -0500
Received: from hera.kernel.org ([140.211.167.34]:37095 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964886AbVJaXLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:11:16 -0500
Date: Mon, 31 Oct 2005 15:57:04 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.32-rc2
Message-ID: <20051031175704.GA619@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the second release candidate for v2.4.32.

The most significant changes are v2.6 backports of IPv4/IPv6 bugfixes,
and a USB OHCI regression introduced during v2.4.28 which could lead to
crashes on SMP kernels.


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


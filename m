Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUFTAwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUFTAwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 20:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUFTAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 20:52:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43904 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264826AbUFTAwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 20:52:25 -0400
Date: Sat, 19 Jun 2004 21:45:20 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.27-rc1
Message-ID: <20040620004520.GA4599@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the first release candidate of kernel v2.4.27. 

It contains a handful of ACPI bugfixes, HPFS update, USB fixes, 
amongst other smaller fixes.

Read the detailed changelog for more details

Summary of changes from v2.4.27-pre6 to v2.4.27-rc1
============================================

<andreas:xss.co.at>:
  o fix hotplug Config.in xconfig breakage

Andi Kleen:
  o Undo mistaken hunks in previous x86-64 MCE change
  o Add missing include to x86-64 bluesmoke.c

Chris Wedgwood:
  o stat nlink resolution fix

David S. Miller:
  o Cset exclude: kaber@trash.net|ChangeSet|20040529193918|20643

David Stevens:
  o [IPV4]: Fix interface selection in multicast sockops

Eyal Lebedinsky:
  o Fix USB visor.c compilation error

Hideaki Yoshifuji:
  o [IPV6]: UDPv6 checksum
  o [IPV6]: UDPv6: Use udpv6_queue_rcv_skb()
  o [IPV6]: Missing include in ip6_tables.c

Karol Kozimor:
  o acpi4asus trivial sync with 2.6 (Karol 'sziwan' Kozimor)

Len Brown:
  o [ACPI] PCI bus numbering workaround for ServerWorks from David Shaohua Li http://bugzilla.kernel.org/show_bug.cgi?id=1662
  o [ACPI] fix passive cooling mode indicator (Luming Yu) http://bugzilla.kernel.org/show_bug.cgi?id=1770
  o [ACPI] avoid spurious interrupts on VIA http://bugzilla.kernel.org/show_bug.cgi?id=2243
  o [ACPI] fix 2.4.27-pre3 IRQ override regression due to dynamically allocated mp_irqs[].
  o [ACPI] handle SCI override to nth IOAPIC http://bugzilla.kernel.org/show_bug.cgi?id=2835

Marcelo Tosatti:
  o Add missing struct definition of rwsem race fixes
  o Changed EXTRAVERSION to -rc1
  o journal_try_to_free_buffers(): Add debug print in case of bh list corruption

Mikulas Patocka:
  o HPFS fixes

Pete Zaitcev:
  o USB: Fix jumpshot's capacity




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUC1Ek7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 23:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUC1Ek7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 23:40:59 -0500
Received: from mail.cyclades.com ([64.186.161.6]:63389 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262068AbUC1Eky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 23:40:54 -0500
Date: Sun, 28 Mar 2004 01:26:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.26-rc1
Message-ID: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Finally, -rc1.

The first -rc contains an ACPI update, networking fixes, amongst others.

Please test!

Summary of changes from v2.4.26-pre6 to v2.4.26-rc1
============================================

Chas Williams:
  o [ATM]: [lec] lec_push() races with vcc->proto_data
  o [ATM]: [nicstar] use kernel min/max (by Randy.Dunlap <rddunlap@osdl.org>)

David S. Miller:
  o [IGMP]: Do nothing in ip_mc_down() if ip_mc_up() was not called previously
  o [SPARC64]: Update defconfig

Dmitry Torokhov:
  o [NET_SCHED]: Fix class reporting in TBF qdisc
  o [NET_SCHED]: Trailing whitespace cleanup in TBF scheduler

Jon Oberheide:
  o [CRYPTO]: Remove confusing TODO comment in arc4.c

Julian Anastasov:
  o [IPVS] Fix to update the skb->h.raw after skb reallocation in tunnel_xmit
  o [IPVS] Fix connection rehashing with new cport

Len Brown:
  o [ACPI] PCI interrupt link routing (Luming Yu) use _PRS to determine resource type for _SRS fixes HP Proliant servers http://bugzilla.kernel.org/show_bug.cgi?id=1590
  o [ACPI] proposed fix for non-identity-mapped SCI override http://bugme.osdl.org/show_bug.cgi?id=2366
  o [ACPI] ACPICA 20040326 from Bob Moore
  o [ACPI] Linux specific updates from ACPICA 20040326 "acpi_wake_gpes_always_on" boot flag for old GPE behaviour

Marcel Holtmann:
  o [Bluetooth] Add support for AVM BlueFRITZ! USB v2.0
  o [Bluetooth] Remove non-blocking socket fix

Marcelo Tosatti:
  o Trond: Avoid refile_inode() from putting locked inodes on the dirty list
  o Changed EXTRAVERSION to -rc1

Martin Devera:
  o [NET_SCHED]: HTB scheduler updates

Patrick McHardy:
  o [NET_SCHED]: Fix broken indentation in HFSC scheduler
  o [NET_SCHED]: Fix requeueing in HFSC scheduler
  o [NET_SCHED]: Use queue limit of 1 when tx_queue_len is zero

Sridhar Samudrala:
  o [SCTP] Don't do any ppid byte-order conversions as it is opaque to SCTP
  o [SCTP] Avoid the use of hacking CONFIG_IPV6_SCTP__ option

Stephen Hemminger:
  o [NET_SCHED]: Add packet delay scheduler

Wensong Zhang:
  o [IPVS]: Fix to hold the lock before updating a service


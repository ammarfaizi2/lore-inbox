Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270130AbRHMMQF>; Mon, 13 Aug 2001 08:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270131AbRHMMPz>; Mon, 13 Aug 2001 08:15:55 -0400
Received: from node121b3.a2000.nl ([24.132.33.179]:39074 "EHLO
	node121b3.a2000.nl") by vger.kernel.org with ESMTP
	id <S270130AbRHMMPo>; Mon, 13 Aug 2001 08:15:44 -0400
Date: Mon, 13 Aug 2001 14:15:43 +0200 (CEST)
From: <chabotc@node121b3.a2000.nl>
To: <linux-kernel@vger.kernel.org>
cc: <netfilter@lists.samba.org>
Subject: IPTables 1.2.2 w/ Kernel 2.4.8 questions
Message-ID: <Pine.LNX.4.33.0108131403220.28838-100000@node121b3.a2000.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guys, im having some serious problems trying to get my existing
firewall working with kernel 2.4.8..

The base system is a rh70 box, upgraded with iptables 1.2.2, and kernel
2.4.8. When setting up my firewall i get the folowing errors:

iptables v1.2.2: can't initialize iptables table `mangle': Module is
wrong version

iptables v1.2.2: can't initialize iptables table `filter': Module is wrong
version

However when i do cat /proc/net/ip_tables_names it has :
nat
mangle
filter

Also the MASQ table does seem to work ..

I have recompiled iptables for the new kernel, tried the iptables kernel
part as module and as compiled in
(dmesg: ip_conntrack (4095 buckets, 32760 max)
ip_tables: (c)2000 Netfilter core team)

I've tried the pending-patches and/or patch-o-matic make targets for
iptables 1.2.2, etc ... nothing however seems to want to fix my errors.

I've also read the kernel config help files, and the iptables howto's &
FAQ's, and nothing seems to mention this kind of situation.. Is there
something im overlooking ?

Ps, pls cc my address in the replies, since im not subscribed to the
mailing lists (just get digests).

Any help or hints would be greatly apreciated!

	-- Chris Chabot



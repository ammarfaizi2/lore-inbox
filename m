Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbRGZLmO>; Thu, 26 Jul 2001 07:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbRGZLmE>; Thu, 26 Jul 2001 07:42:04 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:56583 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S267241AbRGZLlv>; Thu, 26 Jul 2001 07:41:51 -0400
Date: Thu, 26 Jul 2001 13:41:34 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: another arp problem
Message-ID: <Pine.LNX.4.31.0107261332360.23779-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi folks!

My machine has two NICs, eth0 is official, eth1 on a private subnet. When
arping 192.168.1.254 (scope link on eth1) from the official side I get a
reply which should not be there (that's the sense in "private", right?).
Setting /proc/sys/net/ipv4/conf/*/arp_filter doesn't help...

Ciao,
					Roland


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281252AbRKHB7a>; Wed, 7 Nov 2001 20:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281267AbRKHB7U>; Wed, 7 Nov 2001 20:59:20 -0500
Received: from mail008.syd.optusnet.com.au ([203.2.75.232]:35729 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S281252AbRKHB7B>; Wed, 7 Nov 2001 20:59:01 -0500
Date: Thu, 8 Nov 2001 12:58:51 +1100
From: Andrew Pam <xanni@glasswings.com.au>
To: linux-kernel@vger.kernel.org
Subject: ipchains.o dependencies problem from 1999 (!) returns in 2.4.14 kernel
Message-ID: <20011108125851.K673@kira.glasswings.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4.14 kernel, I get the following dependency problems with ipchains.o:

[root@TekTih root]# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.14+ext3/kernel/net/ipv4/netfilter/ipchains.o
depmod:         netlink_kernel_create
depmod:         netlink_broadcast

Note that this happens regardless of the setting of CONFIG_NETLINK and
CONFIG_NETLINK_DEV, whether "n", "m" or "y".

Earlier LKML messages on this topic:
http://www.uwsg.iu.edu/hypermail/linux/kernel/9909.0/0485.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/9909.0/0675.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.3/0188.html

Note that the problem was first noted with 2.3.16, again with 2.4.0-test
and now yet again with 2.4.14.

Hope someone can fix it for good this time!

Cheers,
	Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/sc/                   Manager, Serious Cybernetics
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915

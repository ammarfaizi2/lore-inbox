Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132676AbRADMgS>; Thu, 4 Jan 2001 07:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132874AbRADMgI>; Thu, 4 Jan 2001 07:36:08 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:47304 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132676AbRADMfy>; Thu, 4 Jan 2001 07:35:54 -0500
Message-ID: <3A546F8E.ABF952F@uow.edu.au>
Date: Thu, 04 Jan 2001 23:41:50 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Loth <chris@gidayu.max.uni-duisburg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: DHCP Problems with 3com 3c905C Tornado
In-Reply-To: <20010104123139.A15097@gidayu.max.uni-duisburg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Loth wrote:
> 
> Hello all,

Hi, Christian.

>   I recently installed a system with the 3c905C
> NIC on RedHat 6.2. In our network, IP adresses
> are granted via DHCP, although every host has
> a fixed IP instead of a dynamic IP pool. The IP
> is statically coupled with the MAC adresses of
> our network.

hmm..  I've heard of this once before.  Running
pump from the RH initscripts?

>   The freshly installed RedHat 6.2 worked nice
> and flawlessly, and the IP was handed out correctly
> to the new machine. However after upgrading
> to the 2.2.16 RedHat Kernel RPMS, the DHCP negotiation
> no longer worked! Okay, I said, maybe it is a RedHat
> thing (they included modules both for the 90x and for the 59x
> cards, and I tried both),

Did _both_ 3c90x and 3c59x fail, or only 3c59x?

> so I downloaded 2.2.18 proper.
> I compiled in the support for the card, but also: same
> result. The old 2.2.14 RedHat kernel worked, but the
> newer kernels did not.
> 
>   Unfortunately the machine had to go on the net, so I had
> to switch the NIC for a DEC Tulip one, which worked flawlessly
> under 2.2.18 again. Therfore I unfortunately can't volunteer
> for testing :(, all I can say is that something happened
> between 2.2.14 and 2.2.16/2.2.18 which made DHCP inoperable
> for the 3c905C.

Thanks.  I'll try to reproduce this (fat chance :().
Is there any chance you can set this arrangement up
again in the future?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

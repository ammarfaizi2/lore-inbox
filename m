Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131955AbRAGNhP>; Sun, 7 Jan 2001 08:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRAGNhF>; Sun, 7 Jan 2001 08:37:05 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:5803 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131955AbRAGNhB>; Sun, 7 Jan 2001 08:37:01 -0500
Message-ID: <3A58725F.A1E3CD37@uow.edu.au>
Date: Mon, 08 Jan 2001 00:42:55 +1100
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
> 
>   I recently installed a system with the 3c905C
> NIC on RedHat 6.2. In our network, IP adresses
> are granted via DHCP, although every host has
> a fixed IP instead of a dynamic IP pool. The IP
> is statically coupled with the MAC adresses of
> our network.

Christian,

I was able to reproduce this.  All sorts of wierd stuff.

All the problems magically disappeared after upgrading
to pump-0.8.6.

You wouldn't *believe* how hard it is to find a pump
tarball, so I've put one at

	http://www.uow.edu.au/~andrewm/pump-0.8.6.tar.gz

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

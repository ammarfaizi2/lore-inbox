Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276452AbRJKQhA>; Thu, 11 Oct 2001 12:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJKQgv>; Thu, 11 Oct 2001 12:36:51 -0400
Received: from willow.commerce.uk.net ([213.219.35.202]:5914 "EHLO
	willow.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S276452AbRJKQgp>; Thu, 11 Oct 2001 12:36:45 -0400
Date: Thu, 11 Oct 2001 17:37:10 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: linux-kernel@vger.kernel.org
cc: "J . A . Magallon" <jamagallon@able.es>
Subject: problems with lo and AF_NETLINK
Message-ID: <Pine.LNX.4.21.0110111730250.25144-100000@willow.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,
	
I'm having problems with getting kernel 2.4.12 (and yesterday 2.4.11, but
that has bitten the dust now) to work on my laptop (Dell Inspiron 8000,
PIII-850, 512MB RAM).

I searched the lkml archive, and found the following post which describes
my problem exactly:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=99475318111175&w=2

Unfortunately nobody responded to it. I assume that something to do with
AF_NETLINK has been merged in from the -ac series since 2.4.8, as the
distributor supplied kernel (2.4.8-26mdk) works fine.

As the previous poster suggested, I have tried re-compiling with
CONFIG_NETLINK_DEV, but that didn't help, and I am still getting:

  Cannot send dump request: Connection refused

Does anyone have any suggestions?

Thanks,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        | 
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/


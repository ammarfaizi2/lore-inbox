Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278403AbRKDWw2>; Sun, 4 Nov 2001 17:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279603AbRKDWwR>; Sun, 4 Nov 2001 17:52:17 -0500
Received: from colorfullife.com ([216.156.138.34]:13327 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S278403AbRKDWwK>;
	Sun, 4 Nov 2001 17:52:10 -0500
Message-ID: <3BE5C699.4FF8322B@colorfullife.com>
Date: Sun, 04 Nov 2001 23:52:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        John Fremlin <john@fremlin.de>, linux-kernel@vger.kernel.org
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <20011104180055.F2312-100000@gerard> <3BE5C136.2259F283@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Gérard Roudier wrote:
> > different from Tekram adapters. Btw, my Netgear FA311 board is not handled
> > by the sis driver of linux-2.2.20 and my little finger tells me that it
> > could be so given a few code addition.
> 
> Unless you have a really strange board I haven't seen, NetGear FA311 are
> the natsemi DP83815/6 chips, handling by either "natsemi" or "fa311"
> drivers, not "sis900" driver...
>
sis900 and natsemi are similar, probably both could be handled with one
driver.
e.g. freebsd has one driver for natsemi and sis900.

But I'm not a big fan of huge drivers that handle multiple 99%
compatible controllers and always break for one controller if you try to
fix another controller, so I won't try to merge them.

--
	Manfred

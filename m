Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272245AbRH3UEU>; Thu, 30 Aug 2001 16:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272424AbRH3UEL>; Thu, 30 Aug 2001 16:04:11 -0400
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:41484 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S272245AbRH3UDz>; Thu, 30 Aug 2001 16:03:55 -0400
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200108302003.f7UK3V919881@wildsau.idv-edu.uni-linz.ac.at>
Subject: Re: arp.c duplicate assignment of skb->dev ("cosmetic")
In-Reply-To: <3B8E8264.8090700@ixiacom.com> from Bryan Rittmeyer at "Aug 30, 1 11:13:56 am"
To: bryan@ixiacom.com (Bryan Rittmeyer)
Date: Thu, 30 Aug 2001 22:03:31 +0200 (MET DST)
Cc: herp@wildsau.idv-edu.uni-linz.ac.at, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this is rather cosmetical than functional, but in arp.c,
> > in arp_send(), on line 489
> > 
> > 	skb->dev=dev;
> > 
> > is assigned. in line 563, still in the same routine, it is
> > assigned again without skb or skb->dev being changed. so I guess
> 
> Hi Herbert,
> 
> I also noticed this dupe a couple days ago and pointed it out to
> the lkml

eeks. I hope it does not look like I have been posting this only because
I saw your email to lkml. In fact, I've found this a while ago, but was
just too lazy to email it.

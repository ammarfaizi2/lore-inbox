Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRKHSgz>; Thu, 8 Nov 2001 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277533AbRKHSgp>; Thu, 8 Nov 2001 13:36:45 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:54027 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277431AbRKHSgg>;
	Thu, 8 Nov 2001 13:36:36 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111081832.VAA24875@ms2.inr.ac.ru>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
To: adilger@turbolabs.com (Andreas Dilger)
Date: Thu, 8 Nov 2001 21:32:32 +0300 (MSK)
Cc: davem@redhat.com, tim@physik3.uni-rostock.de, jgarzik@mandrakesoft.com,
        andrewm@uow.edu.au, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, netdev@oss.sgi.com, ak@muc.de
In-Reply-To: <20011108111024.X5922@lynx.no> from "Andreas Dilger" at Nov 8, 1 11:10:24 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> is more likely that nobody knows about them, because nobody uses them, 
> because nobody knows about them, etc.

Yes, it is thing which usually happens with good macros. :-)


> If people don't want to see them, that is fine with me - they will stop.

I talk only about neighbour.c. It is pretty hairy to bring it to
brain cache fastly enough. And I am afraid (remember) that in the past
I did some silly tricks, sort of using the fact that large positive
now - mark means that mark is in future. Mostly likely killed together
with another hacks, but I am not sure.

Another places are trivial as rule and can be edited any time.

Alexey

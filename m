Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272822AbRISSzE>; Wed, 19 Sep 2001 14:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRISSyy>; Wed, 19 Sep 2001 14:54:54 -0400
Received: from t2.redhat.com ([199.183.24.243]:34554 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272822AbRISSyl>; Wed, 19 Sep 2001 14:54:41 -0400
Message-ID: <3BA8EA04.E55BAA02@redhat.com>
Date: Wed, 19 Sep 2001 19:55:00 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com> <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:
> 
> On Wed, 19 Sep 2001, Linus Torvalds wrote:
> > It is _probably_ an undocumented performance thing, and clearing that
> > bit may slow something down. But it might also change some behaviour,
> > and knowing _what_ the behaviour is might be very useful for figuring
> > out what it is that triggers the problem.
> 
> AFAIK noone has even tested it yet to see what it does to performance! Eg
> it might slow down memory access so that athlon-optimized memcopy is now
> slower than non-athlon-optimized memcopy. And if it turns out to be the
> case, we might as well just use the non-athlon-optimized memcopy instead
> of twiddling undocumented northbridge bits...

Ok but that part is simple:

run

http://www.fenrus.demon.nl/athlon.c

.....

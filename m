Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRKHSSh>; Thu, 8 Nov 2001 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277512AbRKHSS0>; Thu, 8 Nov 2001 13:18:26 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:1284 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S273345AbRKHSSI>; Thu, 8 Nov 2001 13:18:08 -0500
Date: Thu, 8 Nov 2001 19:10:05 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <kuznet@ms2.inr.ac.ru>
cc: "David S. Miller" <davem@redhat.com>, <jgarzik@mandrakesoft.com>,
        <andrewm@uow.edu.au>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>, <adilger@turbolabs.com>,
        <netdev@oss.sgi.com>, <ak@muc.de>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <200111081754.UAA24454@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0111081900090.6561-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >    jiffies cleanup patch of the day follows. Mostly boring changes of jiffies
> >    comparisons to use time_{before,after} in order to handle jiffies
> >    wraparound correctly.
>
> I want to _ask_ one thing people working on these changes.
> _Please_, defer this edit to 2.5. The changes are very good,
> but time for them is very bad.
>

Agreed. For now I will only post patches for code that really _is_ broken.
I've already learned that from the discussion with David Miller.
This way I might miss some places getting the comparison wrong, but
changes will be less intrusive.

However, I definitely want to see a 2.4.x someday that is able to run
for more that 497 days.


Tim


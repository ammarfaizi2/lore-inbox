Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbUL2X2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUL2X2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 18:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUL2X2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 18:28:13 -0500
Received: from mail.dif.dk ([193.138.115.101]:32957 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261175AbUL2X2G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 18:28:06 -0500
Date: Thu, 30 Dec 2004 00:39:10 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
In-Reply-To: <Pine.LNX.4.61.0412290344340.28589@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412300037310.3495@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost>
 <41D2104D.3010406@conectiva.com.br> <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost>
 <41D2120E.8030008@conectiva.com.br> <20041229021256.GD29323@wohnheim.fh-wedel.de>
 <41D2152F.8080501@conectiva.com.br> <Pine.LNX.4.61.0412290344340.28589@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004, Jesper Juhl wrote:

> On Wed, 29 Dec 2004, Arnaldo Carvalho de Melo wrote:
> 
> > 
> > 
> > Jörn Engel wrote:
> > > On Wed, 29 December 2004 00:10:22 -0200, Arnaldo Carvalho de Melo wrote:
> > > 
> > > > > It doesn't make much difference, it's mostly for
> > > > > completeness/correctness.
> > > > 
> > > > No, it does a helluva difference, give it a try :-)
> > > 
> > > 
> > > hint: look for "\n"
> > 
> > hint2: Or the _lack_ of "\n" 8)
> > 
> 
> Ok, obviously something's wrong, but it's currently 03:44 here, so I'll 
> take a look at it tomorrow (or quite possibly the day after since I have 
> things to do).
> Thank you for commenting, I'll dig into it at the first oppotunity I have.
> 
> 
Ok, this is a bit embarresing. Looking at the patch now after getting some 
sleep it's quite obvious that it is wrong. I should have slept on it 
before sending it - sorry for the noise people.

-- 
Jesper Juhl




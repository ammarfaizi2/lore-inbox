Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUL3COj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUL3COj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 21:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL3COj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 21:14:39 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:18587 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261519AbUL3CMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 21:12:40 -0500
Date: Thu, 30 Dec 2004 03:12:39 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Networking Team <netdev@oss.sgi.com>,
       linux-net <linux-net@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch: add loglevel to printk's in net/ipv4/route.c
Message-ID: <20041230021239.GA31474@mail.13thfloor.at>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Networking Team <netdev@oss.sgi.com>,
	linux-net <linux-net@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0412290256000.3528@dragon.hygekrogen.localhost> <41D2104D.3010406@conectiva.com.br> <Pine.LNX.4.61.0412290312540.3528@dragon.hygekrogen.localhost> <41D2120E.8030008@conectiva.com.br> <20041229021256.GD29323@wohnheim.fh-wedel.de> <41D2152F.8080501@conectiva.com.br> <Pine.LNX.4.61.0412290344340.28589@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412300037310.3495@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0412300037310.3495@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 12:39:10AM +0100, Jesper Juhl wrote:
> On Wed, 29 Dec 2004, Jesper Juhl wrote:
> 
> > On Wed, 29 Dec 2004, Arnaldo Carvalho de Melo wrote:
> > 
> > > 
> > > 
> > > Jörn Engel wrote:
> > > > On Wed, 29 December 2004 00:10:22 -0200, Arnaldo Carvalho de Melo wrote:
> > > > 
> > > > > > It doesn't make much difference, it's mostly for
> > > > > > completeness/correctness.
> > > > > 
> > > > > No, it does a helluva difference, give it a try :-)
> > > > 
> > > > 
> > > > hint: look for "\n"
> > > 
> > > hint2: Or the _lack_ of "\n" 8)
> > > 
> > 
> > Ok, obviously something's wrong, but it's currently 03:44 here, so I'll 
> > take a look at it tomorrow (or quite possibly the day after since I have 
> > things to do).
> > Thank you for commenting, I'll dig into it at the first oppotunity I have.
> > 
> > 
> Ok, this is a bit embarresing. Looking at the patch now after getting some 
> sleep it's quite obvious that it is wrong. I should have slept on it 
> before sending it - sorry for the noise people.

nothing to be sorry about, and thanks for all
the work you are doing for the linux kernel ...

best,
Herbert

> -- 
> Jesper Juhl
> 
> 
> 
> 

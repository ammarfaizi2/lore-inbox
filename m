Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRKPAOy>; Thu, 15 Nov 2001 19:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281194AbRKPAOp>; Thu, 15 Nov 2001 19:14:45 -0500
Received: from ebola.baana.suomi.net ([213.139.166.70]:3347 "EHLO
	ebola.baana.suomi.net") by vger.kernel.org with ESMTP
	id <S281184AbRKPAOh>; Thu, 15 Nov 2001 19:14:37 -0500
Date: Fri, 16 Nov 2001 02:14:34 +0200 (EET)
From: janne <sniff@xxx.ath.cx>
To: linux-kernel@vger.kernel.org
cc: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <Pine.LNX.4.33.0111151811310.618-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.10.10111160210150.21102-100000@ebola.baana.suomi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > like, if memory is full and there's less than 10% of total mem used for
> > cache, then start swapping out. not if ~90% is already used for cache.. :)
> 
> Numbers like this don't work.  You may have a very large and very hot
> cache.. you may also have a very large and hot gob of anonymous pages.

yes of course, sorry if i was not clear. it wasn't meant to be an
implementation suggestion since i know there's a lot more to consider,
and even then those figures might not be feasible. i was just trying to
highlight the particular problem i was having..


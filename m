Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSKHSKt>; Fri, 8 Nov 2002 13:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSKHSKt>; Fri, 8 Nov 2002 13:10:49 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:53660 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261333AbSKHSKs>; Fri, 8 Nov 2002 13:10:48 -0500
Subject: Re: [PATCH-2.5.46] IDE BIOS timings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021108165641.GA18126@suse.de>
References: <20021107164009.GL1737@tmathiasen>
	<1036775438.16898.31.camel@irongate.swansea.linux.org.uk> 
	<20021108165641.GA18126@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 18:40:50 +0000
Message-Id: <1036780850.16651.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 16:56, Jens Axboe wrote:
> > Linus please drop this patch for now. Its not been tested on enough
> > controllers, its making things unneccessarily ugly and its also just
> > going to make updates hard.
> 
> Alan, the patch is pretty much straight forward. Cleaning up the magic
> numbers and ->autotune consistencies is a good thing, imo.

You can clean up the naming but it still hasn't been tested, not all
bioses neccessarily give us timings we can trust either.  I'm not
opposed to the concept but after the previous IDE mess in 2.5 merging
something that isnt tested on lots of controllers and might have weird
effects does both me a bit



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289342AbSAJFfR>; Thu, 10 Jan 2002 00:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289343AbSAJFe6>; Thu, 10 Jan 2002 00:34:58 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:25740 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S289342AbSAJFe4>; Thu, 10 Jan 2002 00:34:56 -0500
Date: Thu, 10 Jan 2002 07:34:41 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
Message-ID: <20020110073441.P1200@niksula.cs.hut.fi>
In-Reply-To: <20020109235722.L1200@niksula.cs.hut.fi> <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201100025440.14057-100000@tux.rsn.bth.se>; from gandalf@wlug.westbo.se on Thu, Jan 10, 2002 at 12:30:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 12:30:37AM +0100, you [Martin Josefsson] claimed:
> 
> I havn't followed this thread but I have a machine with an Asus A7V
> motherboard with KT133 chipset and we had massive corruption before
> christmas, both ide and network had corrupted packets. and now after
> christmas we ran memtest86 on it and a 256MB module was very very broken.
> and we got alot of Oopses and all kinds of strange stuff happened.

We ran memtest86 at one point but it showed nothing. We changed the memory
modules, and it didn't help. (I did seem like the order and placement of the
modules on the mobo made difference, but that turned out to be false
positive. Trying harder made the corruption happen again.)

Also, we only begun to see oopses when we stress tested hpt370 ide AND
network (so far we did only stress hpt370 and run "normal" stuff). The board
never oopsed or behaved strangely other than the hpt370 corruption and the
hpt370+3c905 stress test oopses.
 
> We are going to replace the motherboard with one with VIA KT266A chipset,
> hope that works better.

If we get around to replace the bugger, the one thing I'll make sure is that
the replacement is not Via. Even if 1000 people told me KT266A was stable.


-- v --

v@iki.fi

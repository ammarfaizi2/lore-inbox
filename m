Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTFMMjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 08:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbTFMMjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 08:39:45 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:18168 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265374AbTFMMjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 08:39:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: I Am Falling I Am Fading <skuld@anime.net>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Via KT400 and AGP 8x Support
Date: Fri, 13 Jun 2003 07:52:57 -0500
X-Mailer: KMail [version 1.2]
Cc: John Bradford <john@grabjohn.com>, <gregor.essers@web.de>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306120633490.14263-100000@inconnu.isu.edu>
In-Reply-To: <Pine.LNX.4.44.0306120633490.14263-100000@inconnu.isu.edu>
MIME-Version: 1.0
Message-Id: <03061307525700.13701@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 June 2003 07:36, I Am Falling I Am Fading wrote:
> On Thu, 12 Jun 2003, Dave Jones wrote:
> >  > Tried it already... The pins are too small to get adequate purchase
> >  > for the tape -- the friction just causes it to slide around in the
> >  > slot and gets goo around.
> >  >
> >  > Superglue might be a better solution....
> >  > ...but I think the solder method is better.
> >
> > So rather than experiment with backporting the 2.5 code to 2.4,
> > you'd rather risk damaging your hardware ?
> >
> > I think this way is madness.
>
> Unfortunately even a perfect backport seems to be only a partial solution
> -- the ATI binary only drivers don't seem to know how to talk to the 2.5
> AGP 3.0 stuff anyway (well, at least they didn't work at all when I tried
> them under the 2.5 kernel :-/), and as they are lame binary-only drivers
> there is no way to fix that.
>
> There are also no other drivers for the R300-series Radeon GPUs. :-(
>
> This absolutely sucks, but turning the card into an AGP 2.0 card seems to
> be the only surefire way to get it to work properly under Linux. :-(

I'm not sure this will help the hardware situation, but you could try a
bus extender (it will make the board stick out of the slot a couple of 
inches).

It should allow you the option of either cutting the extender wire traces
or pull jumpers to see if things do work.

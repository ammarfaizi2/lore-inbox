Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTLURvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 12:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLURvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 12:51:19 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:62948 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S263775AbTLURvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 12:51:17 -0500
Date: Sun, 21 Dec 2003 18:51:14 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11 framebuffer Matrox
Message-ID: <20031221175114.GA26599@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <200312190314.13138.schwientek@web.de> <brv8uh$but$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <brv8uh$but$1@sea.gmane.org>
X-Operating-System: vega Linux 2.6.0-test11 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 04:28:01PM +0000, nick black wrote:
> In article <200312190314.13138.schwientek@web.de>, Steffen Schwientek wrote:
> > My Matrox-framebuffer is not working properly. Build direct into the
> > kernel, the monitor will be black with some stripes at startup, just the
> > reset button works.
> > Build as a modules, the same happens if I load the module.
> 
> I've managed to get my AGP G400 working in the following setups under
> 2.6.0 since -test7:
> 
> with Petr's patch, reverting to 2.4 interfaces:
>   video=matroxfb:vesa:0x1bb gives me a great fbcon.  I can either use
>   X's fbdev driver at the same resolution, or the mga driver at any
>   resolution, with no problems.
> 
> without Petr's patch:
>   video=matroxfb:vesa:0x1bb gives me a great fbcon.  I can only use
>   X's fbdev driver at the same resolution; the mga driver at any
>   resolution causes massive console corruption upon switching from X to
>   console and causing any screen changes.  Also, I get a large white
>   block underneath the logo on boot.

Nice. :-) and :-(
With that patch, now I'm happy user of 2.6.0 ;-)
[I was that since 2.6.0-test1, but only on one machine of mine, where fb
 was not important at all]

My only question is: why was fb layer modofied to a state which is UNUSABLE
without a patch which reverts to the 2.4 interface? I'm trying to search
archives and various document, and now I've got the feeling that several
author thinks fbcon only a toy and its ONLY purpose to get the tux logo
on booting. Which is completly false of course ;-(

SORRY (!) if I missunderstood something ...
Or at least please give me some points what is the advantage of the
framebuffer in the state it exists in the official 2.6.0 if it is unusable.
Or maybe I've missed something. My only headache that I would like know
what is the goal with fb in 2.6.x then?

And again: sorry, I would not like to be offensive or something, but I'm
really interested in this topic!
 	
- Gábor (larta'H)

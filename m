Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268187AbUHFQmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268187AbUHFQmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268188AbUHFQlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:41:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:40641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268168AbUHFQjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:39:12 -0400
Date: Fri, 6 Aug 2004 09:39:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Fruhwirth Clemens <clemens@endorphin.org>,
       James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
In-Reply-To: <411353B3.B8748556@users.sourceforge.net>
Message-ID: <Pine.LNX.4.58.0408060918320.24588@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
     <1091644663.21675.51.camel@ghanima> <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
     <1091647612.24215.12.camel@ghanima> <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
   <411228FF.485E4D07@users.sourceforge.net> <Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
 <411353B3.B8748556@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Aug 2004, Jari Ruusu wrote:
> 
> Linus, you are mixing two completely different rights here;
> re-distribution right and re-licensing right.

Ehh.. You're wrong.

Copyright law has nothing to do with "licensing". In fact, if you actually 
read copyright law, you will find that the _only_ thing that it's about is 
the right to distribute a work and the right to make derived works.

(Side note: there are also certain "right of attribution" etc, but that's
still not about re-licensing and those are about the author, not the owner
of the copyright).

In other words, being the "owner" of a work has nothing to do with the
right to "relicence".

Being able to license somebody else to distribute the work does NOT 
require ownership. It only requires a _license_ to do so. You can keep 
owning your copyright, and let somebody else distribute the copy for you 
by liccensing him to do that.

And a license like the BSD license that allows very broad rights to 
_everybody_ means that pretty much everybody can not only distribute it, 
but since the BSD license doesn't even limit how they re-distribute it, 
you can distribute it with some additional requirements of your own.

Why do you think Microsoft etc can take BSD code and then slap their EULA 
on it? Right. They were given the right to distribute. 

> Original license grants
> you GPL-compatible re-distribution rights, which means that the code can
> be distributed and linked with GPL code just fine.

You clearly do not know what you're talking about.

You haven't even read the GPL, have you?

The GPL doesn't say "you can link this with a GPL-compatible license". It 
says:

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

Notice? It says "this License". Not "this license or some more permissive 
license".

The ONLY license you can use to create a GPL derivative is the GPL itself.

And the way "GPL-compatible" licenses work is _exactly_ because these 
licenses are "weaker" than the GPL, and as such can always be _relicensed_ 
as the GPL.

THAT IS WHAT GPL-COMPATIBLE MEANS!

So when you claim that the code isn't GPL-compatible, and at the same time 
claim that we can't re-license it under the GPL, you are very very 
confused indeed. Either it is GPL-compatible, or it is not. And if it is 
GPL-compatible, that ABSOLUTELY means that it can be relicensed under the 
GPL.

Comprende?

Anyway, the point is moot.  We've removed the code you touched, and I'm
about to apply the new version that is based on Gladman's code (I did the
conversion myself, and James Morris did the final stuff and the
integration with the rest of the code).

And we did that not for legal reasons, but because quite frankly, I don't 
want to have _anything_ to do with somebody as confused as you are. 

			Linus

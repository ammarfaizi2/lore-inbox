Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUGWIRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUGWIRR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 04:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267444AbUGWIRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 04:17:17 -0400
Received: from web52903.mail.yahoo.com ([206.190.39.180]:9866 "HELO
	web52903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267443AbUGWIQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 04:16:37 -0400
Message-ID: <20040723081637.93875.qmail@web52903.mail.yahoo.com>
Date: Fri, 23 Jul 2004 10:16:37 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: New dev model (was [PATCH] delete devfs)
To: Paul Jackson <pj@sgi.com>, Adrian Bunk <bunk@fs.tum.de>
Cc: akpm@osdl.org, corbet@lwn.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040722152839.019a0ca0.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Paul Jackson <pj@sgi.com> a écrit : > > There's much worth
in having a very stable kernel.
> 
> There certainly is.  But the contribution that having a
> separate 2.7/2.8
> kernel at the head (Linus, et. al.) end has to a user having a
> stable kernel
> is not what you think it is.
> 

;-)

> The direction presented to us now is having smaller, more
> continuous,
> steps in the head end, over having fewer larger, more
> disruptive steps. 
> Do we do all the incompatible changes in a big chunk, once
> every couple
> of years, or do we do them one a week, ongoing.
> 
... and break existing compatibility, and make the system crash 
twice a day ...

> Now, I repeat, this is at the head end.  End users who want
> stability
> aren't feeding directly off kernel.org anyway.
> 

Are you sure ? There are a number of distribution who use the
 stable kernel from kernel.org and some of them are much faster
(if you remember, compiling a kernel to suit your needs
 sometimes improve performance). 
One size _does not_ fit all.

> The affect downstream on real users is this.  If the head end
> operates
> in big chunky style, then as this big change flows downstream,
> it makes
> transitions for distros, service providers and middlemen more
> costly and
> difficult, creating expenses that must be passed on to the end
> user.
> 

And with new devepment model this expenses will be passed to the

end user when the kernel will not be stable enough and will
 crash. Do you you remember the 8k vs 4k stack problem for 
Nvidia binary kernel module ?

> Yes - damming up the flow of changes creates stability.  But
> if you're a
> middleman, you don't need Linus to choose where to build the
> dam, and
> when to open the flood gates.  It's more efficient for you to
> choose for
> yourself when to do that damming, based on your particular
> resources and
> customer needs, rather than have to deal with hundred year
> floods and
> draughts imposed on you by Zeus.
> 

So now the world is divided in gods (i.e distributions) and we,
mere mortals who should pray to the gods to give us a stable
 kernel ? And if we commit a sin our  machine will crash ? 

> The end user always gets their stability, if only because they
> won't
> upgrade a system that is "working".
> 

They will get the stability through the new discovered 
remote security hole because they don't upgrade their system 
because "the system is working" and they don't need to upgrade ?

> And every change at the head end is disruptive for some poor
> slob.
> The only perfectly compatible change is no change at all.  We
> delude
> ourselves if we think we can separate the "safe" fixes and
> additions
> from the "unsafe" incompatible changes.  Better that we should
> expend
> some energy on smoothing out and minimizing the cost of change
> to those
> downstream from us.  This needs to be done the old-fashioned
> way, one
> change at a time.
> 
> The question is whether we impose, on all those downstream
> from us,
> occasional hundred year floods, or do we provide a steady
> stream, and
> let them build their own little beaver dams, as suits their
> various and
> diverse needs and business cycles.
> 
> The great lesson of capitalism over communism is that a
> thousand free
> workers and investors, each optimizing their own little plot
> or
> portfolio, beats a single centrally imposed five year plan,
> even if the
> man pulling the levers is a genius such as Linus or Lenin
> (sorry, Linus,
> couldn't resist ...).
> 

You are wrong here. You never saw the two systems working.
In comunism: One size fits all. This size is made to accomodate
 80% of the population. 
In capitalism: There are two sizes: one for rich and one for 
the poor. The one for the poor is almost bullshit but is 
cheap and anybody can afford it and the one for the rich
is verry expensive and only few can afford it.
Now do a  s/poor/kernel.org kernel/ and s/rich/distribution
kernels/ and you see what your development model is.

  

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Vous manquez d’espace pour stocker vos mails ? 
Yahoo! Mail vous offre GRATUITEMENT 100 Mo !
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Le nouveau Yahoo! Messenger est arrivé ! Découvrez toutes les nouveautés pour dialoguer instantanément avec vos amis. A télécharger gratuitement sur http://fr.messenger.yahoo.com

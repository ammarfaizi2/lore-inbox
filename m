Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSK1SSM>; Thu, 28 Nov 2002 13:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSK1SSL>; Thu, 28 Nov 2002 13:18:11 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:49158 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266645AbSK1SSK>; Thu, 28 Nov 2002 13:18:10 -0500
Date: Thu, 28 Nov 2002 19:22:15 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Gerd Knorr <kraxel@bytesex.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RELEASE] module-init-tools 0.8
Message-ID: <20021128182215.GC11221@louise.pinerecords.com>
References: <200211281616.gASGGOE6012229@bytesex.org> <Pine.LNX.3.96.1021128115833.12997A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021128115833.12997A-100000@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > lsmod doesn't work at this point (hangs too, likely the same lock).
> > The deadlock prevents any further module loading (autofs, nfs and
> > others) and makes the system unusable.
> > 
> > Module debugging is next to impossible right now.  The apm.o module
> > oopses for me in 2.5.50.  ksymoops isn't able to translate any symbol
> > located in modules.  The in-kernel symbol decoder (CONFIG_KALLSYMS)
> > doesn't work too.
> 
> The new module stuff has been in for about three weeks now, many people
> are having problems with it, and I have yet to see a single post praising
> the *actual* benefits. Will there be a time when this is reverted and
> rescheduled for a future release (2.7?) or is this a do-or-die feature?
> 
> It doesn't have the feel of something solid having a few corner cases
> fixed, it feels like a bunch of band-aids which will unstick in future
> releases and continue to be high maintenence.

Also I can't see how the new module infrastructure could have made it
in w/o having been complete, *functional*, proven and thoroughly reviewed
off-tree in the first place (which I thought was pretty much a standard
around here).  Mature, drop-in replacement projects like Keith Owen's
kbuild 2.5 are getting ignored while something as wild as Rusty's "welcome
in module hell exhibit" is merged right when the tree is supposed to start
stabilizing.

And heck, I haven't even seen Viro and Hellwig complaining!
What's going on?  :)

-- 
Tomas Szepe <szepe@pinerecords.com>

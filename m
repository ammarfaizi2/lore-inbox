Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUH0SaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUH0SaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266897AbUH0SaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:30:17 -0400
Received: from jib.isi.edu ([128.9.128.193]:22662 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S264917AbUH0SaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:30:08 -0400
Date: Fri, 27 Aug 2004 11:30:04 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB patches for 2.6.9-rc1
Message-ID: <20040827183004.GB24018@isi.edu>
References: <20040826235241.GA22295@kroah.com> <20040827033709.GC1284@isi.edu> <Pine.LNX.4.58.0408262040190.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408262040190.2304@ppc970.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.26, Linus Torvalds wrote:
> On Thu, 26 Aug 2004, Craig Milo Rogers wrote:
> 
> > On 04.08.26, Greg KH wrote:
> > > Greg Kroah-Hartman:
> > >   o USB: rip out the whole pwc driver as the author wishes to have done
> > >   o USB: rip the pwc decompressor hooks out of the kernel, as they are a GPL violation
> > 
> > 	The decompressor hooks may be a Linux kernel policy violation,
> > but I challenge your contention that they are a GPL violation.
> 
> Doesn't matter. Whether they are a GPL violation is a gray area. They were
> removed because of a policy. The author then complained, and the _driver_ 
> was removed for that reason.
> 
> At no point was it a legal argument. In fact, since none of the people 
> involved were layers, you shouldn't even try to _make_ it a legal 
> arguments.

	Thank you, Linus, for making my point to Greg more clearly
than I did.  Saying that the pwc decompressor hooks were removed "as
they are a GPL violation" is a difficult statement to support, and
brings up unresolved legal issues -- exactly what I tried to say.  I'm
pleased you've clarified this issue for Greg and the rest of us.

	In concordance with Linus' policy statement above, Greg, could
you change your patch attribution to say something like "per kernel
policy", please?  If for no other reason than to reduce dissention
among future lkml archive delvers about why the pwc removal took
place?  :-)

> 
> You do legal arguments in front of a judge. Until you reach that point, 
> you do what's right. And I think Greg did what is right. 
> 
> Now, we can whine all we like about the author being childish, or about
> the fact that since it was GPL'd, the hooks can clearly legally be removed
> regardless of his wishes. That's not what this is all about.  There are 
> more important things involved.
> 
> I repeat: if somebody wants to step up as maintainer, I would certainly be
> more than happy to have a pwc driver, and I bet Greg would be too. But you
> don't just take somebody elses code against his wishes - regardless of
> whether you have the "legal right" or not.
>
> Let's put it this way: if you need to ask a lawyer whether what you do is 
> "right" or not, you are morally corrupt. Let's not go there. We don't base 
> our morality on law.
> 
> 		Linus

[My apologies to anyone who received this message in duplicate.  I
sent a shorter version of it last night, but as I never received it
back from vger and it doesn't appear in the www.uwsg.iu.edu archive,
I assume it was eaten somewhere along the way.]

					Craig Milo Rogers

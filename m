Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUH0SlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUH0SlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUH0Sjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:39:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:40074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267193AbUH0SjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:39:21 -0400
Date: Fri, 27 Aug 2004 11:38:31 -0700
From: Greg KH <greg@kroah.com>
To: Craig Milo Rogers <rogers@isi.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB patches for 2.6.9-rc1
Message-ID: <20040827183831.GA1715@kroah.com>
References: <20040826235241.GA22295@kroah.com> <20040827033709.GC1284@isi.edu> <Pine.LNX.4.58.0408262040190.2304@ppc970.osdl.org> <20040827183004.GB24018@isi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827183004.GB24018@isi.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 11:30:04AM -0700, Craig Milo Rogers wrote:
> On 04.08.26, Linus Torvalds wrote:
> > On Thu, 26 Aug 2004, Craig Milo Rogers wrote:
> > 
> > > On 04.08.26, Greg KH wrote:
> > > > Greg Kroah-Hartman:
> > > >   o USB: rip out the whole pwc driver as the author wishes to have done
> > > >   o USB: rip the pwc decompressor hooks out of the kernel, as they are a GPL violation
> > > 
> > > 	The decompressor hooks may be a Linux kernel policy violation,
> > > but I challenge your contention that they are a GPL violation.
> > 
> > Doesn't matter. Whether they are a GPL violation is a gray area. They were
> > removed because of a policy. The author then complained, and the _driver_ 
> > was removed for that reason.
> > 
> > At no point was it a legal argument. In fact, since none of the people 
> > involved were layers, you shouldn't even try to _make_ it a legal 
> > arguments.
> 
> 	Thank you, Linus, for making my point to Greg more clearly
> than I did.  Saying that the pwc decompressor hooks were removed "as
> they are a GPL violation" is a difficult statement to support, and
> brings up unresolved legal issues -- exactly what I tried to say.  I'm
> pleased you've clarified this issue for Greg and the rest of us.
> 
> 	In concordance with Linus' policy statement above, Greg, could
> you change your patch attribution to say something like "per kernel
> policy", please?  If for no other reason than to reduce dissention
> among future lkml archive delvers about why the pwc removal took
> place?  :-)

Hm, I can't do that anymore, as Linus has accepted it into his tree
already.  If he feels it's a big issue, he can edit it there.

thanks,

greg k-h

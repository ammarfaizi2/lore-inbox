Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310304AbSCBEDy>; Fri, 1 Mar 2002 23:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310306AbSCBEDo>; Fri, 1 Mar 2002 23:03:44 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42993
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310304AbSCBED3>; Fri, 1 Mar 2002 23:03:29 -0500
Date: Fri, 1 Mar 2002 20:03:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: skidley <skidley@crrstv.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre2-ac1
Message-ID: <20020302040348.GA353@matchmail.com>
Mail-Followup-To: skidley <skidley@crrstv.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020302025013.GA1600@matchmail.com> <Pine.LNX.4.43.0203012351360.1612-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0203012351360.1612-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 11:56:51PM -0400, skidley wrote:
> On Fri, 1 Mar 2002, Mike Fedyk wrote:
> 
> > On Sat, Mar 02, 2002 at 02:09:46AM +0000, Alan Cox wrote:
> > > This one is a bit more experimental. I've avoided putting too much in so
> > > we can see how the O(1) scheduler pans out.
> > > 
> > 
> > --- linux.19p2/Makefile Fri Mar  1 18:26:30 2002
> > +++ linux.19pre2-ac1/Makefile   Fri Mar  1 18:41:22 2002
> > @@ -1,7 +1,7 @@
> >  VERSION = 2
> >  PATCHLEVEL = 4
> >  SUBLEVEL = 19
> > -EXTRAVERSION = -pre2
> > +EXTRAVERSION = -pre1-ac3
> >  
> >  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> > 
> > Ehh, a little problem here. :(
> > 
> > It does apply and compile on top of pre2, but uname -r will say different.
> > 
> I just changed the Makefile here, note my signature (uname -a)
>

Yep, me too, but after the first compile. drrr.

> I was wondering about the new Machine Check Exception Option added with
> this patch. where can I get info(if there is any) on using it, re the boot option to use the Mb's it supports and any userland stuff if any.

I believe any pII or newer MB should support it, and you need to tell your
log checker to look for the new output from the kernel...

Mike

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265342AbSJXIDO>; Thu, 24 Oct 2002 04:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265344AbSJXIDO>; Thu, 24 Oct 2002 04:03:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61232 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265342AbSJXIDM>; Thu, 24 Oct 2002 04:03:12 -0400
To: Mike Galbraith <efault@gmx.de>
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
	<5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Oct 2002 02:07:32 -0600
In-Reply-To: <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
Message-ID: <m18z0os1iz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> writes:

> At 01:58 PM 10/20/2002 -0500, Thomas Molina wrote:
> >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> >
> > > At 08:17 AM 10/20/2002 -0500, Thomas Molina wrote:
> > > >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> > > >
> > > > > Greetings,
> > > > >
> > > > > I hadn't had time to build/test kernels since 2.5.8-pre3.  I now find
> > that
> > > > > loadlin doesn't work on my box any more.  Is this a known problem?  If
> > so,
> > > > > when did it quit working?  (loadlin obsolete?  other?)
> > > >
> > > >I'm carrying an open problem report from Rene Blokland on this issue.
> > > >What version of the kernel did you try?
> > >
> > > Only 2.5.42.virgin, 2.5.42-mm, 2.5.43-mm and 2.5.44.virgin.  Binary search
> > > pending.
> >
> >The report stated the problem was noted with 2.5.4x.  One of the
> >developers might want to speak up as to whether finding the exact point of
> >breakage is useful.
> 
> 2.5.32 is the breakage point here.  I hope someone _else_ can salvage loadlin :)
> 
> 
> (lions and tigers and bears - oh my GDT!)

Cool, thanks, for the confirmation.  Other people are seeing breaking a little
later.  Just to clarify.  .30 or .31 is the last version that worked and .32
does not?

If it is really the gdt I have some old patches that roughly do the
right thing, and I just need to dust them off.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265352AbSJXIZS>; Thu, 24 Oct 2002 04:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbSJXIZR>; Thu, 24 Oct 2002 04:25:17 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:46037 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265349AbSJXIZQ>;
	Thu, 24 Oct 2002 04:25:16 -0400
Message-ID: <007501c27b37$144cf240$6400a8c0@mikeg>
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Thomas Molina" <tmolina@cox.net>, <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net><5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net> <m18z0os1iz.fsf@frodo.biederman.org>
Subject: Re: loadlin with 2.5.?? kernels
Date: Thu, 24 Oct 2002 10:26:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry, I have to use this pos at work)
----- Original Message -----
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Mike Galbraith" <efault@gmx.de>
Cc: "Thomas Molina" <tmolina@cox.net>; <linux-kernel@vger.kernel.org>
Sent: Thursday, October 24, 2002 10:07 AM
Subject: Re: loadlin with 2.5.?? kernels


> Mike Galbraith <efault@gmx.de> writes:
>
> > At 01:58 PM 10/20/2002 -0500, Thomas Molina wrote:
> > >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> > >
> > > > At 08:17 AM 10/20/2002 -0500, Thomas Molina wrote:
> > > > >On Sun, 20 Oct 2002, Mike Galbraith wrote:
> > > > >
> > > > > > Greetings,
> > > > > >
> > > > > > I hadn't had time to build/test kernels since 2.5.8-pre3.  I
now find
> > > that
> > > > > > loadlin doesn't work on my box any more.  Is this a known
problem?  If
> > > so,
> > > > > > when did it quit working?  (loadlin obsolete?  other?)
> > > > >
> > > > >I'm carrying an open problem report from Rene Blokland on this
issue.
> > > > >What version of the kernel did you try?
> > > >
> > > > Only 2.5.42.virgin, 2.5.42-mm, 2.5.43-mm and 2.5.44.virgin.
Binary search
> > > > pending.
> > >
> > >The report stated the problem was noted with 2.5.4x.  One of the
> > >developers might want to speak up as to whether finding the exact
point of
> > >breakage is useful.
> >
> > 2.5.32 is the breakage point here.  I hope someone _else_ can
salvage loadlin :)
> >
> >
> > (lions and tigers and bears - oh my GDT!)
>
> Cool, thanks, for the confirmation.  Other people are seeing breaking
a little
> later.  Just to clarify.  .30 or .31 is the last version that worked
and .32
> does not?

Yes.  .31 exploded on me after boot, but did not do the violent reboot
during boot.

> If it is really the gdt I have some old patches that roughly do the
> right thing, and I just need to dust them off.

You dust them off, and I'll be more than happy to test them.  I keep
entirely too many kernels resident to want to use lilo.

(kexec/bootimg wonderfulness solves my problem too.  boot into a stable
kernel, instant reboot into any one I want.  gimme gimme gimme:)

    -Mike


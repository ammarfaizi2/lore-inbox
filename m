Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVC0Xz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVC0Xz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVC0Xz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:55:26 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:1411 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261629AbVC0XzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:55:16 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327220139.GI4285@stusta.de>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
	 <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe>
	 <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe>
	 <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe>
	 <20050327181056.GA14502@kroah.com>
	 <1111948631.27594.14.camel@localhost.localdomain>
	 <20050327220139.GI4285@stusta.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 27 Mar 2005 18:54:52 -0500
Message-Id: <1111967692.27381.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 00:01 +0200, Adrian Bunk wrote:
> On Sun, Mar 27, 2005 at 01:37:11PM -0500, Steven Rostedt wrote:
> >...
> > Wasn't this long ago proven in court that the license of headers can't
> > control the code that calls them.  IIRC, it was with X Motif and making
> > free libraries for that. So, actually it was for a free solution for a
> > non free one (the other way around).  I believe the case sided on the
> > free use. But then again the free code may have had to write their own
> > headers and only the API was free. So if you want to compile against the
> > kernel, you may need to work on rewriting the headers from scratch. Ah,
> > but what do I know?
> >...
> 
> How do you define "proven in court"?
> 
> Decided by an US judge based on US laws?
> Decided by a German judge based on German laws?
> Decided by a Chinese judge based on Chinese laws?
> ...
> 

OK, I was talking about US courts since that case was done in the US.
But this is all what I remember about reading some 10 years ago. So I
could be all wrong about what happened. I don't have any references and
I'm too busy now to look them up. So I may be just speaking out of my
ass. :-)

> If you distribute software you can be sued in every country you 
> distribute it.
> 
> E.g. Harald Welte is currently quite successful with legal actions in 
> Germany against companies that distribute Linux-based routers in Germany 
> without offering the source of the GPL'ed software they use.

Your talking about something completely different.  Yes, it is quite
explicit if you modify the source, and distribute it in binary only
form.  I'm talking about writing a separate module that links with the
GPL code dynamically.  So that the code is compiled different from the
GPL code. So the only common part is the API. Now is this a derived
work? 

As someone mentioned already, if you write your own GPL interface that
supplies the interface for your binary module, is it legal?  The GPL
interface remains GPL and delivered with the source, but the binary is
only delivered binary, and may even be on a separate CD or whatever
medium you distribute with. Just like NVidia. They have their GPL layer
that compiles with the kernel and it supplies an interface for their
binary only version.  I haven't seen anyone take them to court.  Just a
lot of complaints about incompatibilities and tainted kernels on the
mailing list, but nothing more.

-- Steve



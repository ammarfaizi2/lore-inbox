Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWHGUHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWHGUHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWHGUH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:07:29 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30377 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932339AbWHGUH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:07:29 -0400
Date: Mon, 7 Aug 2006 16:07:02 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Phillips <phillips@google.com>
cc: Dave Jones <davej@redhat.com>, Nate Diller <nate.diller@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [2/2] Add the Elevator I/O scheduler
In-Reply-To: <44D2A2C1.6030300@google.com>
Message-ID: <Pine.LNX.4.58.0608071601270.27060@gandalf.stny.rr.com>
References: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com>
 <20060803235304.GB7265@redhat.com> <44D2A2C1.6030300@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Aug 2006, Daniel Phillips wrote:

> Dave Jones wrote:
> >  > +/****************
> >  > + *
> >  > + * Advantages of the Textbook Elevator Algorithms
> >  > + *  by Hans Reiser
> >  > + *
> >  > + * In people elevators, they ensure that the elevator never changes
> >  > + * direction before it reaches the last floor in a given direction to which
> >  > + * there is a request to go to it.  A difference with people elevators is
> >  > + * that disk drives have a preferred direction due to disk spin direction
> >  > + * being fixed, and large seeks are relatively cheap, and so we (and every
> >  > + * textbook) have a one way elevator in which we go back to the beginning
> >  > > blah blah blah..
> >
> > This huge writeup would probably belong more in Documentation/
>
> Hi Dave,
>
> Surely you did not mean to characterize his documentation as blather?

No he's just pointing out that it goes on and on and on...

> It seems
> to be of very good quality, we need to encourage that level of diligence.  As
> far as moving it to Documentation goes, my immediate reaction is I sure do like
> it when the coder cares enough about my understanding of what he's doing to
> put such effort into trying to make sure I understand what he's doing and why
> he's doing it.  Having it right in the code removes a level of indirection when
> reading that might make the difference between me reading and not reading the
> documentation, which in turn might make the difference between understanding and
> not understanding the code.  Agreed it's a bit much at least all in one piece.
>
> Maybe precis the in-line documenation and move the greater literary effort to
> Documentation, with the requisite "see Documentation/" line?
>

Yes a "see Documentation/" line would be much more appropriate.

-- Steve


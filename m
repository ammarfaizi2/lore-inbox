Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbTCTU44>; Thu, 20 Mar 2003 15:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbTCTU44>; Thu, 20 Mar 2003 15:56:56 -0500
Received: from [209.195.52.120] ([209.195.52.120]:54159 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S262292AbTCTU4y>; Thu, 20 Mar 2003 15:56:54 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Date: Thu, 20 Mar 2003 13:05:41 -0800 (PST)
Subject: Re: Release of 2.4.21
In-Reply-To: <20030320205338.GG8256@gtf.org>
Message-ID: <Pine.LNX.4.44.0303201258560.18719-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hopefully we won't have a steady stream of critical bugs. if we do we need
to stop new development and find out where we are going wrong.

after all this isn't microsoft.

one advantage of useing a good version control system is that it should be
very easy to make a minor update to 2.4.20 to produce 2.4.21 without it
being a major disruption to things and then continue with the existing
development. from what I understand about bk it should make it even
easier.

I don't like going to 4 part version numbers. if this was a marketing
driven company that had promised features in 2.4.21 and they aren't ready
but a new version is needed then we would have a reason to do a 2.4.20.1
so that we don't have to deal with broken promises, but sine we aren't in
that situation I don't see why the 2.4.20.N is needed.

Every other time there has been a critical bug it was fixed in the next
normal release number (or if it's critical enough it was handled  by
rushing a version with just that fix like happened with 2.2)

David Lang


On Thu, 20 Mar 2003, Jeff Garzik wrote:

> Date: Thu, 20 Mar 2003 15:53:38 -0500
> From: Jeff Garzik <jgarzik@pobox.com>
> To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
>      marcelo@conectiva.com.br
> Subject: Re: Release of 2.4.21
>
> On Thu, Mar 20, 2003 at 08:42:18PM +0000, Christoph Hellwig wrote:
> > On Thu, Mar 20, 2003 at 03:34:07PM -0500, Jeff Garzik wrote:
> > > For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
> > > the 2.4.21-pre cycle, that would be less productive than just patching
> > > 2.4.20 and rolling a separate release off of that.
> >
> > I think the naming is illogical.  If there's a bugfix-only release
>
> Many, many companies seem to find it logical.  If you want to squeeze
> a version in between "1" and "2".
>
> Further, other kernel hackers suggested the 2.4.20.N sequence,
> I simply agreed with it.  So it's not only me who thinks this way :)
>
>
> > it whould have normal incremental numbers.  So if marcelo want's
> > it he should clone a tree of at 2.4.20, apply the essential patches
> > and bump the version number in the normal 2.4 tree to 2.4.22-pre1
>
> Human nature says that will drag out the -pre tree ad infinitum.
> Suppose a 2.4.21 is released today, with 2.4.20 + bug fixes.  Now,
> tomorrow, another "critical bug" comes out, and then the -pre tree
> becomes 2.4.23-pre.  Add another critical bug, and I hope you see
> the continual delay of -pre happens here...
>
> The basic logic is "do not disrupt current plans.  Do something
> _in addition to_ current plans."
>
> 	Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

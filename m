Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269595AbUHZUek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269595AbUHZUek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbUHZUbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:31:03 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19393 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269593AbUHZU0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:26:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.9-rc1-mm1
Date: Thu, 26 Aug 2004 22:36:13 +0200
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org>
In-Reply-To: <412E11ED.7040300@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408262236.13964.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 of August 2004 18:38, Con Kolivas wrote:
> Rafael J. Wysocki wrote:
> > On Thursday 26 of August 2004 13:07, Con Kolivas wrote:
> >>Andrew Morton wrote:
> >>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/
> >>>2 .6.9-rc1-mm1/
> >>>
> >>>
> >>>- nicksched is still here.  There has been very little feedback, except
> >>>that it seems to slow some workloads on NUMA.
> >>
> >>That's because most people aren't interested in a new cpu scheduler for
> >>2.6.
> >
> > I am, but I have no benchmarks that give any useful numbers.
>
> That's because there are none for interactivity; you're simply
> reinforcing my point.

Hm, can you tell me please what you consider as the most obvious interactivity 
issue that you expect to be improved by your scheduler?  A typical scenario 
in which the "standard" one will be "not good enough" in your opinion?

> >>The current one works well enough in most situations and people
> >>aren't trying -mm to fix their interactive problems since they are few
> >>and far between.
> >
> > Actually, with the current scheduler, updatedb really sucks.  It's
> > supposed to be a background task, but it hogs IO resources and memory
> > like crazy (disclaimer: it's my personal subjective observation).
>
> The cpu scheduler plays almost no part in this. It's the I/O scheduler
> and the vm.

I wasn't quite sure so thanks for pointing it out to me.

> IOnice will help the former _when it comes out_. Dropping
> the swappiness kind of helps the latter; although there are numerous
> alternative tweaks appearing for that too.

I know that.  It does not hurt me that much. :-)  Still, on a dual-Opteron box 
with a gig of RAM I would expect it to "behave" a bit better in the default 
configuration ...

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman

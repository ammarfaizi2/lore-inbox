Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTAXIwv>; Fri, 24 Jan 2003 03:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267609AbTAXIwv>; Fri, 24 Jan 2003 03:52:51 -0500
Received: from [209.195.52.120] ([209.195.52.120]:684 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S267608AbTAXIwu>; Fri, 24 Jan 2003 03:52:50 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Anoop J." <cs99001@nitc.ac.in>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Jan 2003 00:48:39 -0800 (PST)
Subject: Re: your mail
In-Reply-To: <54208.210.212.228.78.1043398260.webmail@mail.nitc.ac.in>
Message-ID: <Pine.LNX.4.44.0301240046580.10187-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a case of the same tuerm being used for two different
purposes. I don't know the use you are refering to.

David Lang


On Fri, 24 Jan 2003, Anoop J. wrote:

> I read that the data coherency problem due to virtual indexing is avoided
> through page coloring and it has also got the speed of physical indexing
> can u just elaborate on how this is possible?
>
>
> Thanks
>
>
>
>
> > implementing a fully associative cache eliminates the need for page
> > coloring, but it has to be implemented in hardware. if you don't have
> > fully associative caches in your hardware page coloring helps avoid the
> > worst case memory allocations.
> >
> > from what I have seen on the attempts to implement it the problem is
> > that the calculations needed to do page colored allocations end up
> > costing enough that they end up with a net loss compared to the old
> > method.
> >
> > David Lang
> >
> >
> >  On Fri, 24 Jan 2003, Anoop J.
> > wrote:
> >
> >> Date: Fri, 24 Jan 2003 11:24:24 +0530 (IST)
> >> From: Anoop J. <cs99001@nitc.ac.in>
> >> To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> >>
> >>
> >> How is this different from a fully associative cache .Would be better
> >> if u could deal it based on the address bits used
> >>
>
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRJEVJA>; Fri, 5 Oct 2001 17:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRJEVIu>; Fri, 5 Oct 2001 17:08:50 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:48082 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273881AbRJEVIi>;
	Fri, 5 Oct 2001 17:08:38 -0400
Date: Fri, 5 Oct 2001 23:09:01 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: Steve Lord <lord@sgi.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed 
In-Reply-To: <200110052043.f95KhG307514@jen.americas.sgi.com>
Message-ID: <Pine.BSI.4.10.10110052306200.303-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Steve Lord wrote:

> > On Fri, 5 Oct 2001, Rik van Riel wrote:
> > 
> > > On Fri, 5 Oct 2001, Seth Mos wrote:
> > > 
> > > > This happens using either 2.4.10-xfs or 2.4.11-pre3-xfs.
> > > 
> > > Ohh duh, IIRC there are a bunch of highmem bugs in
> > > -linus which are fixed in -ac.
> > 
> > Fitting XFS onto a -ac kernel should be fun :-(
> 
> Its not that that simple - I tried before I got dragged kicking and
> screaming back into some Irix stuff. Just running mongo on ext2 
> on a HIGHMEM ac kernel should show if things are better there - since 
> the problems seem to be fairly filesystem independent.

I don't have a HIGHMEM box without XFS filesystems. So i have to merge
both -ac and the xfs tree to test it. I can reformat the box ofcourse but
that would mean next week. If I can win a day and spare a reformat I am
willing to make that sacrifice.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJEUnt>; Fri, 5 Oct 2001 16:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRJEUnj>; Fri, 5 Oct 2001 16:43:39 -0400
Received: from zok.sgi.com ([204.94.215.101]:29660 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S273135AbRJEUn1>;
	Fri, 5 Oct 2001 16:43:27 -0400
Message-Id: <200110052043.f95KhG307514@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Seth Mos <knuffie@xs4all.nl>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed 
In-Reply-To: Message from Seth Mos <knuffie@xs4all.nl> 
   of "Fri, 05 Oct 2001 22:31:38 +0200." <Pine.BSI.4.10.10110052225300.303-100000@xs3.xs4all.nl> 
Date: Fri, 05 Oct 2001 15:43:16 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 5 Oct 2001, Rik van Riel wrote:
> 
> > On Fri, 5 Oct 2001, Seth Mos wrote:
> > 
> > > This happens using either 2.4.10-xfs or 2.4.11-pre3-xfs.
> > 
> > Ohh duh, IIRC there are a bunch of highmem bugs in
> > -linus which are fixed in -ac.
> 
> Fitting XFS onto a -ac kernel should be fun :-(

Its not that that simple - I tried before I got dragged kicking and
screaming back into some Irix stuff. Just running mongo on ext2 
on a HIGHMEM ac kernel should show if things are better there - since 
the problems seem to be fairly filesystem independent.

Steve


> 
> I will try this over the weekend or get a redhat kernel going which is
> also -ac based. That would come in handy for other people using XFS since
> a lot are using highmem in combination with this fs.
> 
> > Can you reproduce the bug with an -ac kernel ?
> 
> I am not that good/fast at patching. Expect something over the weekend :-)
> 
> Bye
> Seth



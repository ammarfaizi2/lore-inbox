Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSEWWlN>; Thu, 23 May 2002 18:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSEWWlM>; Thu, 23 May 2002 18:41:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39074 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317034AbSEWWlL>;
	Thu, 23 May 2002 18:41:11 -0400
Date: Fri, 24 May 2002 00:40:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Tomas Szepe <szepe@pinerecords.com>,
        "Gryaznova E." <grev@namesys.botik.ru>, linux-kernel@vger.kernel.org
Subject: Re: IDE problem: linux-2.5.17
Message-ID: <20020524004057.C27005@ucw.cz>
In-Reply-To: <20020523180357.GA725@louise.pinerecords.com> <Pine.LNX.4.10.10205231143390.22581-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 11:44:44AM -0700, Andre Hedrick wrote:
> 
> Not true at all.
> 
> Many of the OEM's use 40c's to do 66 and 100, just they have to be very
> high quality and about 6" in length.

Hmm, last time we were discussing you were saying that only 80 wire
cables work, and I was saying that short enough 40 wire cables are OK as
well (even in some older revision of the spec) ....

... interesting.

Anyway, 40 wire cables can really only work with a single drive and have
to be really short. And, Linux should only use UDMA33 and lower on
them, because it can't know the length of the cable.

> 
> On Thu, 23 May 2002, Tomas Szepe wrote:
> 
> > > I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel -
> > > kernel boots. Am I correct that it is not possible to have DMA
> > > on with such cable? Is there any reason for doing that?
> > 
> > 40-conductor IDE cables are capable of transfering data
> > in DMA modes up to udma2, but no faster.
> > 
> > T.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs

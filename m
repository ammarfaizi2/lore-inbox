Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSF1SbB>; Fri, 28 Jun 2002 14:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSF1SbA>; Fri, 28 Jun 2002 14:31:00 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:50948
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316952AbSF1Sa6>; Fri, 28 Jun 2002 14:30:58 -0400
Date: Fri, 28 Jun 2002 11:33:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Status of write barrier support for 2.4?
In-Reply-To: <20020628202053.C777@suse.de>
Message-ID: <Pine.LNX.4.10.10206281127040.2888-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002, Jens Axboe wrote:

> On Fri, Jun 28 2002, Andre Hedrick wrote:
> > 
> > Jens,
> > 
> > I just got crapped all over trying to get us "write barrier" opcodes :-/.
> > However I do have the start of a draft to submit soon.  I could not piggy
> > back of FUA by MicroSoft last week.
> 
> Basic FUA bit for WRITE command would be good, as long as it also
> prevents reordering of the writes currently in write cache. I don't
> think mmc makes any such guarentee, although I would have to check to be
> sure.

Well that is the fuzzy part!

It bypasses the write cache thus "write barrier" is not doable!
In tag, it does not nuke the tags outstanding, it just blows threw the
queue and plunges the meta-data to platter.

Basically worthless unless one is dealing with data-base only.


> > So how did the talk go at OLS for the IDE roadmap to destruction go?
> > I could not attend, as I was doing other stuff associated with the
> > industry.
> 
> I don't think there was such a talk?! If so, I didn't attend.

Oh, there was one scheduled but no speakers showed up,

http://www.uzix.org/img_0861.jpg

I was in Irvine during that time for a NCITS meeting thus I cancelled
early thus the name replacement.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


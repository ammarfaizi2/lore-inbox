Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280494AbRKTDG4>; Mon, 19 Nov 2001 22:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280819AbRKTDGr>; Mon, 19 Nov 2001 22:06:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52071 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280494AbRKTDGd>; Mon, 19 Nov 2001 22:06:33 -0500
To: James A Sutherland <jas88@cam.ac.uk>
Cc: Erik Gustavsson <cyrano@algonet.se>, linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <1006124602.3890.0.camel@bettan>
	<m1snba7hpw.fsf@frodo.biederman.org>
	<E165tpy-0002Dm-00@mauve.csi.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 19:47:36 -0700
In-Reply-To: <E165tpy-0002Dm-00@mauve.csi.cam.ac.uk>
Message-ID: <m1ofly6tvb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James A Sutherland <jas88@cam.ac.uk> writes:

> On Monday 19 November 2001 6:12 pm, Eric W. Biederman wrote:
> > Erik Gustavsson <cyrano@algonet.se> writes:
> > > I agree...   After a while it always seems that 80% or more of my RAM is
> > > used for cache and buffers while my open, but not currently used apps
> > > get pushed onto disk. Then when I decide to switch to that mozilla
> > > window of emacs session I have to wait for it to be loaded from disk
> > > again. Also considering the kind of disk activity this box has, the data
> > > in the cache is mostly the last few hour's MP3's, in other words utterly
> > > useless as that data will not be used again. I'd rather my apps stayed
> > > in RAM...
> > >
> > >
> > > Is there a way to limit the size of the cache?
> >
> > Reasonable.  It looks like the use once heuristics are failing for your
> > mp3 files.   Find out why that is happening and they should push the
> > rest of your system into swap.
> 
> Getting clobbered by the mp3 player accessing the ID3 tag? That way, at least 
> part of the file is used twice, so use-ONCE won't matter...

For that page perhaps.  But that is only 4K.  That doesn't explain the rest
of it.  use-once is per page.

Eric

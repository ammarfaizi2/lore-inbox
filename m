Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280628AbRKSTMh>; Mon, 19 Nov 2001 14:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280629AbRKSTM2>; Mon, 19 Nov 2001 14:12:28 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:18145 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280628AbRKSTMP>; Mon, 19 Nov 2001 14:12:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: ebiederm@xmission.com (Eric W. Biederman),
        Erik Gustavsson <cyrano@algonet.se>
Subject: Re: Swap
Date: Mon, 19 Nov 2001 19:12:15 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <1006124602.3890.0.camel@bettan> <m1snba7hpw.fsf@frodo.biederman.org>
In-Reply-To: <m1snba7hpw.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165tpy-0002Dm-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 6:12 pm, Eric W. Biederman wrote:
> Erik Gustavsson <cyrano@algonet.se> writes:
> > I agree...   After a while it always seems that 80% or more of my RAM is
> > used for cache and buffers while my open, but not currently used apps
> > get pushed onto disk. Then when I decide to switch to that mozilla
> > window of emacs session I have to wait for it to be loaded from disk
> > again. Also considering the kind of disk activity this box has, the data
> > in the cache is mostly the last few hour's MP3's, in other words utterly
> > useless as that data will not be used again. I'd rather my apps stayed
> > in RAM...
> >
> >
> > Is there a way to limit the size of the cache?
>
> Reasonable.  It looks like the use once heuristics are failing for your
> mp3 files.   Find out why that is happening and they should push the
> rest of your system into swap.

Getting clobbered by the mp3 player accessing the ID3 tag? That way, at least 
part of the file is used twice, so use-ONCE won't matter...


James.

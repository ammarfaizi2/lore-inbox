Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129267AbQK3MUr>; Thu, 30 Nov 2000 07:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129340AbQK3MUh>; Thu, 30 Nov 2000 07:20:37 -0500
Received: from odo.scot.redhat.com ([195.89.149.241]:55534 "EHLO
        spock.scot.redhat.com") by vger.kernel.org with ESMTP
        id <S129267AbQK3MUZ>; Thu, 30 Nov 2000 07:20:25 -0500
Date: Thu, 30 Nov 2000 11:47:08 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: John Kennedy <jk@csuchico.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <20001130114708.A1341@redhat.com>
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi> <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva> <20001124152831.A5696@valinux.com> <20001125145701.A12719@athlon.random> <20001128150235.A7323@north.csuchico.edu> <20001129002009.I14675@athlon.random> <20001128153615.E7323@north.csuchico.edu> <20001129010416.J14675@athlon.random> <20001128163532.F7323@north.csuchico.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001128163532.F7323@north.csuchico.edu>; from jk@csuchico.edu on Tue, Nov 28, 2000 at 04:35:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 28, 2000 at 04:35:32PM -0800, John Kennedy wrote:
> On Wed, Nov 29, 2000 at 01:04:16AM +0100, Andrea Arcangeli wrote:
> > On Tue, Nov 28, 2000 at 03:36:15PM -0800, John Kennedy wrote:
> > >   No, it is all ext3fs stuff that is touching the same areas your
> > 
> > Ok this now makes sense. I ported VM-global-7 on top of ext3 right now
> > but it's untested:
> 
>   Not for long.  (:
> 
> >  ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre18/VM-global-2.2.18pre18-7-against-ext3-0.0.3b-1.bz2
> 
>   Is ext3-0.0.3b the most current/stable?

Yes.  0.0.5b is out with metadata-only journaling, but it hasn't had
the same amount of testing which 3b has had.

> ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs at least) it looks like
> ext3-0.0.2f is current (which is what I've been using), but under the
> test directory I see ext3-0.0.3b as well as ext3-0.0.5b.  I haven't
> heard anything new about ext3fs in a long, long time.

linux-fsdevel has had a fair amount of traffic on it, and there's also
ext3-users@redhat.com (https://listman.redhat.com to subscribe).  You
won't have seen much if you've only been watching linux-kernel.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

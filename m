Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273925AbRIRVFV>; Tue, 18 Sep 2001 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273926AbRIRVFP>; Tue, 18 Sep 2001 17:05:15 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:208 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S273925AbRIRVE7>; Tue, 18 Sep 2001 17:04:59 -0400
Date: Tue, 18 Sep 2001 15:06:19 -0600
Message-Id: <200109182106.f8IL6Js14650@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.GSO.4.21.0109181648001.27538-100000@weyl.math.psu.edu>
In-Reply-To: <200109182033.f8IKXPZ14069@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0109181648001.27538-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Tue, 18 Sep 2001, Richard Gooch wrote:
> 
> > Alexander Viro writes:
> > > "I can't be arsed to split my K'R4D 3133t 200Kb p47cH" had lost its
> > > charm years ago - just look at the devfs mess...
> > 
> > Al, are you ever going to stop bitching and moaning about devfs?
> > If you have a specific, technical, reasoned complaint to make, do it
> > coherently. Otherwise, stop sniping.
> 
> What?  I'm saying that devfs was a huge patch which was not understood
> (let alone audited) by anyone except you when it was included and as
> the direct result we have a long history of problems in that area.
> You want to argue against that?
> 
> If you still feel that feeding devfs into the tree in one huge chunk
> was not a mistake - you are much dumber than I thought.

Actually, many times I fed Linus smaller patches. I tried to get the
FS core itself in separately from the drivers, which was 100% safe
(since no existing code was touched), but he wasn't interested. If the
devfs core *had* been accepted on it's own, I could then have
reasonably split up the driver patches.

However, I disagree with your "long history of problems" comment. You
make it sound like devfs hasn't performed reliably, whereas in real
life (i.e. normal use, not constructed exploits) it's done quite well.

In any case, if your "I can't be arsed to split my patch" comment is
directed at me, I take offense. I did actually take the trouble to
split up my patch.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

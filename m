Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285473AbRL2UbE>; Sat, 29 Dec 2001 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRL2Uay>; Sat, 29 Dec 2001 15:30:54 -0500
Received: from waste.org ([209.173.204.2]:45010 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285475AbRL2Uaj>;
	Sat, 29 Dec 2001 15:30:39 -0500
Date: Sat, 29 Dec 2001 14:30:36 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229120451.E19306@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0112291410080.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> On Sat, Dec 29, 2001 at 01:58:21PM -0600, Oliver Xymoron wrote:
> > On Sat, 29 Dec 2001, Larry McVoy wrote:
> >
> > > [patchbot stuff]
> >
> > > If you have N people trying to patch the same file, you'll require N
> > > releases and some poor shlep is going to have to resubmit their patch
> > > N-1 times before it gets in.
> >
> > The point is to have N patches queued against rev x that apply cleanly
>
> And my point is that your N is likely to be quite small out of a possible
> set that is quite large.

Nonsense. X is a release. At a minimum, a submitted patch should apply to
the current globally visible kernel release. If you want your patch to
go in, it has to be current, otherwise no use bothering the
maintainer. And it ought to compile. Anything else should be bounced
without further consideration. If the release gets bumped in a way that
breaks everything in the queue, then everything in the queue goes back to
the drawing board.

> If I'm right, then the patchbot idea is pointless because all the
> interesting work is happening in the part of the set that the patchbot
> can't handle.

The purpose of the patchbot is to bounce patches that don't
apply/compile/meet whatever baseline before Maintainer ever has to look at
them, thus reducing the 'black hole effect' of the overloaded maintainer.

The patchbot doesn't try to do any merging, it simply says "here are the
qualifying candidates for merging with the current release".

In answer to your (still orthogonal) question about how parallel
development is, my impression at least is that the answer is 'very'.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


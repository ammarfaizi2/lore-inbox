Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287271AbRL2X7s>; Sat, 29 Dec 2001 18:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287285AbRL2X7a>; Sat, 29 Dec 2001 18:59:30 -0500
Received: from waste.org ([209.173.204.2]:27864 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287275AbRL2X7S>;
	Sat, 29 Dec 2001 18:59:18 -0500
Date: Sat, 29 Dec 2001 17:59:15 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229153518.B21760@work.bitmover.com>
Message-ID: <Pine.LNX.4.43.0112291739140.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> On Sat, Dec 29, 2001 at 05:29:52PM -0600, Oliver Xymoron wrote:
> > > Is it really true that there are any significant number of patches
> > > submitted that don't even compile?
> >
> > No
>
> OK, so there are no significant numbers of patches that the patchbot will
> eliminate, by your admission.

Except for the ones that get garbage collected after each new kernel
release WHEN THE VALIDITY OF THE QUEUE IS RECHECKED. Which will catch all
the duplicates or conflicts that were queued but not applied. See original
pseudo-code (which happened to be Python). And filtering by checking for
apply/compile was only half of the original suggestion.

> So what's the point?  What is the problem you have solved?  And where's
> the code?  This sounds like you have whittled it down to a cgi-script of
> about 100 lines of perl.  How about building it and demonstrating the
> usefulness rather than telling us how great it is going to be?

The original suggestion (about the possibility of compile-testing patches
incrementally) was dependent on kbuild and CML2 being in the kernel
already, but I do have a proof-of-concept for the rest in the works.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291754AbSBHTZe>; Fri, 8 Feb 2002 14:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291756AbSBHTZY>; Fri, 8 Feb 2002 14:25:24 -0500
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:33801 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S291754AbSBHTZL>;
	Fri, 8 Feb 2002 14:25:11 -0500
Date: Fri, 8 Feb 2002 13:26:27 -0600 (CST)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
In-Reply-To: <Pine.LNX.4.33.0202081203020.29252-100000@coffee.psychology.mcmaster.ca>
Message-ID: <20020208125434.P8228-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Mark Hahn wrote:

> > I can't argue that this fixes anything, it just gives proc a more
> > safety-scissors-like interface. The consequences of not having this check
>
> exactly why people oppose it: the kernel must be as sharp as possible.
> it should oops with a useful backtrace when a duplicate proc entry is attempted.
>

I'm on your side, really ;)

Currently, the kernel does not oops, produce a backtrace or anything for
this case. It doesn't really even fail in the normal sense, it just allows
something inconsistent to filesystems in general to happen without
indicating an error. What I have concluded from this is that proc is no
general filesystem, so there is no reason to treat it as such.

I can't argue that two birds in a bush are worth more than a bird in the
hand, the same as I can't argue that a check for an error is worth more
than the absence of that error.

I was really more interested in what its like to submit a kernel patch
than anything else (hmmph! tourists!) Thanks, it has been enlightening.

 - Brent



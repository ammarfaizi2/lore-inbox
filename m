Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290850AbSBLJJt>; Tue, 12 Feb 2002 04:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290839AbSBLJJT>; Tue, 12 Feb 2002 04:09:19 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:37130 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290862AbSBLJI7>;
	Tue, 12 Feb 2002 04:08:59 -0500
Date: Mon, 11 Feb 2002 21:25:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020211202527.GC1614@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211070009.S28640@work.bitmover.com>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But as I understand your weave method, its not even linear as a
> > function of version size, its a function of _archive size_.  The
> > archive is the sum of the versions woven together, and that means your
> > operation is really O(N+A) = O(A).
> 
> The statement was "extracting *any* version of the file takes constant
> time, regardless of which version".  It's a correct statement and 

So, you are saying that you can extract *any* version of any file
within second?

Certainly not. [Take sufficiently big file...]

If you are saying that speed of getting any file does not depend on
which version you want, that is pretty different statement.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

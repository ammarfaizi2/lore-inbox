Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289895AbSAWQ3Y>; Wed, 23 Jan 2002 11:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289902AbSAWQ3O>; Wed, 23 Jan 2002 11:29:14 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:9159 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S289895AbSAWQ3B>; Wed, 23 Jan 2002 11:29:01 -0500
Date: Wed, 23 Jan 2002 11:30:11 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <emacs-devel@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: reading a file in emacs crashes 2.4.17 and 18-pre4
In-Reply-To: <Pine.LNX.4.40.0201230644480.3823-100000@ccs.covici.com>
Message-ID: <Pine.LNX.4.33.0201231124590.24338-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I reconfigured my kernel to lie to it and say k6 for the processor
> family instead of k7.

right.  and just for posterity, let me note here that 
the K7-specific kernel code IS NOT KNOWN TO BE BUGGY.

the best and so far only explanation is that since CONFIG_MK7 
can *triple* the bandwidth that Linux demands of dram, 
marginal hardware is pushed over the edge.  stable hardware
has no problem with the code, and the code follows AMD's specs.

turning off the optimizations is just de-tuning the kernel
to pander to (work around) flakey hardware.

> > > Well, I have worked around this problem by getting rid of the Athlon
> > > optimizations so I guess there is still more work to do on those.
> >
> > Could you please tell what did you change, exactly?  It might be that
> > this information should be in etc/PROBLEMS, in case other users bump into
> > the same problem.


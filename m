Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131234AbRAaQwh>; Wed, 31 Jan 2001 11:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbRAaQw0>; Wed, 31 Jan 2001 11:52:26 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:18956 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S131234AbRAaQwN>; Wed, 31 Jan 2001 11:52:13 -0500
Date: Wed, 31 Jan 2001 16:52:09 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: Mohit Aron <aron@cs.rice.edu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gprof cannot profile multi-threaded programs
In-Reply-To: <200101310727.BAA14161@cs.rice.edu>
Message-ID: <Pine.LNX.4.21.0101311648460.25748-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Mohit Aron wrote:

> 
> > http://opensource.corel.com/cprof.html
> > 
> > I haven't used it yet, myself.
> > 
> 
> I have. cprof is no good - extremely slow and generates a 100MB trace
> even with a simple hello world program.
> 

try the (currently rather alpha) oprofile, this will generate profile
info perfectly well :

http://oprofile.sourceforge.net/

(note: use CVS version, NOT the available tarball - and you might
want to wait a while for some pending updates).

I suppose further discussion should go to linuxperf@nl.linux.org or
oprofile-list@lists.sourceforge.net

thanks
john

-- 
"Existence of programs that do the impossible is 
 not a proof that that "impossible" is now possible."
	- Tigran Aivazian 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSAIPGx>; Wed, 9 Jan 2002 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287002AbSAIPGo>; Wed, 9 Jan 2002 10:06:44 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:46863 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S286968AbSAIPG1>; Wed, 9 Jan 2002 10:06:27 -0500
Date: Wed, 9 Jan 2002 09:06:22 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201091506.JAA16825@tomcat.admin.navo.hpc.mil>
To: lkml@andyjeffries.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Difficulties in interoperating with Windows
In-Reply-To: <20020109093752.31ae1e79.lkml@andyjeffries.co.uk>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> IANAL, but I wondered why there is such difficulty with making Linux work
> completely with Windows systems?  I guess part of it may be that Windows
> is closed source but as reverse engineering for interoperability is legal
> in the UK (regardless of what the End User License states), is the problem
> that it is difficult to read the Assembly easily?

That is not reverse engineering - (at least not MY understanding) - you are
re-translating a copyrighted work. If the translation back into the binary
form creates the same binary then you have an exact translation. You also
have a lawsuit pending. Otherwise you could just disassemble the entire
windows OS, claim it as your "re-engineered source", and sell/publish it.

This is not legal in most locations.

Reverse engineering is taking the published specifications, creating software
that should function in an equivalent manner. Testing it is difficult since
you have to be careful not to import patented/copyrighted algorithms. You have
to compair the inputs/outputs for the software with the inputs/outputs of the
original.

The end result is usable. Linux itself can be considered a reversed engineered
UNIX.

At least a sufficient amount of the specifications are available.

The problem with most M$ software is that the published specifications are not
complete, access to the inputs are not always available (it is ALSO covered
by the proprietary/trade secrets/other restrictions). Sometimes the output
is not available (at least in some countries - DMCA again).

This is also the problem with some device interfaces. If the company claims
"trade secret" or "propriatary information" then the published specifications
will not be usable when reverse engineering device drivers. This problem has
been attacked in the past as "it SHOULD work like this, if I can find a 
register that looks like what I expect, then it MIGHT work"... Some IDE
controllers were originally developed this way - at least one video board
was done this way. (I think even a PCI bridge was deciphered this way)

> Is there not a project on Linux to convert assembly back to C?   Would
> this be exceptionally hard?

Not hard - just illegal when using it to disassemble proprietary software.
Debuggers do this very frequently, to the point that I would say "all the
time" except for debuggers of interpreted languages.

> Just wondered why Linux has struggled for a while to interoperate with
> Windows completely...
> 
> Cheers,
> 
> 
> -- 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

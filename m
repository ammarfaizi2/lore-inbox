Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTLEG6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 01:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLEG6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 01:58:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:29863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263891AbTLEG6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 01:58:20 -0500
Date: Thu, 4 Dec 2003 22:58:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Schwartz <davids@webmaster.com>
cc: Valdis.Kletnieks@vt.edu, Peter Chubb <peter@chubb.wattle.id.au>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause? 
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.58.0312042245350.9125@home.osdl.org>
References: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, David Schwartz wrote:
>
> The GPL gives you the unrestricted right to *use* the original work.
> This implicitly includes the right to peform any step necessary to use
> the work.

No it doesn't.

Your logic is fundamentally flawed, and/or your reading skills are
deficient.

The GPL expressly states that the license does not restrict the act of
"running the Program" in any way, and yes, in that sense you may "use" the
program in whatever way you want.

But that "use" is clearly limited to running the resultant program. It
very much does NOT say that you can "use the header files in any way you
want, including building non-GPL'd programs with them".

In fact, it very much says the reverse. If you use the source code to
build a new program, the GPL _explicitly_ says that that new program has
to be GPL'd too.

> Please tell me how you use a kernel header file, other than by including
> it in a code file, compiling that code file, and executing the result.

You are a weasel, and you are trying to make the world look the way you
want it to, rather than the way it _is_.

You use the word "use" in a sense that is not compatible with the GPL. You
claim that the GPL says that you can "use the program any way you want",
but that is simply not accurate or even _close_ to accurate. Go back and
read the GPL again. It says:

	"The act of running the Program is not restricted"

and it very much does NOT say

	"The act of using parts of the source code of the Program is not
	 restricted"

In short: you do _NOT_ have the right to use a kernel header file (or any
other part of the kernel sources), unless that use results in a GPL'd
program.

What you _do_ have the right is to _run_ the kernel any way you please
(this is the part you would like to redefine as "use the source code",
but that definition simply isn't allowed by the license, however much you
protest to the contrary).

So you can run the kernel and create non-GPL'd programs while running it
to your hearts content. You can use it to control a nuclear submarine, and
that's totally outside the scope of the license (but if you do, please
note that the license does not imply any kind of warranty or similar).

BUT YOU CAN NOT USE THE KERNEL HEADER FILES TO CREATE NON-GPL'D BINARIES.

Comprende?

		Linus

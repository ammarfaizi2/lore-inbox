Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUAARaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUAARaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:30:15 -0500
Received: from aragorn.imf.au.dk ([130.225.20.4]:30665 "EHLO aragorn.imf.au.dk")
	by vger.kernel.org with ESMTP id S264510AbUAARaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:30:10 -0500
Date: Thu, 1 Jan 2004 18:30:06 +0100 (MET)
From: Anders Skovsted Buch <abuch@imf.au.dk>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: System lockup when playing chess
In-Reply-To: <20040101155652.GB27217@hh.idb.hist.no>
Message-ID: <Pine.HPP.3.95.1040101181935.21203A-100000@aragorn.imf.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jan 2004, Helge Hafting wrote:
> On Thu, Jan 01, 2004 at 02:31:58PM +0100, Anders Skovsted Buch wrote:
> > Hello,
> > 
> > I am experiencing consistent lockups of the linux kernel when I play chess
> > with crafty.  What happens is that while the chess engine is running,
> > suddenly the whole system will freeze, and the only think I can get to
> > work is the reboot button.  I have tried to put the computer in text-mode
> > (telinit 3) and run the chess program (with gui) from another computer on
> > my LAN, to see if any oops-output would show up, but there is nothing.
> > 
> > My system runs Redhat 7.2 and is uptodate with patches (so I'm running
> > kernel version 2.4.20-24.7 #1, athlon version).  The chess program is
> > Crafty 17.9.  The processor is "AMD Athlon(tm) 4 Processor".
> > /var/log/messages shows nothing of interest.
> > 
> > I wonder if this scarse information is good for anything.  And in any
> > case, thanks for all your great work which I benefit from every day!!
> > 
> Could this be a simple overheating problem?
> Chess programs are cpu intensive, and so the cpu gets hot.
> Perhaps there is insufficient cooling. the cooling may be
> enough for non-cpu intensive stuff like email, web, and so on.
> what happens if you run a big compile or a long-lasting
> cpu benchmark?  Those things also cause heat.

Thanks for your reply!  I have had math programs running for several days
in the past and never experienced any lockups, so I doubt that overheating
is the problem.  To make sure, I just did "while true; make clean; make; 
done" to the linux kernel in a couple of windows, unpacking / deleting in
another, math programs, etc. for a while, without any problems.  (CPU
usage was > 99%.)

In the first message I forgot to say that ping from another computer gives
nothing when the frozen one is frozen.

Also, please cc abuch@imf.au.dk (as you did, thanks!) since I'm not on the
lkml.

Anders



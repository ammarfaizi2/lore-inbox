Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290231AbSAOSUH>; Tue, 15 Jan 2002 13:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290240AbSAOST6>; Tue, 15 Jan 2002 13:19:58 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:7180 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S290232AbSAOSTk>; Tue, 15 Jan 2002 13:19:40 -0500
Date: Tue, 15 Jan 2002 19:19:38 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
In-Reply-To: <1011114263.1145.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201151910530.11441-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2002, Thomas Duffy wrote:

> On Tue, 2002-01-15 at 04:29, Andrew Pimlott wrote:
> 
> > - Building from source is good karma.
> > 
> > You might think these are trifles and < 1% cases.  My intuition
> > tells me that they add up in the long run.  At least it's worth
> > considering.
> 
> - Someday, a stupid government or court decides that there is a strict
> separation between source and binary.  Source is protected speech, but
> binaries are not.  Linux decides it wants a really fast DVD decryption
> in the kernel, so it adds it in drivers.  But now, distro's cannot
> compile and distribute a binary kernel package and the end user will
> need to compile the source code in order to watch their DVD.
> 
> Why is it unrealistic for everybody to compile their kernel when they do
> an install?  If it is rather automated, then it just becomes another
> step on the progress bar.

Every distro supplies a package with the source used to build their own
kernel. Just recomplile it. You can do it today. Yes, it takes longer
than building an autoconfigured kernel, since you're compiling a lot
of unused stuff. Yet the autoconfigurator belongs to the 'Kernel compiling
sybsystem' of that distribution. Don't forget that vanilla kernels can
even be incompatible with the one provided by the distro maker.

Doing it at install time is somewhat unrelated (it's even more distro-
dependant).

> 
> -tduffy
> 

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


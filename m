Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289901AbSAOOvY>; Tue, 15 Jan 2002 09:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289881AbSAOOvI>; Tue, 15 Jan 2002 09:51:08 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:34056 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S289840AbSAOOuy>; Tue, 15 Jan 2002 09:50:54 -0500
Date: Tue, 15 Jan 2002 15:50:48 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Giacomo Catenazzi <cate@debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery
 --the elegant solution)
In-Reply-To: <3C442BDB.7010008@debian.org>
Message-ID: <Pine.LNX.4.33.0201151517550.11441-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Giacomo Catenazzi wrote:

> 
> 
> Marco Colombo wrote:
> 
>  
> > Alan, Eric (and others, too), please.
> > Of course the autoconfigurator is an useful piece of software.
> > And of course Eric is posting to the wrong list here. Kernel developers
> > don't need any autoconfigurator at all (yes, it's just "extra state").
> 
> 
> The main discussion was in kbuild-devel list.

Uh, my mailbox hurts just at the thought of even more posting on the suject.

> > Eric, Aunt Tillie doesn't need any custom-made, untested, probably not
> > working kernel. QA comes at a price. The lastest VM fix may take a while
> > to reach mainstream kernels. That's life.
> 
> Maybe this force kernel maintainer to merge the tested and trusted
> distribution patches into the main kernel's branches.

Which means, in Alan's (and Yoda's) words, even more perturbations of the
Source. I don't really like the idea of kernel maintainers forced into
anything...

Kernel tarballs are for hackers. Marcelo can't test any configuration
the autoconfigurator can produce. So basically it means an untested
kernel. Running untested kernel isn't a job for Joe User, and never
will be.

Some distro vendor may be interested in an easy, do-it-yourself kernel
compilation & customization tool. It brings almost nothing to kernel
developers.

Vendors and kernel developers have different goals. That horrible hack
that fixes some bug or misbehavior fits fine into a vendor kernel, and
has no place in Marcelo's tree; the same for that C++ written, cross OS
crap driver for hardware XYZ. Users want it, vendors provide it.
Different goals, different targets.

> Anyway, the target of Linux changes. If was a toy for hacker 10 year
> ago, maybe in future will be the toy for Aunt Tillies. So:
> Forget aunts and the other scenarios of Eric.
> Let talk about what autoconfigure can do yet (aka the creation of
> a /proc/drivers (better in /dev) with a list of all running
> kernel drivers. aka how the modules will be in the next months)

Creating .config (or whatever) is an userland issue, IMHO. /proc/driver
and the like is another issue, as it can be useful in general. 

Autoconfiguration is nice. But please move the topic elsewhere.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


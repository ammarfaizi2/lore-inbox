Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUCOCKW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 21:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUCOCKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 21:10:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:47244 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261926AbUCOCKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 21:10:19 -0500
Date: Sun, 14 Mar 2004 18:10:09 -0800
From: Greg KH <greg@kroah.com>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: linux-kernel@vger.kernel.org, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040315021009.GA18106@kroah.com>
References: <1AC79F16F5C5284499BB9591B33D6F000B630B@orsmsx408.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1AC79F16F5C5284499BB9591B33D6F000B630B@orsmsx408.jf.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 07:46:12PM -0800, Woodruff, Robert J wrote:
> On Sat, Mar 13, 2004 at 02:07:13PM -0800, Greg KH wrote:
> >I think you need to work with the openib.org people as they seem to
> >have:
> >	- working code with support for a number of different devices
> I have code that has been running MPI NBPs, Pallas benchmark, and IPoIB
> stress tests for almost 10 days now on multiple vendors equipment. We
> are also close to having a major data base vendor's DAPL stress test
> running very well.  I'm thinkin this code could be running 1000 nodes
> clusters within a couple of months, if people wanted to try it, but
> that would require Mellanox to open source their TVPD. 

Hm, without open source drivers, the Intel stack doesn't seem very
viable, correct?

> >	- developers with extensive kernel programming experience
> As if we don't. 

Former kernel subsystem maintainers?  I did not realize that.

> >	  working on cleaning up the code to fit properly into the
> >	  kernel tree.
> The comments you have given on IBAL would probably only take a few weeks
> to change.

Is that work already underway?  Finished?  If neither, why not?

> >	- their code showing up in at least one distro which will expose
> >	  them to a much wider range of testing than Intel's project so
> >	  far has had.
> Ok, the OEMS pushed for and got a distro to accept a TTM solution,
> that's OK for getting InfiniBand jumpstarted, but does that mean we
> have to accept it into Linux and live with that solution forever. 

We constantly change the kernel.  Look at the USB stack.  It has been
rewritten completely almost 3 times now.  Did anyone really notice
besides the wonderful speed improvements?  :)

We never have to "live with a solution forever."

> I guess I just wish they had started working with us on this open source
> project 2 years ago when we started it, rather than developing a
> complete stack behind closed doors and then releasing it without any
> input from anyone.

There have been numerous closed source IB stacks for Linux.  Just like
there were numerous Bluetooth stacks for Linux in the past.  Over time
the closed ones are weeded out as everyone relies on the in-kernel one.

> Now there are serious issues that will take a lot of work to fix.

What are the issues with the OpenIB stack?  If there are any, how does
the Intel stack solve those issues?  Could the Intel solutions be merged
into the OpenIB stack to solve these issues?

> At least our project was totally open from the start and anyone could
> have provided input at any time. 

I understand your frustrations, I've been there before.

Good luck,

greg k-h

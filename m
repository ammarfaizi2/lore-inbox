Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWEEEu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWEEEu5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWEEEu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 00:50:57 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:3855 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750911AbWEEEu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 00:50:56 -0400
Date: Fri, 5 May 2006 06:50:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.14
Message-ID: <20060505045003.GD11191@w.ods.org>
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051152.39693.ncunningham@cyclades.com> <20060505023353.GA24291@moss.sous-sol.org> <200605051303.37130.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051303.37130.ncunningham@cyclades.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Fri, May 05, 2006 at 01:03:31PM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 05 May 2006 12:33, Chris Wright wrote:
> > * Nigel Cunningham (ncunningham@cyclades.com) wrote:
> > > Is this supposed to be some sort of subtle pressure on Linus to open 2.7?
> > > :>
> >
> > He does every couple months and leaves it open for a few weeks.
> > Then, just to keep us guessing, he releases it with a 2.6 name ;-)
> >
> > Actually, I think the system is working quite well.  We've got a quick
> > route for getting bug fixes and security fixes to users, and a shorter
> > devel cycle helping distro folks get more regular drops from upstream.
> > This particular patch applies all the way back to the beginning of git
> > time (over a year ago), and I'm sure earlier.  So it's hard to conclude
> > it's a byproduct of the release cycles.
> 
> :) Tongue was firmly in cheek. I guess I should have said more initially. It 
> wasn't so much the patch, as the speed with which they're coming. It makes me 
> (at least) feel like the stable series is unstable. Couldn't you store them 
> up for a day or two at a time (unless of course they really are that 
> important that they require a quicker cycle).

I don't agree with your analysis at all. Quite the opposite in fact. I'm
amazed that Chris & Greg manage to update so often. Right now, you can be
confident that there's always an *official* kernel version which fixes a
few days-old vulnerability. I'd like to be that fast to provide 2.4 hotfixes
(I still have one fix pending).

The enormous advantage of releasing lots of small updates is that people
just have to choose when they want to update. If you're not affected by
the SMB vulnerability, don't upgrade. That's that simple. It makes it
much easier to class bug reports (eg: the last one on speedstep which
"appeared" in 2.6.16.13 and not 2.6.16.12 while no such code has changed).
Sometimes, a config option will have changed on the user side, or a gcc
update will have been performed which might explain a new bug which we
can be certain does not come from the source.

What might be interesting with this release cycle would be to work on
hot-patching. There has already been such things in the past with modules
which patched some functions. It would avoid a full compile and a reboot
in some circumstances.

That said, kudos to Chris and Greg for their excellent work ! Please
don't change.

> Regards,
> 
> Nigel

Regards,
Willy


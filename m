Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVDHL6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVDHL6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVDHL6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:58:09 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:57281 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261689AbVDHL5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:57:51 -0400
X-ME-UUID: 20050408115750283.4519A1C00192@mwinf0502.wanadoo.fr
Date: Fri, 8 Apr 2005 13:53:43 +0200
To: Adrian Bunk <bunk@stusta.de>, Josselin Mouette <joss@debian.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408115343.GB17904@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404190518.GA17087@wonderland.linux.it> <20050404193204.GD4087@stusta.de> <1112709907.30856.17.camel@silicium.ccc.cea.fr> <20050407210722.GC4325@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050407210722.GC4325@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:07:23PM +0200, Adrian Bunk wrote:
> On Tue, Apr 05, 2005 at 04:05:07PM +0200, Josselin Mouette wrote:
> > Le lundi 04 avril 2005 à 21:32 +0200, Adrian Bunk a écrit :
> > > On Mon, Apr 04, 2005 at 09:05:18PM +0200, Marco d'Itri wrote:
> > > > On Apr 04, Greg KH <greg@kroah.com> wrote:
> > > > 
> > > > > What if we don't want to do so?  I know I personally posted a solution
> > > > Then probably the extremists in Debian will manage to kill your driver,
> > > > like they did with tg3 and others.
> > > 
> > > And as they are doing with e.g. the complete gcc documentation.
> > > 
> > > No documentation for the C compiler (not even a documentation of the 
> > > options) will be neither fun for the users of Debian nor for the Debian 
> > > maintainers - but it's the future of Debian...
> > 
> > You are mixing apples and oranges. The fact that the GFDL sucks has
> > nothing to do with the firmware issue. With the current situation of
> > firmwares in the kernel, it is illegal to redistribute binary images of
> > the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
> > be willing to distribute such binary images, but it isn't our problem.
> >...
> 
> 
> It's a grey area.
> 
> debian-legal did pick one of the possible opinions on this matter.
> 
> The similarities between the GFDL and the firmware discussion can be 
> described with the following two questions:
> 
> Is it true, that the removal of much of the documentation in Debian is 
> scheduled soon because it's covered by the GFDL, that this is called an 
> "editorial change", and that Debian doesn't actually care that this will 
> e.g. remove all documentation about available options of the standard C 
> compiler used by and shipped with Debian?

Notice though that the GFDL problematic is part of a much older issue between
debian and the FSF on this, and i believe discussions to solve this issues
have been under discussions since more than a year without real progress that
i know of.

> Is it true, that Debian will leave users with hardware affected by the 
> firmware problem without a working installer in Debian 3.1?

Yes, probably. not my fault though, and the current discussion is part of the
plan to fix this, through availability of non-free installer components.

> The point is simply, that Debian does more and more look dogmatic at 
> it's definition of "free software" without caring about the effects to 
> it's users.

I reject this affirmation. 

> As a contrast, read the discussion between Christoph and Arjan in a part 
> of this thread how to move firmware out of kernel drivers without 
> problems for the users. This might not happen today, but it's better for 
> the users.

It is indeed, but it is something that involves kernel development which i
don't really have time to do right now, and even if we where to do that, the
legal problem of the messed licencing situation would remain. The current
short term solution is simply to move the affected drivers to non-free, and
provide mechanisms for the user to load these installer modules with the free
installer, or have a couple of builds of a non-free installer which include
these non-free modules.

Saying that we are dogmatic, without even caring to understand what the
current reality is doesn't strike me at the most reasonable way to discuss
such issues.

Friendly,

Sven Luther


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271944AbTG2SEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTG2SB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:01:58 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:40836
	"EHLO nevyn.them.org") by vger.kernel.org with ESMTP
	id S271965AbTG2SBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:01:43 -0400
Date: Tue, 29 Jul 2003 14:01:40 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus' 2.6.0-test1 (PPC) -- Radeon Mobility M7 LW (AGP) display messed up (DRI update problem?)
Message-ID: <20030729180138.GA30012@nevyn.them.org>
Mail-Followup-To: Miles Lane <miles.lane@comcast.net>,
	linux-kernel@vger.kernel.org
References: <200307282135.27750.miles.lane@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307282135.27750.miles.lane@comcast.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 09:35:27PM -0700, Miles Lane wrote:
> Hi Linus, 
> 
> It looks like maybe something went wrong in your DRI merge.
> >From 2.6.0-test1, I have had major problems with my Radeon
> display when XFree86 (cvs HEAD) starts up.  I am running
> on a PowerBook G4 (Titanium III/800) with DRI enabled.
> Earlier 2.5 kernels rendered XFree86 okay.  The weird thing
> since test1 is that once XFree86 starts up, switching to a 
> VT and back does not clear up the problem.  The VT displays
> are hosed as well (the problem is that only about the top
> one line of text (in a VT window) looks okay.  Below that,
> the whole screen is an out-of-sync blur.
> 
> When I run fbset in a VT window, it shows the same info
> that shows up when running under 2.5 kernels (with no display
> corruption).
> 
> I will test again with DRI disabled and see if the problem goes away.
> If it does, I will check again with your DRI updates from 2.6.0-test1
> backed out.  I'll let you know what happens.

FYI, I'm having similar problems with an aty128.  DRI does not affect
it, however.  With X set to UseFBDev I get striping; without it I get a
head-numbing blur effect.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

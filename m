Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUDEAYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 20:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUDEAYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 20:24:03 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:46223 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262987AbUDEAYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 20:24:00 -0400
Date: Sun, 4 Apr 2004 20:12:13 -0400
From: Ben Collins <bcollins@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marcel Lanz <marcel.lanz@ds9.ch>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PANIC] ohci1394 & copy large files
Message-ID: <20040405001213.GZ13168@phunnypharm.org>
References: <20040404141600.GB10378@ds9.ch> <20040404141339.GW13168@phunnypharm.org> <1081119623.1285.121.camel@gaston> <20040404231746.GX13168@phunnypharm.org> <1081123676.1203.128.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081123676.1203.128.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 10:07:56AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2004-04-05 at 09:17, Ben Collins wrote:
> 
> > Because the fix was pretty extensive and needed testing. It was
> > potentially more broken that the problem it was fixing. Sending untested
> > patches to Linus is far worse than batching a few up and pushing to him.
> 
> Ok, makes sense, it wasn't just a 1-liner quick fix then ;)
> 
> Still, from my experience, _very few_ people actually test things in
> trees like ieee1394, fbdev, etc...  Even my tree isn't what it used
> to be for pmacs now that I'm fully in sync upstream.
> 
> Even -mm lately haven't been as tested as it used to be (possibly
> because of upstream getting better). I find it's quite ok to send
> a fix that needs a bit more testing to a Linus -rc1 (but not later),

People that experience problems that I have a fix for in the repo,
usually get pointed to that repo for testing.

In this case I did the fix after -rc2, wasn't comfortable enough to send
it for -rc3 and I think I may wait for 2.6.6-rc1 since there's a harder
to reproduce bug now that I have to fix (I haven't seen it, but a few
people that tested our repo have reported it).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

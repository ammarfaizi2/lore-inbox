Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSJCOk3>; Thu, 3 Oct 2002 10:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbSJCOk3>; Thu, 3 Oct 2002 10:40:29 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:26122 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261570AbSJCOk2>; Thu, 3 Oct 2002 10:40:28 -0400
Date: Thu, 3 Oct 2002 15:45:59 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, kai-germaschewski@uiowa.edu
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003144559.GC56233@compsoc.man.ac.uk>
References: <20021003140530.GA56233@compsoc.man.ac.uk> <Pine.LNX.4.44.0210030922270.24570-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210030922270.24570-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 09:27:49AM -0500, Kai Germaschewski wrote:

> Since it gives Rules.make the wrong file names in $(obj-[ym]), and relies 
> on implementation details inside of Rules.make in combination with the 
> vpath statement to make things work despite those wrong names. 

This sounds like kbuild's problem not mine. That is, I don't see
anything particularly ugly in using vpath.

> So did you decide to move things from drivers/oprofile/$(ARCH) to 
> arch/$(ARCH)/oprofile? It's possible to make it work, but not pretty. As I 
> said before, kbuild actually expects to have all parts of a single module 
> to be in a single dir. This can be lifted a little bit as done for xfs, 
> but spreading parts all over the tree is not very desirable IMO.

Can the kernel people decide amongst themselves what they want, then
I'll just do it ?

Personally, the arch/ drivers/ split seems perfectly natural for
oprofile.

regards
john
-- 
"Me and my friends are so smart, we invented this new kind of art:
 Post-modernist throwing darts"
	- the Moldy Peaches

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRGAOnz>; Sun, 1 Jul 2001 10:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265156AbRGAOnp>; Sun, 1 Jul 2001 10:43:45 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:3313 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S265149AbRGAOn2>; Sun, 1 Jul 2001 10:43:28 -0400
Date: Sun, 1 Jul 2001 09:43:27 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: What are the VM motivations??
In-Reply-To: <20010621190103.A888@jmcmullan.resilience.com>
Message-ID: <Pine.LNX.4.33.0107010933320.2957-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hopelessly behind on my mail, so this has probably been dealt with,
already, but here goes:  It's a userspace problem.

That is, any automagical VM tuner ought to be a daemon.  If the kernel
doesn't expose enough information or knobs to make a good VM tuner, add
what is needed.

Meanwhile, if anyone has a good handle on how to tune for interactivity
vs. power saving vs. server performance, it seems that a lot of sysadmin.s
need a good reference *from the sysadmin point of view* on how to tune
manually for different sorts of loads.  If the kernel is tunable in ways
that are understandable, it'll be fairly easy to tune by hand and the
daemon may not be needed at all.  And again, we have a userspace solution
that doesn't add much weight to the kernel.

The original post does make a valuable point:  resource allocation is a
problem with *no general solution*, because the goodness of a solution
depends on the values of the person applying it.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.


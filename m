Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264529AbSIQUyK>; Tue, 17 Sep 2002 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbSIQUyJ>; Tue, 17 Sep 2002 16:54:09 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:896 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S264529AbSIQUyJ>;
	Tue, 17 Sep 2002 16:54:09 -0400
Date: Tue, 17 Sep 2002 15:58:54 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-kernel@vger.kernel.org, <neilb@cse.unsw.edu.au>
Subject: Re: 2.5 Problem Report Status
In-Reply-To: <3D8721FB.70B74C27@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0209171554001.988-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Helge Hafting wrote:

> Thomas Molina wrote:
> 
> > 14   RAID boot problem          open                  2.5.34
> > 
> This one got fixed in 2.5.34-bk6 and is ok in 2.5.35.
> 
> One may boot from a root RAID-1 now, if it don't
> need to resync.
> 
> The kernel dies within a minute or two 
> if it has to resync a sufficiently big
> raid-1 though - by freezing solid.  Sometimes
> with several 0-order allocation failures first.
> this is a known problem.

That was pretty much what I was gathering from the ongoing discussion on 
another thread, but thanks for confirming.  It sounds as if there is a bit 
of work to do, but as long as folks are satisfied with the workarounds 
I'll mark this close and make a note for my "long-term" file to ask about 
later.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262947AbTCSIF3>; Wed, 19 Mar 2003 03:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbTCSIF3>; Wed, 19 Mar 2003 03:05:29 -0500
Received: from imap.gmx.net ([213.165.65.60]:4640 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262947AbTCSIF1>;
	Wed, 19 Mar 2003 03:05:27 -0500
Message-Id: <5.2.0.9.2.20030319091819.00ca4bf0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 19 Mar 2003 09:21:00 +0100
To: Jeremy Fitzhardinge <jeremy@goop.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
Cc: Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048057981.1209.17.camel@ixodes.goop.org>
References: <20030318215228.417e0a58.akpm@digeo.com>
 <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
 <20030318215228.417e0a58.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:13 PM 3/18/2003 -0800, Jeremy Fitzhardinge wrote:
>On Tue, 2003-03-18 at 21:52, Andrew Morton wrote:
> > > Could people, who can reproduce 'audio skips' kind of problems even with
> > > BK-curr, give this patch a go?
> >
> > I do not test for multimedia performance and cannot comment on this.
>
>I'm still getting starvation problems.  If I run xmms with the "Goom"
>visualizer (with the window large enough that it is CPU-bound), then
>type a command into a shell window (say, ps), it will not run the
>command until I close or shrink the goom window.  xmms itself plays
>fine, though sometimes it fails to go to the next track, apparently for
>the same reason (ie, it starts the next track when I disable the
>visualizer).

I'm hot on the trail (woof) of this.  If I get it working "right", are you 
willing to test a patch?  I don't want to bug Ingo until I've got something 
worth arm waving about ;-)

         -Mike 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbTCSHCG>; Wed, 19 Mar 2003 02:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262938AbTCSHCG>; Wed, 19 Mar 2003 02:02:06 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:39692
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262937AbTCSHCF>; Wed, 19 Mar 2003 02:02:05 -0500
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, efault@gmx.de
In-Reply-To: <20030318215228.417e0a58.akpm@digeo.com>
References: <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
	 <20030318215228.417e0a58.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048057981.1209.17.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 23:13:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 21:52, Andrew Morton wrote:
> > Could people, who can reproduce 'audio skips' kind of problems even with
> > BK-curr, give this patch a go?
> 
> I do not test for multimedia performance and cannot comment on this.

I'm still getting starvation problems.  If I run xmms with the "Goom"
visualizer (with the window large enough that it is CPU-bound), then
type a command into a shell window (say, ps), it will not run the
command until I close or shrink the goom window.  xmms itself plays
fine, though sometimes it fails to go to the next track, apparently for
the same reason (ie, it starts the next track when I disable the
visualizer).

Goom is available from http://ios.free.fr/?page=projet&quoi=1.  It
installs pretty easily if you have xmms installed.

That said, it does seem to be better than previous schedulers (for
example, 64-mm8).  It used to starve xmms so much that I couldn't close
operate the UI to turn off the visualizer.

	J


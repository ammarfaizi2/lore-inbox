Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUL0V6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUL0V6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbUL0V6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:58:07 -0500
Received: from h80ad25c6.async.vt.edu ([128.173.37.198]:42208 "EHLO
	h80ad25c6.async.vt.edu") by vger.kernel.org with ESMTP
	id S261291AbUL0V6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:58:00 -0500
Message-Id: <200412272148.iBRLmH5N013202@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15) 
In-Reply-To: Your message of "Mon, 27 Dec 2004 13:06:14 PST."
             <20041227210614.GA11052@nietzsche.lynx.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk> <1104165560.20042.108.camel@localhost.localdomain>
            <20041227210614.GA11052@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1592794096P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Dec 2004 16:48:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1592794096P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Dec 2004 13:06:14 PST, Bill Huey said:

> Is a real-time enabled kernel still relevant for high performance
> video even with GPUs being as fast as they are these days ?

More to the point - can a RT kernel help *last* year's model?  My
laptop only has a GeForce4 440Go (which is closer to a GeForce2 in
reality) and a 1.6Gz Pentium4.  So it isn't any problem at all
to even find xscreensaver GL-hacks that bring it to its knees.

Even the venerable 'glxgears' drops down to about 40FPS in an 800x600
window.  I'm sure the average game has a *lot* more polygons in it than
glxgears does.  xscreensaver's 'sierpinski3d' drops down to 18FPS when it
gets up to 16K polygons.

Linux has long been reknowned for its ability to Get Stuff Done on much older
and less capable hardware than the stuff from Redmond.  Got an old box that
crawled under W2K and Win/XP won't even install? Toss the current RedHat or
Suse on it, and it goes...

Would be *really* nice if we could find similar tricks on the graphics side. ;)

> The context that I'm working with is that I was told (been out of
> gaming for a long time now) that GPus are so fast these days that
> shortage of frame rate isn't a problem any more. An RTOS would be
> able to deliver a data/instructions to the GPU under a much tighter
> time period and could delivery better, more consistent frame rates.
> 
> Does this assertion still apply or not ? why ? (for either answer)

Shortage of frame rate is *always* a problem.  No matter how many
millions of polygons/sec you can push out the door, somebody will want
to do N+25% per second.  Ask yourself why SGI was *EVER* able to sell
a machine with more than one InfiniteReality graphics engine on it, and
then ask yourself what the people who were using 3 IR pipes 5-6 years
ago are looking to use for graphics *this* year.

--==_Exmh_-1592794096P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB0IMgcC3lWbTT17ARAgwkAKDUaRGbUXkXgqnX+lJ+EiQ6rBeKZgCcDd3H
mBtPNFZ7JugUb2tfrsNaFP8=
=fITT
-----END PGP SIGNATURE-----

--==_Exmh_-1592794096P--

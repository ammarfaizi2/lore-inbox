Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVE2RwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVE2RwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVE2RwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 13:52:25 -0400
Received: from h80ad2702.async.vt.edu ([128.173.39.2]:46097 "EHLO
	h80ad2702.async.vt.edu") by vger.kernel.org with ESMTP
	id S261367AbVE2RwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 13:52:12 -0400
Message-Id: <200505291750.j4THoUWW010374@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Bill Huey <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance 
In-Reply-To: Your message of "Sun, 29 May 2005 09:00:49 MDT."
             <Pine.LNX.4.61.0505290856220.12903@montezuma.fsmlabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com> <1117334933.11397.21.camel@mindpipe> <Pine.LNX.4.61.0505282054540.12903@montezuma.fsmlabs.com> <200505290408.j4T487n6024489@turing-police.cc.vt.edu>
            <Pine.LNX.4.61.0505290856220.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117389028_6734P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 13:50:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1117389028_6734P
Content-Type: text/plain; charset=us-ascii

On Sun, 29 May 2005 09:00:49 MDT, Zwane Mwaikambo said:
> On Sun, 29 May 2005 Valdis.Kletnieks@vt.edu wrote:

> > I'd be wildly surprised if media apps *were* commonplace on an operating
> > system that didn't supply the needed scheduling infrastructure.
> > 
> > That's as straw-man as commenting that applications that used more than 16
> > processors weren't commonplace on Linux before the scalability work that made
> > it feasible to build systems with more than 2 CPUs....
> 
> I'm not talking about Linux (which should be obvious as Linux isn't an 
> RTOS), so it has nothing to do with Linux capabilities. I'm referring to 
> general hard realtime applications and their use of realtime operating 
> systems.

As amply shown by the Ardour and linux-audio crowds, the *MAJOR* thing keeping
realtime apps from spreading further is the lack of usable RT support in CTOS
operating systems.  Yes, you *can* do realtime audio - if you're willing to not
use a common operating system and run some specialized RTOS instead.  This is
frequently a show-stopper for small-time use - if there's an additional $5K
cost to getting and installing an RTOS (quite likely you need a new computer,
or redo the one you have to dual-boot), it may not be a problem for a large
recording studio - but it *is* a problem for a small studio or a home user.
So you end up with "The 150 places that buy 48-channel mixers are using RT,
but the 40,000 people who buy 4/8 channel mixers aren't" - by your standards,
nobody's interested in 48-channel mixing boards either.

So tell me - who was using SMP with large numbers of processors *before* the
Linux kernel?  Hmm.. You could buy an SGI Onyx.  A Sun E10K.  The IBM gear.
And for some odd reason, there wasn't many sites that just weren't doing
SMP - it wasn't that long ago that a 48-CPU Sun was enough to get you on the
Top500 supercomputer list.  Now everybody and their pet llama has a 128-node
system, it seems....

Large-scale SMP, realtime, whatever.  It doesn't matter - you're pointing at it and
saying "But nobody *uses* it" when nobody can afford the technology, when there's
plenty of people lining up and saying "We *would* be using it if it were accessible".

Nobody drives around in Rolls Royces and Bentleys either - and 20 years ago, you
could have used that to say "But nobody drives luxury cars".  That's changed
considerably - you get a company that decides to make a Lexus, with 95% of the
quality at 10% of the price, and you can see a *lot* of them on the road.....

--==_Exmh_1117389028_6734P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCmgDkcC3lWbTT17ARAvWDAKCvkaWky+HxuoAtA4xMLp2U0VSMQgCgtVQ0
HH+veMUtVy02vJCPbuWBHu8=
=KFGU
-----END PGP SIGNATURE-----

--==_Exmh_1117389028_6734P--

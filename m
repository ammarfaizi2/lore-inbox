Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJVE2o>; Tue, 22 Oct 2002 00:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSJVE2n>; Tue, 22 Oct 2002 00:28:43 -0400
Received: from dp.samba.org ([66.70.73.150]:37071 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262122AbSJVE2n>;
	Tue, 22 Oct 2002 00:28:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: landley@trommello.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       davej@suse.de, davem@redhat.com,
       "Guillaume Boissiere" <boissiere@adiglobal.com>, mingo@redhat.com,
       alan@redhat.com
Subject: Re: 2.6: Shortlist of Missing Features 
In-reply-to: Your message of "Sun, 20 Oct 2002 21:44:59 EST."
             <200210202144.59787.landley@trommello.org> 
Date: Tue, 22 Oct 2002 12:26:26 +1000
Message-Id: <20021022043451.46C792C053@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200210202144.59787.landley@trommello.org> you write:
> Sigh.  If great minds think alike, how do you explain either of us then? =
> :)

"Fools never differ" perhaps?

I'm not worried about stuff which is in -mm: they won't get lost, and
some of them will get thrown out if the benchmarks don't pay off.

> o in -ac PCMCIA Zoom video support (Alan Cox)=20
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0326.html

Hmm... is this merely a new driver or significant new infrastructure?

> o Ready - Dynamic Probes (dprobes team)=20
> http://oss.software.ibm.com/developerworks/opensource/linux/projects/dpro=
> bes

The minimal kernel part of this is kprobes.

> o Ready - Zerocopy NFS (Hirokazu Takahashi)=20
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html

This is really up to Dave.  I thought he was already merging it?

> And In a reply to me, Hans Reiser promised Reiser 4 by the 27th.  (That's=

Another filesystem can go in during the freeze, unless it makes
infrastructure changes?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

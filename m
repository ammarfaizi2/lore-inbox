Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263993AbTCWXeq>; Sun, 23 Mar 2003 18:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbTCWXeq>; Sun, 23 Mar 2003 18:34:46 -0500
Received: from franka.aracnet.com ([216.99.193.44]:53186 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263993AbTCWXep>; Sun, 23 Mar 2003 18:34:45 -0500
Date: Sun, 23 Mar 2003 15:45:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <6850000.1048463137@[10.10.2.4]>
In-Reply-To: <3E7E4486.8080302@pobox.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
 <1048448838.1486.12.camel@phantasy.awol.org>
 <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
 <1048450211.1486.19.camel@phantasy.awol.org>
 <402760000.1048451441@[10.10.2.4]>
 <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
 <920000.1048456387@[10.10.2.4]> <3E7E335C.2050509@pobox.com>
 <1240000.1048460079@[10.10.2.4]> <3E7E4486.8080302@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> O(1) sched may be a bad example ... how about the fact that mainline VM
>> is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
>> for that have been around for ages. 
> 
> "totally unstable" being defined as:  My computers don't crash, and my
> 100%-mainline test kernels pass various Cerberus/LTP/crashme runs.
> 
> Of course, I am not totally focused on multi-million-dollar computers, so
> maybe my perspective is skewed...  ;-)

Last time I checked, a 2x machine with 4Gb of RAM didn't cost millions of
dollars ;-)

> Fixes should be applied to 2.4-mainline, certainly.  Anything else just
> wastes developer brain cycles and slows the move to 2.6.

Common vendor _features_ is maybe better done in a separate tree, I'd
accept ... I'm just frustrated with the current lack of commonality between
distros, I guess.

M.


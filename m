Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVCOAC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVCOAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVCOAC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:02:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1667 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262134AbVCOAC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:02:57 -0500
Date: Tue, 15 Mar 2005 01:02:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       David Lang <david.lang@digitalinsight.com>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050315000234.GD9873@elf.ucw.cz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <1110837341.5863.21.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110837341.5863.21.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We already have the 'quiet' option, but even so, I think the kernel is *way* 
> > too verbose.  Someone needs to make a personal crusade out of removing 
> > unneeded and unjustified printks from the kernel before it really gets better 
> > though...
> 
> Oh well, I admit going backward here with my new radeonfb which will be
> very verbose in a first release, but that will be necessary to track
> down all the various issues with monitor detection, BIOSes telling crap
> about connectors etc...

I'd say that's okay, as long as you remove the messages
afterwards. Perhaps "cleanup printks just before you remove dependency
on CONFIG_EXPERIMENTAL is right thing to require"?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

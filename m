Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVC3JqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVC3JqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 04:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVC3JqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 04:46:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13229 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261830AbVC3JqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 04:46:09 -0500
Date: Wed, 30 Mar 2005 11:45:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050330094555.GA10364@elf.ucw.cz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com> <1111539217.4691.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111539217.4691.57.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm really not trolling, but I suspect if we made the boot process less
> > > verbose, people would start to wonder more about why Linux takes so much
> > > longer than XP to boot.
> > 
> > By the way, Microsoft seems to be claiming that boot time will be reduced to the half
> > with Longhorn. While we already know how ms marketing team works, 50% looks
> > like a lot. Is there a good place to discuss what could be done in the linuxland to
> > improve things? It doesn't looks like a couple of optimizations will be enought...
> > 
> 
> Yup, many people on this list seem unaware but read the XP white papers,
> then try booting it side by side with Linux.  They put some serious,
> serious engineering into that problem and came out with a big win.
> Screw Longhorn, we need improve by 50% to catch up to what they can do
> NOW.
> 
> The solution is fairly well known.  Rather than treating the zillions of
> disk seeks during the boot process as random unconnected events, you

Heh, we actually tried that at SuSE and yes, eliminating seeks helps a
bit, but no, it is not magicall cure you'd want it to be.

Only solution seems to be "do less during boot".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

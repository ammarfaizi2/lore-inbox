Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTAJQyW>; Fri, 10 Jan 2003 11:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTAJQyW>; Fri, 10 Jan 2003 11:54:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7810 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265355AbTAJQyV>;
	Fri, 10 Jan 2003 11:54:21 -0500
Date: Fri, 10 Jan 2003 17:00:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Shawn Starr <shawn.starr@datawire.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030110170038.GD23375@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Shawn Starr <shawn.starr@datawire.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301101139.57342.shawn.starr@datawire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301101139.57342.shawn.starr@datawire.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 11:39:57AM -0500, Shawn Starr wrote:
 > There will be a new kernel tree that will fit this purpose soon called -xlk 
 > (eXtendable or Extended Linux Kernel). The hope to make it an 'official' like 
 > -ac, -mm tree for stuffing experimental stuff into a post 2.6 (or just before 
 > 2.6 goes live) kernel. I will need help in getting this to become a reality 
 > in the coming months to 2.6.

The effort is really much better spent trying to get to 2.6 first before
worrying about things like 2.7.  I hope 2.6 doesn't turn into the
"heres my 2.4+preempt+rmap patchset" monster that we saw six months ago.
 
 > We want code that will add new drivers / devices and general 
 > improvements to the kernel.

non-core changes (ie, new drivers) still get added during code freeze,
and during 2.6.x, there's no need for a specific tree just for this.
Adding a new driver doesn't (or at least shouldn't) impact any existing
users if done right.
 
 > The goal is once these are stabilized they can be 
 > submitted to Linus and friends for blessings and inclusion into 2.7 dev 
 > *early* so we won't have a mad rush for features before the next feature 
 > freeze.

Nice try. It'll still happen regardless. Bombing Linus with ten zillion
patches when he opens up 2.7.x with "has been tested in 2.6-xyz" isn't
the way to do it. Everything has to happen incrementally, or you end
up with a mess.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

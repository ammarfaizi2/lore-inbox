Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbVKPWXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbVKPWXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbVKPWXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:23:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35580 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030532AbVKPWXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:23:50 -0500
Date: Wed, 16 Nov 2005 15:24:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Andrey Volkov <avolkov@varma-el.com>,
       Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-ID: <20051116222423.GG30014@mag.az.mvista.com>
References: <20051116031520.GL5546@mag.az.mvista.com> <20051116185513.GB18217@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116185513.GB18217@hexapodia.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 10:55:13AM -0800, Andy Isaacson wrote:
> On Tue, Nov 15, 2005 at 08:15:20PM -0700, Mark A. Greer wrote:
> > On Wed, Nov 16, 2005 at 12:48:59AM +0300, Andrey Volkov wrote:
> > > > Mark, care to comment on that possibility, and/or on the code itself?
> > > > 
> > > And, please, remove unnecessary PPC dependence from Kconfig.
> > 
> > When I originally submitted the m41t00 patch, I made it clear that it
> > was PPC only and gave the reason why:
> > 
> > http://archives.andrew.net.au/lm-sensors/msg29280.html
> 
> I have a MIPS platform with M41T81 (SiByte SWARM,
> arch/mips/sibyte/swarm/rtc_m41t81.c) that I would dearly love to
> decruftify.  (Don't pay too much attention to the kernel.org trees for
> MIPS, you need to pull the git repo on linux-mips.org for the real
> stuff.)
> 
> So I'm definitely interested in this work.

Thanks Andy.  I'll check out the m41t81 datasheet and see how well it
blends with the others.  Also, ppc and mips will have different
interfaces but it should be acceptable to have two sets of interface
routines with #ifdef CONFIG_PPC/MIPS around them.

I'm off to read datasheets now...  :)

Mark

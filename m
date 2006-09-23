Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWIWWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWIWWrr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWIWWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:47:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55567 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750873AbWIWWrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:47:46 -0400
Date: Sun, 24 Sep 2006 00:47:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923224740.GI5566@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923224909.69579243.khali@linux-fr.org> <1159045077.1097.182.camel@mindpipe> <20060923232054.4964f729.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923232054.4964f729.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 11:20:54PM +0200, Jean Delvare wrote:
> Hi Lee,
> 
> > On Sat, 2006-09-23 at 22:49 +0200, Jean Delvare wrote:
> > > I will not use 2.6.16.y with its current rules, for sure, and I doubt
> > > any distribution will. Wasn't the whole point of 2.6.16.y to serve as
> > > a common base between several distributions? 
> > 
> > I would not expect distros to be interested in a 2.6 tree that does not
> > add support for new devices.  Isn't new hardware support one of the main
> > areas where distros routinely get ahead of mainline?
> 
> It really depends on the distribution, and even more of the specific
> product. I know for a fact that Suse has no interest in supporting
> additional hardware in the saa7134 driver for SLES10, for example. I
> suspect that distributions only backport hardware support when a
> customer asks for it, and they have some in-house knowledge to do it
> safely.

[ see my comment about distributions in the other email ]

And I'd expect distributions with some in-house knowledge to do at most 
cherry picking from my tree.

> My original understanding was that 2.6.16.y was meant to be a common
> tree between different distributions and products, containing only the
> unquestionable fixes - i.e. security, data corruption and other oopses,
> in the -stable spirit - and then different distributions would add their
> own patches on top of it as they see fit.

How do you define "unquestionable fixes"?

E.g. what if a distribution supports an external module, and a fix 
requires changing the kernel ABI this module uses?

The users of my trees are mostly people using self-compiled kernels that 
want security fixes but no regressions.

> Jean Delvare

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


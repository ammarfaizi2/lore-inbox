Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWIWW6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWIWW6p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWIWW6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:58:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60175 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750852AbWIWW6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:58:44 -0400
Date: Sun, 24 Sep 2006 00:58:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060923225838.GJ5566@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923224909.69579243.khali@linux-fr.org> <20060923223348.GH5566@stusta.de> <1159051675.1097.194.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159051675.1097.194.camel@mindpipe>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 06:47:54PM -0400, Lee Revell wrote:
> On Sun, 2006-09-24 at 00:33 +0200, Adrian Bunk wrote:
> > the main goals for 2.6.16 are:
> > - no regressions
> > - security fixes
> > 
> > And I did always say that things like adding new PCI IDs are
> > considered 
> > OK for 2.6.16. 
> 
> I think the point that people are trying to make is that adding new PCI
> IDs carries an inherent risk of regression.  Unless you have access to
> every device with that ID for regression testing it could be the
> difference between a machine where one device doesn't work and a machine
> that locks up hard.

"a machine that locks up hard" is a pretty uncommon case, and it should 
be ruled out by the following two factors:
- patch must be in Linus' tree
- I'm asking the patch authors and maintainers of the affected subsystem
  whether the patch is OK for 2.6.16

You never achieve 0% risk, but many bug fixes have a much higher risk of 
regression.

I do know that the only value of the 2.6.16 tree lies in a lack of 
regressions and act accordingly, and as soon as people will report 
regressions compared to earlier 2.6.16 kernels I'll know that I'll have 
done something wrong (but I haven't yet gotten such bug reports).

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


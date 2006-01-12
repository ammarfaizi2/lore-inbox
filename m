Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161388AbWALWwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161388AbWALWwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161389AbWALWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:52:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35332 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161388AbWALWwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:52:05 -0500
Date: Thu, 12 Jan 2006 23:52:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060112225205.GZ29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu> <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de> <1137105731.2370.94.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137105731.2370.94.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:42:10PM -0500, Lee Revell wrote:
> On Thu, 2006-01-12 at 23:00 +0100, Adrian Bunk wrote:
> > CYBER5050 is discussed in ALSA bug #1293 (tester wanted).
> 
> OK I set that bug to FEEDBACK, but it's open 5 months now and no testers
> are forthcoming.  I think if we don't find one as a result of this
> thread we can assume no one cares about this hardware anymore.

The majority of Linux users doesn't read linux-kernel...

We might find users after the OSS driver is deprecated in a released 
kernel, or perhaps some months after it's removed from the kernel.

This would match my current experiences regarding my suggested removal 
of some OSS drivers.

> I'm still not sure that just adding it to the ALSA driver and hoping it
> works is the best solution.  Would we rather users see right away that
> their hardware isn't supported, or have the driver load and get no sound
> or hang the machine?
> 
> I think the best approach might just be to drop it in lieu of a tester.
> It will be trivial to add support later if someone finds one of these
> boxes.

Agreed.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


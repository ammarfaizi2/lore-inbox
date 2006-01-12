Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWALUnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWALUnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWALUna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:43:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53522 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161251AbWALUna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:43:30 -0500
Date: Thu, 12 Jan 2006 21:43:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: Re: SOFTWARE_SUSPEND: dependency on non-existing FVR symbol
Message-ID: <20060112204329.GU29663@stusta.de>
References: <20060110043627.GD3911@stusta.de> <20060106202948.GB2736@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106202948.GB2736@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 08:29:48PM +0000, Pavel Machek wrote:
> On Tue 10-01-06 05:36:27, Adrian Bunk wrote:
> > The following issue in kernel/power/Kconfig was noted by
> > Jean-Luc Leger <reiga@dspnet.fr.eu.org>:
> > 
> > config SOFTWARE_SUSPEND
> >         bool "Software Suspend"
> >         depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
> > 
> > 
> > The problem is that there is no FVR symbol in the kernel.
> > 
> > Is this a misspelling of FRV or something different?
> 
> FRV, IIRC, but apparently noone ever tested that.

Should my patch remove or rename it to FRV?

> 								Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


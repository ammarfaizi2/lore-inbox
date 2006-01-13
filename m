Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWAMPYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWAMPYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWAMPYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22540 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964966AbWAMPYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:21 -0500
Date: Fri, 13 Jan 2006 16:24:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Jon Mason <jdmason@us.ibm.com>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060113152421.GP29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu> <20060112214719.GE17539@us.ibm.com> <20060112220039.GX29663@stusta.de> <1137105731.2370.94.camel@mindpipe> <20060113113756.GL5399@granada.merseine.nu> <20060113122358.GH29663@stusta.de> <20060113123215.GQ5399@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113123215.GQ5399@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 02:32:15PM +0200, Muli Ben-Yehuda wrote:
> On Fri, Jan 13, 2006 at 01:23:58PM +0100, Adrian Bunk wrote:
> 
> > In my experience with scheduling OSS drivers for removal, users simply 
> > use the OSS drivers unless you tell them very explicitely that the OSS 
> > driver will go.
> 
> If the OSS drivers satisfy them, what's wrong with it?
>...

There are two drivers, each with it's own features and bugs.

Either the ALSA driver is better in any respect making the OSS driver 
simply obsolete, or there are problems in the ALSA driver that should be 
reported and fixed.

Removing the OSS driver forces users to report the problems with the 
ALSA driver making the latter better for everyone.

> Cheers,
> Muli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


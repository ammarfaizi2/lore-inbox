Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWALWAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWALWAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161340AbWALWAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:00:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5380 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161339AbWALWAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:00:40 -0500
Date: Thu, 12 Jan 2006 23:00:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jon Mason <jdmason@us.ibm.com>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jiri Slaby <slaby@liberouter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
Message-ID: <20060112220039.GX29663@stusta.de>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org> <20060112200735.GD5399@granada.merseine.nu> <20060112214719.GE17539@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112214719.GE17539@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 03:47:19PM -0600, Jon Mason wrote:
> On Thu, Jan 12, 2006 at 10:07:35PM +0200, Muli Ben-Yehuda wrote:
> > On Thu, Jan 12, 2006 at 08:28:30PM +0100, Jiri Slaby wrote:
> > 
> > > You should change alsa driver (sound/pci/trident/trident.c), rather than this,
> > > which will be removed soon, I guess. And, additionally, could you change that
> > > lines to use PCI_DEVICE macro?
> > 
> > This driver is not up for removal soon, as it supports a device that
> > the alsa driver apparently doesn't (the INTERG_5050). As for
> > PCI_DEVICE, agreed. Jon, feel like patching it up?
> 
> Patches to follow.
> 
> After looking at the ALSA driver, it doesn't support PCI IDs for
> ALI_5451 or CYBER5050.  Someone should look into porting any necessary
> code from sound/oss/trident.c to sound/pci/trident/trident.c

CYBER5050 is discussed in ALSA bug #1293 (tester wanted).
ALI_5451 is supported by the snd-ali5451 driver.

> Thanks,
> Jon

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


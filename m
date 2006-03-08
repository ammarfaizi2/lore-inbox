Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWCHXFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWCHXFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWCHXFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:05:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7950 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030269AbWCHXFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:05:20 -0500
Date: Thu, 9 Mar 2006 00:05:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060308230519.GT4006@stusta.de>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308225029.GA26117@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 02:50:29PM -0800, Greg KH wrote:
> On Wed, Mar 08, 2006 at 11:26:52PM +0100, Adrian Bunk wrote:
> > On Mon, Mar 06, 2006 at 02:35:45PM -0800, Greg KH wrote:
> > 
> > > Here's a summary of the current state of the Linux PCI and PCI Hotplug
> > > subsystems as of 2.6.16-rc5
> > > 
> > > If the information in here is incorrect, or anyone knows of any
> > > outstanding issues not listed here, please let me know.
> > >...
> > > Was this summary useful for people?  Anything that I should add to it?
> > 
> > It is useful, but one thing seems to be missing:
> > Which patches do you intend to forward for 2.6.16 (if any)?
> 
> None, as I am expecting 2.6.16 to be out any day now.

Looking through the lists of regressions [1] and pending possible 
patches I have for 2.6.16, I'd hope there are still two weeks left for 
bringing 2.6.16 into shape.

> > (pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch seems to
> >  be a candidate.)
> 
> Yes, if people really want it in I could send it, but I was just looking
> for "bugfixes only" at this late stage of the game.

It is a fix for a hardware bug, and IMHO 2.6.16 material (but I don't a 
very strong opinion on the latter).

> thanks,
> 
> greg k-h

cu
Adrian

[1] currently -rc kernels are my trigger for sending regression lists,
    IOW the next one will be sent directly after -rc6 is released

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


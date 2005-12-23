Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVLWB5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVLWB5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 20:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVLWB5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 20:57:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24328 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964987AbVLWB5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 20:57:53 -0500
Date: Fri, 23 Dec 2005 02:57:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Rolland <rol@witbe.net>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [Linux 2.4.32] SATA ICH5/PIIX and Combined mode
Message-ID: <20051223015752.GD27525@stusta.de>
References: <1135164891.3456.11.camel@laptopd505.fenrus.org> <200512211140.jBLBeGD31936@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512211140.jBLBeGD31936@tag.witbe.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 12:40:18PM +0100, Paul Rolland wrote:
> Hello,
> 
> > > I have a machine with two SATA HDD, and one PATA CDRom.
> > > Bios is configured for combined mode, and installing a RedHat ES3
> > > (Kernel 2.4.21-ELsmp) is fine, the two HDD are up, the installation
> > > is fine and the CDRom is working.
> > > 
> > > Then, upgrading to a vanilla 2.4.32, the ata_piix.c file contains
> > > a "combined mode not supported" and booting the machine hangs, as
> > > no VFS are up for root device.
> > 
> > you can't reliably run a non-NPTL kernel on RHES3. Really. Are you
> > really sure you want to ? 
> 
> Well, the other way around is to upgrade e1000 driver in the 2.4.21EL-smp,
> as the machine I'm using is quite new, and RHES3 kernel can't find the
> Ethernet device, so the machine has no network.

AFAIR, RedHat still adds support for new hardware to RHES3.

You should contact the RedHat support you are paying for for getting 
help with RHES3 running on your hardware.

> My first idea was to consider this as an opportunity to upgrade to the
> latest 2.4.x kernel, but reading you, this looks like a bad idea...
> 2.6.x would be better ?

RHES3 doesn't support kernel 2.6.

> Regards,
> Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


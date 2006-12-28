Return-Path: <linux-kernel-owner+w=401wt.eu-S965055AbWL1XHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWL1XHA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWL1XHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:07:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1572 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965055AbWL1XG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:06:59 -0500
Date: Fri, 29 Dec 2006 00:07:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Castricum <mail0612@bencastricum.nl>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061228230701.GL20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> <20061228223909.GK20714@stusta.de> <20061228225706.GA886@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228225706.GA886@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:57:06PM -0800, Greg KH wrote:
> On Thu, Dec 28, 2006 at 11:39:09PM +0100, Adrian Bunk wrote:
> > 
> > Subject    : PCI_MULTITHREAD_PROBE breakage
> > References : http://lkml.org/lkml/2006/12/12/21
> > Submitter  : Ben Castricum <mail0612@bencastricum.nl>
> > Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
> >              commit 009af1ff78bfc30b9a27807dd0207fc32848218a
> > Status     : known to break many drivers; revert?
> 
> PCI_MULTITHREAD_PROBE is now only able to be enabled if you also enable
> CONFIG_BROKEN, so this can be removed from your list.

In Linus' tree, it currently only depends on EXPERIMENTAL.

It seems commit 009af1ff78bfc30b9a27807dd0207fc32848218a wasn't intended 
for Linus?

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


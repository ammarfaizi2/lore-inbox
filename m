Return-Path: <linux-kernel-owner+w=401wt.eu-S1753770AbWL1Xbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbWL1Xbh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbWL1Xbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:31:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:53548 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbWL1Xbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:31:36 -0500
Date: Thu, 28 Dec 2006 15:30:25 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Castricum <mail0612@bencastricum.nl>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061228233025.GA2521@suse.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> <20061228223909.GK20714@stusta.de> <20061228225706.GA886@suse.de> <20061228230701.GL20714@stusta.de> <Pine.LNX.4.64.0612281515470.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612281515470.4473@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 03:17:53PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Dec 2006, Adrian Bunk wrote:
> > 
> > In Linus' tree, it currently only depends on EXPERIMENTAL.
> > 
> > It seems commit 009af1ff78bfc30b9a27807dd0207fc32848218a wasn't intended 
> > for Linus?
> 
> I think we should just remove it.
> 
> It's broken.
> 
> Nobody cares.

I agree, that's why I thought I had added a patch in the last PCI queue
to you to just disable the config option and was going to rip out the
code entirely for the next release.  I'll make sure to add the config
option patch to the next round of PCI patches to you.

thanks,

greg k-h

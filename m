Return-Path: <linux-kernel-owner+w=401wt.eu-S965119AbWL2TWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWL2TWG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 14:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWL2TWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 14:22:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3287 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965119AbWL2TWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 14:22:05 -0500
Date: Fri, 29 Dec 2006 20:22:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061229192205.GT20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> <20061228223909.GK20714@stusta.de> <Pine.LNX.4.64.0612291234400.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612291234400.20138@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 01:14:13PM -0500, Daniel Barkalow wrote:

> There's also http://lkml.org/lkml/2006/12/21/47; the included patch break 
> my nVidia devices and probably all PCIX devices, so it's not right, but 
> something has to be done to fix ATI. My guess is a quirk to say that 
> pci_intx doesn't work on certain devices and should just be skipped, but 
> I'm not sure if it's just in combination with MSI or not.

This:
- does not seem to be a regression and
- missing MSI support is not such a big problem.

Considering how many problems patches in this area tend to cause on 
different hardware, I'm even inclined to say that such patches should 
only be added during the 2 weeks merge window before -rc1.

> 	-Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


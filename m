Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbULHCx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbULHCx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbULHCx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:53:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262017AbULHCwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:52:54 -0500
Date: Wed, 8 Dec 2004 03:52:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.28 config prompts for EXPERIMENTAL features when shouldn't
Message-ID: <20041208025248.GN5496@stusta.de>
References: <20041205165908.GA25139@thune.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041205165908.GA25139@thune.sonic.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 08:59:08AM -0800, Mike Castle wrote:

> I have a basic kernel config that I use for boot disks that has
> CONFIG_EXPERIMENTAL set to no.  Yet, with using my old 2.4.26 config with
> 2.4.28, I'm getting prompted for new experimental features:
> 
>   NVIDIA SATA support (EXPERIMENTAL) (CONFIG_SCSI_SATA_NV) [N/y/m/?] (NEW) 
>   Ethernet Gadget (EXPERIMENTAL) (CONFIG_USB_ETH) [M/n/?] 
>     RNDIS support (EXPERIMENTAL) (CONFIG_USB_ETH_RNDIS) [N/y/?] (NEW) 
> 
> The fact that CONFIG_USB_ETH was set in my 2.4.26 config seems to indicate
> this is not a new problem.  :->

Thanks for this report.

The "(EXPERIMENTAL)" string isn't directly coupled to the dependency on 
EXPERIMENTAL.

I'll send fixes in a minute.

> mrc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


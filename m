Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbTCSVbS>; Wed, 19 Mar 2003 16:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbTCSVbR>; Wed, 19 Mar 2003 16:31:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29194 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263203AbTCSVbQ>;
	Wed, 19 Mar 2003 16:31:16 -0500
Date: Wed, 19 Mar 2003 13:30:01 -0800
From: Greg KH <greg@kroah.com>
To: Torben Mathiasen <torben.mathiasen@hp.com>
Cc: linux-kernel@vger.kernel.org, john.cagle@hp.com, dan.zink@hp.com
Subject: Re: [PATCH] cpqphp 66/100/133MHz PCI-X support for 2.5.65
Message-ID: <20030319213001.GB16463@kroah.com>
References: <20030319115704.GE4925@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319115704.GE4925@tmathiasen>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 12:57:04PM +0100, Torben Mathiasen wrote:
> Hi Greg,
> 
> After being put on hold for a while (needed fixes to CCISS driver, etc) I
> attached a patch that adds pci-x support to the cpqphp driver in 2.5.65.

Thanks a lot for the patch.  I've added it to my trees and will send it
on to Linus in a few days.

> It seems you're in the middle of updating all hotplug drivers. The cpqphp
> driver will oops if you plug in any adapter (unrelated to this patch). I'm sure
> you're aware of this so I didn't bother looking into a fix. It happens because
> pci_scan_slot() now returns an integer instead of a struct pci_dev*.

Yeah, I'm working on fixing that up right now :(

> A 2.4 version is also done and working as expected (tested with CCISS, nics, etc).
> When would you prefer to have that patch?

I'd be glad to take it now if you have it.

thanks again for the patch,

greg k-h

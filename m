Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVKHDHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVKHDHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVKHDHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:07:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:40674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964938AbVKHDHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:07:52 -0500
Date: Mon, 7 Nov 2005 18:43:45 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: linux-sparse@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7]: PCI revised (3) [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051108024344.GA538@kroah.com>
References: <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com> <20051107200352.GB22524@kroah.com> <20051107212128.GH19593@austin.ibm.com> <20051107213729.GA24700@kroah.com> <20051107224338.GQ19593@austin.ibm.com> <20051107225308.GB27787@kroah.com> <20051107231955.GR19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107231955.GR19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 05:19:55PM -0600, linas wrote:
> On Mon, Nov 07, 2005 at 02:53:08PM -0800, Greg KH was heard to remark:
> > > I'm feeling like a blinkin' spammer, splatting out all these emails.
> > 
> > Care to just resend the whole series over again?  No "patch on top of
> > patch" stuff is needed here.
> 
> So that I can avoid that spammin' feelin' ... 
> 
> I'll send patches against -git10, then, so as to start with a clean
> slate; unless you wanted something aginst -mm1?

-git10 would be great.

> "The whole series": do you want all 42 patches? Or just the seven
> discussed today?

Just the 7 discussed.  The others should go to their proper maintainers
(which I am not.)

> -----
> 
> In the series-of-42, the staging of some of the patches in the 
> middle require simultaneous update to both the drivers/pci/hotplug
> and the arch/powerpc/xxx; otherwise, build breaks result. I am
> not sure how to handle that: the obvious solution is to split these
> up... but that will probably result in a bigger series, and was
> not a step I wanted to take unless someone asked...

The drivers/pci/hotplug/ stuff only touches the rpaphp driver, right?
If so, I don't have a problem with Paul/Ben sending those on with the
other PPC64 changes to keep everything building properly for your arch.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVJ1XSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVJ1XSC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVJ1XSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:18:01 -0400
Received: from fmr23.intel.com ([143.183.121.15]:12459 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750705AbVJ1XSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:18:00 -0400
Date: Fri, 28 Oct 2005 16:17:45 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.14
Message-ID: <20051028161745.A27003@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051028225055.GA21464@kroah.com> <20051028225335.GB21871@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051028225335.GB21871@parisc-linux.org>; from matthew@wil.cx on Fri, Oct 28, 2005 at 04:53:35PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 04:53:35PM -0600, Matthew Wilcox wrote:
> On Fri, Oct 28, 2005 at 03:50:55PM -0700, Greg KH wrote:
> > Here are some PCI patches against your latest git tree.  They have all
> > been in the -mm tree for a while with no problems.
> > 
> > Main things here are:
> > 	- pci-ids.h cleanup
> > 	- shpchp driver cleanup (very good job done here.)
> > 	- more quirks added.
> 
> Does this just about clear you out of pending PCI patches?  I want to do
> the s/hotplug_slot/pci_slot/ changes soon and it'll cause massive
> conflicts with anyone else's pending work.
> 
> (I suppose I could do a gradual transition with a #define if preferred,
> but a big bang seems like much less effort)

I just got done doing to pciehp what I did to shpchp (major
revamp). The code is working on one machine and I'm testing
on another. I hope to send it out early next week. If you can
wait till then, it'd be great. If I can't send it out by next
week, I can merge my changes on top of yours.

Thanks,
Rajesh

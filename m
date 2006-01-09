Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWAICgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWAICgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAICgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:36:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:41121 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750802AbWAICgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:36:06 -0500
Subject: Re: [GIT PATCH] PCI patches for 2.6.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060106180833.GA14235@kroah.com>
References: <20060106063716.GA4425@kroah.com>
	 <20060106180833.GA14235@kroah.com>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 13:36:42 +1100
Message-Id: <1136774203.30123.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 10:08 -0800, Greg KH wrote:
> On Thu, Jan 05, 2006 at 10:37:16PM -0800, Greg KH wrote:
> > Here are some PCI patches against your latest git tree.  They have all
> > been in the -mm tree for a while with no problems.
> > 
> > The thing that touches so many different files are the change from the
> > pci_module_init() to pci_register_driver() that was done by Richard
> > Knutsson.  Other big stuff is the addition of the pci error recovery
> > framework, after many different revisions and reworks.
> > There are also some pci hotplug fixes, and quirks added.
> > 
> > Please pull from:
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> > or if master.kernel.org hasn't synced up yet:
> > 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
> > 
> > The full patches will be sent to the linux-pci mailing list, if anyone
> > wants to see them.
> 
> Linus, sorry about this, but due to all of the comments and complaints
> posted about this series, please do not pull it.

Hi Greg, what patches specifically have problems ? Paul is just back
from vacation and we are trying to catch up with merging the tons of
pending powerpc stuffs, but we have a couple of requirements with things
in this list, notably my small export of pci_cfg_space_size() which
should be trivial, but also Linas error recovery stuff... So if one of
these is causing problems, we need to know right now as it means we have
to rebase.

Thanks,
Ben.


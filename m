Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWGaGmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWGaGmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGaGmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:42:11 -0400
Received: from mga07.intel.com ([143.182.124.22]:4244 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932346AbWGaGmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:42:10 -0400
X-IronPort-AV: i="4.07,196,1151910000"; 
   d="scan'208"; a="72888373:sNHT39413990"
Subject: Re: [PATCH 2/5] PCI-Express AER implemetation: Add new defines to
	pci_regs.h
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <20060731050635.GA29058@kroah.com>
References: <1154314837.27051.26.camel@ymzhang-perf.sh.intel.com>
	 <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com>
	 <20060731040045.GC13995@kroah.com>
	 <1154320698.27051.48.camel@ymzhang-perf.sh.intel.com>
	 <20060731050635.GA29058@kroah.com>
Content-Type: text/plain
Message-Id: <1154328033.27051.60.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 31 Jul 2006 14:40:34 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 13:06, Greg KH wrote:
> On Mon, Jul 31, 2006 at 12:38:18PM +0800, Zhang, Yanmin wrote:
> > On Mon, 2006-07-31 at 12:00, Greg KH wrote:
> > > On Mon, Jul 31, 2006 at 11:10:39AM +0800, Zhang, Yanmin wrote:
> > > > Although Greg already accepted the second patch into his testing tree,
> > > > I still resend it to keep the patch integrity.
> > > 
> > > Why?  This is already in 2.6.18-rc3.
> > I checked 2.6.18-rc3 and it doesn't include the patch of pci_regs.h.
> 
> I just looked, and it is there.  Look at git commit
> 6f0312fd7e0e6f96fd847b0b2e1e0d2d2e8ef89d to see it.
I downloaded 2.6.18-rc3 tarball from http://www.kernel.org directly.
Perhaps you mean the git tree, not 2.6.18-rc3?

> 
> > > Please redo the whole series against 2.6.18-rc3, not 2.6.17, otherwise
> > > it's a pain to forward port...
> > The patches could be applied to 2.6.18-rc3 cleanly. There is no any
> > confliction and I tested them under 2.6.18-rc3.
> 
> Based on the above statement, I'm not so sure I believe that :)
> 
> > Is it necessary to rebase to 2.6.18-rc3?
> 
> You should at least regenerate them, yes.
I couldn't get git tree, but I could rebase my patches against
2.6.18-rc3, and delete the pci_reg patch. Is it ok for you?

Thanks,
Yanmin

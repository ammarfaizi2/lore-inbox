Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWGaFSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWGaFSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWGaFSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:18:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:19369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751483AbWGaFSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:18:03 -0400
Date: Sun, 30 Jul 2006 22:06:35 -0700
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 2/5] PCI-Express AER implemetation: Add new defines to pci_regs.h
Message-ID: <20060731050635.GA29058@kroah.com>
References: <1154314837.27051.26.camel@ymzhang-perf.sh.intel.com> <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com> <20060731040045.GC13995@kroah.com> <1154320698.27051.48.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154320698.27051.48.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 12:38:18PM +0800, Zhang, Yanmin wrote:
> On Mon, 2006-07-31 at 12:00, Greg KH wrote:
> > On Mon, Jul 31, 2006 at 11:10:39AM +0800, Zhang, Yanmin wrote:
> > > Although Greg already accepted the second patch into his testing tree,
> > > I still resend it to keep the patch integrity.
> > 
> > Why?  This is already in 2.6.18-rc3.
> I checked 2.6.18-rc3 and it doesn't include the patch of pci_regs.h.

I just looked, and it is there.  Look at git commit
6f0312fd7e0e6f96fd847b0b2e1e0d2d2e8ef89d to see it.

> > Please redo the whole series against 2.6.18-rc3, not 2.6.17, otherwise
> > it's a pain to forward port...
> The patches could be applied to 2.6.18-rc3 cleanly. There is no any
> confliction and I tested them under 2.6.18-rc3.

Based on the above statement, I'm not so sure I believe that :)

> Is it necessary to rebase to 2.6.18-rc3?

You should at least regenerate them, yes.

thanks,

greg k-h

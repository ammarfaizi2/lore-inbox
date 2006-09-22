Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWIVXch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWIVXch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWIVXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:32:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6785 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964925AbWIVXcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:32:36 -0400
Date: Fri, 22 Sep 2006 18:32:35 -0500
To: Luca <kronos.it@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20060922233235.GB14213@austin.ibm.com>
References: <20060921231314.GW29167@austin.ibm.com> <20060922220629.GA4600@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922220629.GA4600@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 12:06:29AM +0200, Luca wrote:
> 
> Space after function name? You put in other places too, it's not
> consistent with the rest of the patch.

Oops. I was also coding on a different project recently, with a
different style.  I'll send a revised patch in a moment.

> > +       if (pci_enable_device(pdev))
> > +               printk (KERN_ERR "%s: device setup failed most egregiously\n",
> > +                           sym_name(np));
> 
> Is the failure of pci_enable_device ignored on purpose?

No. :-( Thanks for the catch. I think I got cross-eyed staring at the code.

--linas

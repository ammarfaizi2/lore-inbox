Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWIVXiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWIVXiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWIVXiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:38:21 -0400
Received: from xenotime.net ([66.160.160.81]:22700 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964931AbWIVXiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:38:20 -0400
Date: Fri, 22 Sep 2006 16:39:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: Luca <kronos.it@gmail.com>, linux-scsi@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-Id: <20060922163929.bb870ee1.rdunlap@xenotime.net>
In-Reply-To: <20060922233235.GB14213@austin.ibm.com>
References: <20060921231314.GW29167@austin.ibm.com>
	<20060922220629.GA4600@dreamland.darkstar.lan>
	<20060922233235.GB14213@austin.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 18:32:35 -0500 Linas Vepstas wrote:

> On Sat, Sep 23, 2006 at 12:06:29AM +0200, Luca wrote:
> > 
> > Space after function name? You put in other places too, it's not
> > consistent with the rest of the patch.
> 
> Oops. I was also coding on a different project recently, with a
> different style.  I'll send a revised patch in a moment.

Please change if()'s to use

	if (var == constant)
instead of
	if (constant == var)

also.  (or whatever condition is being used)  Thanks.


> > > +       if (pci_enable_device(pdev))
> > > +               printk (KERN_ERR "%s: device setup failed most egregiously\n",
> > > +                           sym_name(np));
> > 
> > Is the failure of pci_enable_device ignored on purpose?
> 
> No. :-( Thanks for the catch. I think I got cross-eyed staring at the code.

---
~Randy

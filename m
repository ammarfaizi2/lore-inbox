Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTIFADp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265425AbTIFADo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 20:03:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:46298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264313AbTIFACa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 20:02:30 -0400
Date: Fri, 5 Sep 2003 17:02:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Message-ID: <20030905170224.A16217@osdlab.pdx.osdl.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F59018E.5060604@pobox.com> <200309060016.16545.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309060016.16545.adq_dvb@lidskialf.net>; from adq_dvb@lidskialf.net on Sat, Sep 06, 2003 at 12:16:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew de Quincey (adq_dvb@lidskialf.net) wrote:
> On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
> > This is why we _really_ need you to split up your patches.  Multiple
> > split-up patches, one per email, is preferred.  Don't worry about
> > sending us too much email:  we like it like that.
> 
> If/when I split it up, is it acceptable to number the patches to give the 
> order they have to be applied in? The major problem with these particular 
> fixes is that they all run over the same set of files, even the same 
> functions, so they all conflict with each other. 

Yes, please split them up.
                                                                                
I finally narrowed down to the ChangeSet 1.1046.1.424 (ACPI: Allow irqs >
15...) as cause to my current hang-on-boot problem.  Quick test to see
if this patch fixes...nope ;-(
                                                                                
thanks,
-chris

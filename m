Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbUE1Ph6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUE1Ph6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUE1Ph6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:37:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49285 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263467AbUE1Pho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:37:44 -0400
Date: Fri, 28 May 2004 12:38:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Len Brown <len.brown@intel.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       "linux-pci@atrey.karlin.mff.cuni.cz" 
	<linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: ACPI & 2.4 (Re: [BK PATCH] PCI Express patches for 2.4.27-pre3)
Message-ID: <20040528153828.GC6804@logos.cnet>
References: <A6974D8E5F98D511BB910002A50A6647615FC676@hdsmsx403.hd.intel.com> <1085556934.26254.132.camel@dhcppc4> <20040528120941.GB1400@logos.cnet> <1085756209.17693.108.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085756209.17693.108.camel@dhcppc4>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 10:56:50AM -0400, Len Brown wrote:
> On Fri, 2004-05-28 at 08:09, Marcelo Tosatti wrote:
> > On Wed, May 26, 2004 at 03:35:34AM -0400, Len Brown wrote:
> 
> > > I generally only have time to read LKML messages directed to me
> > > or if the word "ACPI" appears in the message, so I may have missed
> > > the word 2.4.  What is the word?
> > 
> > I dont get you? What you mean? (sorry)
> 
> If you announced a change in policy for accepting 2.4 patches,
> then I missed it.  So I'm assuming that since people are still
> complaining to me about bugs in 2.4, and we're all still fixing
> those bugs, that I should continue to submit those patches to you.

Perfect. 

> I understand that we should not add any new features to 2.4,
> and that we should not undertake any significant code cleanups
> because the tolerance for risk is low.

Right.

> For these reasons, the ACPI code in 2.6 is starting to diverge
> from 2.4.  However, large parts of the ACPI sub-system, such
> as the core intepreter and most of the configuration code,
> are very much the same betwen 2.4 and 2.6.  For this reason
> I think the risk is low to integrate some relatively large
> ACPI patches into 2.4 -- as long as the same code has already
> been tested and released in 2.6.

Hum, fine. That sounds more conservative.

> So I can delay sending 2.4 patches until it is clear that they
> were successful in 2.6.  The question I have is how long there
> will be a 2.4 release available for accepting those patches.

The policy now is to accept only bugfixes and support for new
hardware (eg new PCI ID's, new drivers). There will still be
a few v2.4 releases, just not with the same frequency as they have
been released in the past.

Does that answer your question?



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUE1O5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUE1O5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUE1O5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:57:11 -0400
Received: from fmr05.intel.com ([134.134.136.6]:5306 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S263365AbUE1O5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:57:08 -0400
Subject: Re: ACPI & 2.4 (Re: [BK PATCH] PCI Express patches for 2.4.27-pre3)
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Matthew Wilcox <willy@debian.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       "linux-pci@atrey.karlin.mff.cuni.cz" 
	<linux-pci@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040528120941.GB1400@logos.cnet>
References: <A6974D8E5F98D511BB910002A50A6647615FC676@hdsmsx403.hd.intel.com>
	 <1085556934.26254.132.camel@dhcppc4>  <20040528120941.GB1400@logos.cnet>
Content-Type: text/plain
Organization: 
Message-Id: <1085756209.17693.108.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 May 2004 10:56:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 08:09, Marcelo Tosatti wrote:
> On Wed, May 26, 2004 at 03:35:34AM -0400, Len Brown wrote:

> > I generally only have time to read LKML messages directed to me
> > or if the word "ACPI" appears in the message, so I may have missed
> > the word 2.4.  What is the word?
> 
> I dont get you? What you mean? (sorry)

If you announced a change in policy for accepting 2.4 patches,
then I missed it.  So I'm assuming that since people are still
complaining to me about bugs in 2.4, and we're all still fixing
those bugs, that I should continue to submit those patches to you.

I understand that we should not add any new features to 2.4,
and that we should not undertake any significant code cleanups
because the tolerance for risk is low.

For these reasons, the ACPI code in 2.6 is starting to diverge
from 2.4.  However, large parts of the ACPI sub-system, such
as the core intepreter and most of the configuration code,
are very much the same betwen 2.4 and 2.6.  For this reason
I think the risk is low to integrate some relatively large
ACPI patches into 2.4 -- as long as the same code has already
been tested and released in 2.6.

So I can delay sending 2.4 patches until it is clear that they
were successful in 2.6.  The question I have is how long there
will be a 2.4 release available for accepting those patches.

-Len



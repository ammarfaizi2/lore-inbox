Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTFRMsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFRMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:48:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10945 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264959AbTFRMsi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:48:38 -0400
Date: Wed, 18 Jun 2003 14:02:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030618130234.GN24357@parcelfarce.linux.theplanet.co.uk>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617134156.A2473@jurassic.park.msu.ru> <20030617124950.GF8639@krispykreme> <20030617171100.B730@jurassic.park.msu.ru> <20030617194227.GG24357@parcelfarce.linux.theplanet.co.uk> <20030618013058.A686@pls.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618013058.A686@pls.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 01:30:58AM +0400, Ivan Kokshaysky wrote:
> On Tue, Jun 17, 2003 at 08:42:27PM +0100, Matthew Wilcox wrote:
> > How about this (PPC & Sparc64 will have to decide what they want to do
> > for this case):
> 
> I'm fine with it.
> 
> > +/* We never have overlapping bus numbers on Alpha */
> 
> "Never" is not quite correct - "in general we don't have"
> would be better. Full-sized Marvel can have up to 512 root buses.

So what do you want to do about that case?  If it's going to turn out to
be the same as other architectures, maybe we can do it differently...

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

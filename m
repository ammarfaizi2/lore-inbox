Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTJPVIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTJPVIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:08:37 -0400
Received: from opensource-ca.org ([168.234.203.30]:48783 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S263155AbTJPVIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:08:35 -0400
Date: Thu, 16 Oct 2003 15:06:43 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031016210643.GD19795@guug.org>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066298431.1407.119.camel@gaston>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 12:00:32PM +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2003-10-16 at 11:19, Carlo E. Prelz wrote:
> > 	Subject: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
> > 	Date: gio, ott 16, 2003 at 12:27:44 +0100
> > 
> > Quoting James Simmons (jsimmons@infradead.org):
> > 
> > > I applied it. I also have Ben's new driver avaiable for testing. 
> > > The diff I released uses Ben's new driver but in BK I'm stilling using teh 
> > > old driver.
> > 
> > I am the happy owner of a "Club"-branded Radeon9200 video card. Here
> > are my experiences using your diff.
> > 
> > My card has a PCI id of 5964. Here you can read the output of 'lspci
> > -vvv' for it:
> 
> My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
> of XFree PCI IDs list, making it much easier to keep in sync. It should
> also support the 9200.

I think your driver is an improvement over the old one, but:

- Could I2C be ported to kernel I2C api and separated?, so it use would not
require the fbdev module loaded.

- PCI IDs list should be in pci_ids.h as every other drivers, reality is
that adding new IDs to pci_ids.h is not hard so your driver will not be the
exception to the rule.

-solca


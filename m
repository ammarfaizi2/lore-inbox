Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUHDAwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUHDAwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 20:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267179AbUHDAwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 20:52:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:27298 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267168AbUHDAv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 20:51:26 -0400
Subject: Re: [PATCH] [2/3] PCI quirks -- PPC.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
In-Reply-To: <1091576440.12594.139.camel@imladris.demon.co.uk>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
	 <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
	 <1091564918.1922.9.camel@gaston>
	 <1091576440.12594.139.camel@imladris.demon.co.uk>
Content-Type: text/plain
Message-Id: <1091580566.1899.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 10:49:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 09:40, David Woodhouse wrote:
> On Wed, 2004-08-04 at 06:28 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2004-08-04 at 03:36, David Woodhouse wrote:
> > > Remove up the PPC pcibios_fixups[] array. Remove the ifdefs on
> > > CONFIG_PPC_PMAC in the kernel PPC code, moving that stuff into
> > > pmac-specific files where it lives. Add a quirk for the CardBus
> > > controller on WindRiver SBC8260.
> > 
> > Ah nice ! I didn't notice we had those DECLARE_PCI_FIXUP_* macros 
> > nowdays !
> 
> We don't. That was patch 1 of the 3 :)

Ok, that one wasn't CC'ed to me so I missed it ;)

Ben.



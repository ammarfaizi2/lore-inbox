Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266406AbUAVTqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266413AbUAVTqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:46:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:10399 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266406AbUAVTpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:45:07 -0500
Date: Thu, 22 Jan 2004 11:40:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ak@colin2.muc.de, sundarapandian.durairaj@intel.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, greg@kroah.com, vladimir.kondratiev@intel.com,
       harinarayanan.seshadri@intel.com
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-Id: <20040122114035.7af1c9bc.rddunlap@osdl.org>
In-Reply-To: <1074795663.1413.8.camel@dhcp23.swansea.linux.org.uk>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
	<20040122131258.GA84577@colin2.muc.de>
	<1074795663.1413.8.camel@dhcp23.swansea.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 18:21:04 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

| On Iau, 2004-01-22 at 13:12, Andi Kleen wrote:
| > > +#ifdef CONFIG_PCI_EXPRESS
| > > +	else if (!strcmp(str, "no_pcie")) {
| > 
| > Would "no_pciexp" be better? no_pcie looks nearly like a typo.
| 
| Other "nofoo" generally don't use "_" (Linux kernel really needs an
| actual policy document for such stuff tho)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Right, let's keep it consistent, like "nopciexp".

--
~Randy

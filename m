Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266668AbUAWTWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUAWTVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:21:41 -0500
Received: from gprs214-223.eurotel.cz ([160.218.214.223]:56192 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266657AbUAWTUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:20:07 -0500
Date: Fri, 23 Jan 2004 20:19:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ak@colin2.muc.de,
       sundarapandian.durairaj@intel.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, torvalds@osdl.org, greg@kroah.com,
       vladimir.kondratiev@intel.com, harinarayanan.seshadri@intel.com
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040123191928.GA1355@elf.ucw.cz>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com> <20040122131258.GA84577@colin2.muc.de> <1074795663.1413.8.camel@dhcp23.swansea.linux.org.uk> <20040122114035.7af1c9bc.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122114035.7af1c9bc.rddunlap@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> | On Iau, 2004-01-22 at 13:12, Andi Kleen wrote:
> | > > +#ifdef CONFIG_PCI_EXPRESS
> | > > +	else if (!strcmp(str, "no_pcie")) {
> | > 
> | > Would "no_pciexp" be better? no_pcie looks nearly like a typo.
> | 
> | Other "nofoo" generally don't use "_" (Linux kernel really needs an
> | actual policy document for such stuff tho)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Right, let's keep it consistent, like "nopciexp".

I'd call it "noexpress". pciexp sounds like PCI exception, PCI
expected or something...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

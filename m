Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVF1Hgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVF1Hgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVF1HeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:34:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:26548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261939AbVF1H3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:29:25 -0400
Date: Tue, 28 Jun 2005 00:29:13 -0700
From: Greg KH <greg@kroah.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, akpm@osdl.org
Subject: Re: pci transparent bridge resource management
Message-ID: <20050628072913.GA3438@kroah.com>
References: <20050628070636.GA10217@isilmar.linta.de> <20050628071345.GA3281@kroah.com> <20050628072224.GA11393@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628072224.GA11393@isilmar.linta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 09:22:24AM +0200, Dominik Brodowski wrote:
> On Tue, Jun 28, 2005 at 12:13:45AM -0700, Greg KH wrote:
> > On Tue, Jun 28, 2005 at 09:06:36AM +0200, Dominik Brodowski wrote:
> > > Hi!
> > > 
> > > Could we get the following two patches into Linus' tree as well? AFAIK,
> > > these alone didn't do any harm; they're most useful for yenta-style
> > > PCMCIA-PCI bridges instead... so I'd very much like to get them into 2.6.13.
> > > 
> > > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-collect-host-bridge-resources-01.patch
> > > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-handle-subtractive-decode.patch
> > 
> > No, not right now.  Ivan's reworking these patches, due to the number of
> > complaints in this area.  Give us a week or so...
> 
> The collect-resources-02 was the cause. Not the other ones, AFAIK, and they
> are even independent...

Not according to:
	http://bugme.osdl.org/show_bug.cgi?id=4737

One person said the -01 patch messed up their box...

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVF1HYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVF1HYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVF1HXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:23:08 -0400
Received: from isilmar.linta.de ([213.239.214.66]:40167 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261860AbVF1HWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:22:25 -0400
Date: Tue, 28 Jun 2005 09:22:24 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rajesh.shah@intel.com, akpm@osdl.org
Subject: Re: pci transparent bridge resource management
Message-ID: <20050628072224.GA11393@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	rajesh.shah@intel.com, akpm@osdl.org
References: <20050628070636.GA10217@isilmar.linta.de> <20050628071345.GA3281@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628071345.GA3281@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:13:45AM -0700, Greg KH wrote:
> On Tue, Jun 28, 2005 at 09:06:36AM +0200, Dominik Brodowski wrote:
> > Hi!
> > 
> > Could we get the following two patches into Linus' tree as well? AFAIK,
> > these alone didn't do any harm; they're most useful for yenta-style
> > PCMCIA-PCI bridges instead... so I'd very much like to get them into 2.6.13.
> > 
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-collect-host-bridge-resources-01.patch
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-handle-subtractive-decode.patch
> 
> No, not right now.  Ivan's reworking these patches, due to the number of
> complaints in this area.  Give us a week or so...

The collect-resources-02 was the cause. Not the other ones, AFAIK, and they
are even independent... But as you're confident that they'll eventually make
it into .13, I'm silent again...

	Dominik

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWBASAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWBASAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWBASAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:00:33 -0500
Received: from mail.dvmed.net ([216.237.124.58]:29843 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030393AbWBASAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:00:33 -0500
Message-ID: <43E0F73B.6040507@pobox.com>
Date: Wed, 01 Feb 2006 13:00:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI: restore 2 missing pci ids
References: <200602010609.k1169QDX017012@hera.kernel.org>
In-Reply-To: <200602010609.k1169QDX017012@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linux Kernel Mailing List wrote: > tree
	e425ac74afc0b89f3a513290a2dd5e503d974906 > parent
	654143ee3a73b2793350b039a135d9cd3101147b > author Mark Rustad
	<MRustad@mac.com> Fri, 06 Jan 2006 14:47:29 -0800 > committer Greg
	Kroah-Hartman <gregkh@suse.de> Wed, 01 Feb 2006 10:00:11 -0800 > >
	[PATCH] PCI: restore 2 missing pci ids > > Somewhere between 2.6.14 and
	2.6.15-rc3, some PCI ids were apparently > removed. The ecc.c module,
	which is not a part of the kernel.org tree, but > included in some
	distributions, fails to compile. > > Signed-off-by: Mark Rustad
	<mrustad@mac.com> > Signed-off-by: Andrew Morton <akpm@osdl.org> >
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de> > >
	include/linux/pci_ids.h | 2 ++ > 1 files changed, 2 insertions(+) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> tree e425ac74afc0b89f3a513290a2dd5e503d974906
> parent 654143ee3a73b2793350b039a135d9cd3101147b
> author Mark Rustad <MRustad@mac.com> Fri, 06 Jan 2006 14:47:29 -0800
> committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 01 Feb 2006 10:00:11 -0800
> 
> [PATCH] PCI: restore 2 missing pci ids
> 
> Somewhere between 2.6.14 and 2.6.15-rc3, some PCI ids were apparently
> removed.  The ecc.c module, which is not a part of the kernel.org tree, but
> included in some distributions, fails to compile.
> 
> Signed-off-by: Mark Rustad <mrustad@mac.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
>  include/linux/pci_ids.h |    2 ++
>  1 files changed, 2 insertions(+)

Why was this applied?  We could apply these patches all day, and get 
nothing else done.  If it's not in the kernel tree, we shouldn't be 
worrying about it.  Let the distros patch it in.

	Jeff



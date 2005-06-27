Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVF0GGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVF0GGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVF0GCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:02:36 -0400
Received: from isilmar.linta.de ([213.239.214.66]:65462 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261844AbVF0F7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:59:33 -0400
Date: Mon, 27 Jun 2005 07:59:31 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, rajesh.shah@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI-based PCI resources: PCMCIA bugfix, but resources missing in trees
Message-ID: <20050627055931.GA5387@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Grant Coady <grant_lkml@dodo.com.au>, Andrew Morton <akpm@osdl.org>,
	greg@kroah.com, rajesh.shah@intel.com, linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626140411.GA8597@dominikbrodowski.de> <06lub192nippc5a4fkju7gfr18kmv33aqn@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06lub192nippc5a4fkju7gfr18kmv33aqn@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 11:38:34AM +1000, Grant Coady wrote:
> On Sun, 26 Jun 2005 16:04:12 +0200, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> >On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
> >> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
> >>   the recent PCI breakage sorted out.
> >
> >pci-yenta-cardbus-fix.patch and the following patch should solve the
> >initialization time trouble. However, the ACPI-based PCI resource handling
> >is badly broken, IMHO:
> >
> 
> Well this patch doesn't do it for Toshiba laptop, ToPIC-100 ZV 
> bridge in 'auto' mode.

Does reverting
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/broken-out/gregkh-pci-pci-collect-host-bridge-resources-02.patch
help in your case?

	Dominik

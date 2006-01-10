Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWAJRDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWAJRDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWAJRDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:03:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932252AbWAJRDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:03:49 -0500
Date: Tue, 10 Jan 2006 17:03:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Maule <maule@sgi.com>
Cc: Greg KH <gregkh@suse.de>, Matthew Wilcox <matthew@wil.cx>,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20060110170339.GA2567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Maule <maule@sgi.com>, Greg KH <gregkh@suse.de>,
	Matthew Wilcox <matthew@wil.cx>, linuxppc64-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de> <20051222202627.GI17552@sgi.com> <20051222203415.GA28240@suse.de> <20051222203824.GJ17552@sgi.com> <20051222205023.GK2361@parisc-linux.org> <20060103032249.GA4957@sgi.com> <20060103060719.GA1845@suse.de> <20060110170032.GC18399@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110170032.GC18399@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, looks like it's going to be a bit until I have time to work on the
> vector allocation stuff.
> 
> In the mean time, would folks be recepteive to taking this portion of the
> initial patchset:
> 
> [PATCH 1/4] msi archetecture init hook
> http://lkml.org/lkml/2005/12/21/168
> 
> This would at least give us a graceful pci_enable_msi() failure on altix
> until I find the time to work on the other stuff.

Personally I think your patchkit should just go in after all the other
comments have addresses [1].  It's a huge improvement over the mess that's
there currently.

[1] I don't remember if you posted a patchkit addressing everything else yet,
so maybe it's been done already.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUEFN2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUEFN2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUEFN1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:27:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28591 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262279AbUEFN1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:27:13 -0400
Date: Thu, 6 May 2004 14:27:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Matthew Wilcox <willy@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Sourav Sen <souravs@india.hp.com>, Matt_Domsch@dell.com,
       matthew.e.tolentino@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506132711.GA2281@parcelfarce.linux.theplanet.co.uk>
References: <003801c43347$812a1590$39624c0f@india.hp.com> <20040506114414.A14543@infradead.org> <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk> <1083845904.3844.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083845904.3844.2.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 02:18:24PM +0200, Arjan van de Ven wrote:
> On Thu, 2004-05-06 at 13:59, Matthew Wilcox wrote:
> > On Thu, May 06, 2004 at 11:44:14AM +0100, Christoph Hellwig wrote:
> > > On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
> > > > Hi,
> > > > 
> > > > The following simple patch creates a read-only file
> > > > "memmap" under <mount point>/firmware/efi/ in sysfs
> > > > and exposes the efi memory map thru it.
> > > 
> > > doesn't exactly fit into the one value per file approach, does it?
> > 
> > It's not exactly modifiable. 
> 
> come on, it's the ideal hotplug memory interface ;)
> should we try to unify the memory map exports between architectures
> instead of matching the firmware-of-the-day for each architecture ??

Well, firmware-du-jour is what /sys/firmware/... is for ;-)

I don't have a clear picture of what a hotplug memory interface would look
like; and even if I did, I don't think the EFI memory map is of much help
in that matter.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUEFL7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUEFL7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUEFL7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:59:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261418AbUEFL7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:59:21 -0400
Date: Thu, 6 May 2004 12:59:19 +0100
From: Matthew Wilcox <willy@debian.org>
To: Christoph Hellwig <hch@infradead.org>, Sourav Sen <souravs@india.hp.com>,
       Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040506115919.GZ2281@parcelfarce.linux.theplanet.co.uk>
References: <003801c43347$812a1590$39624c0f@india.hp.com> <20040506114414.A14543@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506114414.A14543@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 11:44:14AM +0100, Christoph Hellwig wrote:
> On Thu, May 06, 2004 at 02:22:46PM +0530, Sourav Sen wrote:
> > Hi,
> > 
> > The following simple patch creates a read-only file
> > "memmap" under <mount point>/firmware/efi/ in sysfs
> > and exposes the efi memory map thru it.
> 
> doesn't exactly fit into the one value per file approach, does it?

It's not exactly modifiable.  I'm not sure what benefit we'd gain from
splitting this file into dozens.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

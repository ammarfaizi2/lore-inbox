Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJGNVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJGNVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUJGNVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:21:12 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:25609 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265029AbUJGNRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:17:37 -0400
Date: Thu, 7 Oct 2004 14:17:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, benh@kernel.crashing.org,
       paulus@samba.org, greg@kroah.com
Subject: Re: [Kernel-janitors] [PATCH 2.6][1/12] arch/ppc/kernel/pci.c replace pci_find_device with pci_get_device
Message-ID: <20041007141731.A11865@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@lists.osdl.org, benh@kernel.crashing.org,
	paulus@samba.org, greg@kroah.com
References: <298570000.1096930681@w-hlinder.beaverton.ibm.com> <20041005104443.A16871@infradead.org> <3550000.1097094201@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3550000.1097094201@w-hlinder.beaverton.ibm.com>; from hannal@us.ibm.com on Wed, Oct 06, 2004 at 01:23:21PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 01:23:21PM -0700, Hanna Linder wrote:
> --On Tuesday, October 05, 2004 10:44:43 AM +0100 Christoph Hellwig <hch@infradead.org> wrote:
> 
> > what about adding a for_each_pci_dev macro that nicely hides these AND_ID
> > iterations?
> > 
> 
> OK. How about this? Following are two patches that I used to test this
> new macro on my T23. I found roughly 54 other places this macro can
> be used.

Looks good to me

---end quoted text---

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVAHTPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVAHTPI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVAHTPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 14:15:07 -0500
Received: from verein.lst.de ([213.95.11.210]:44739 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261273AbVAHTPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 14:15:04 -0500
Date: Sat, 8 Jan 2005 20:14:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <roland@topspin.com>
Cc: Christoph Hellwig <hch@lst.de>, davej@redhat.com, hannal@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix pci_get_device conversion in intel-agp
Message-ID: <20050108191457.GA7131@lst.de>
References: <20050108190815.GA7031@lst.de> <52fz1b20qd.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fz1b20qd.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 11:13:14AM -0800, Roland Dreier wrote:
>     > +	if (intel_i810_private.i810_dev)
>     > +		pci_dev_put(intel_i810_private.i830_dev);
>     > +	if (intel_i810_private.i830_dev)
>     > +		pci_dev_put(intel_i830_private.i830_dev);
> 
> Is there a typo in the patch here -- should the first put be for i810_dev?

Yes.


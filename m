Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUI2W3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUI2W3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUI2W24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:28:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269132AbUI2W22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:28:28 -0400
Date: Wed, 29 Sep 2004 23:28:25 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       kraxel@bytesex.org
Subject: Re: [Kernel-janitors] Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <20040929222825.GK16153@parcelfarce.linux.theplanet.co.uk>
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com> <20040929220344.A17872@infradead.org> <20040929211135.GA24407@kroah.com> <17920000.1096494218@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17920000.1096494218@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 02:43:38PM -0700, Hanna Linder wrote:
> +	return(pci_module_init(&bttv_pci_driver));

Why the extra brackets?  I see their use for

	return (a == b);

but

	return pci_module_init(&bttv_pci_driver);

isn't at all ambiguous.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

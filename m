Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269017AbUI2VDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269017AbUI2VDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUI2VDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:03:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:56068 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269017AbUI2VDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:03:53 -0400
Date: Wed, 29 Sep 2004 22:03:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       greg@kroah.com, kraxel@bytesex.org
Subject: Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <20040929220344.A17872@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@lists.osdl.org, greg@kroah.com, kraxel@bytesex.org
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15470000.1096491322@w-hlinder.beaverton.ibm.com>; from hannal@us.ibm.com on Wed, Sep 29, 2004 at 01:55:22PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 01:55:22PM -0700, Hanna Linder wrote:
> 
> As pci_find_device is going away need to replace it. This file did not use the dev returned
> from pci_find_device so is replaceable by pci_dev_present. I was not able to test it
> as I do not have the hardware.

I think this check should just go away completely.  

We don't have such silly warnings in any other driver.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVAKWo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVAKWo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVAKWnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:43:22 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:30691 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262874AbVAKWm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:42:29 -0500
Date: Tue, 11 Jan 2005 14:42:17 -0800
From: Greg KH <greg@kroah.com>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C support for Intel ICH7 - 2.6.10 - resubmit
Message-ID: <20050111224217.GB19173@kroah.com>
References: <200501060947.14595.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501060947.14595.jason.d.gaston@intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 09:47:14AM -0800, Jason Gaston wrote:
> This patch adds the Intel ICH7 DID to the i2c-i801.c driver and adds
> an entry to Kconfig for I2C(SMBus) support. ?  Note: This patch relies
> on the already submitted and accepted PATA patch to pci_ids.h
> containing all ICH7 DID's.
> If acceptable, please apply. 

I rediffed the second part by hand, due to some other changes (pci ids
are better expressed the PCI_DEVICE() macro.) and applied it.

thanks,

greg k-h

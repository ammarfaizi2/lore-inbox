Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUAHQzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUAHQzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:55:49 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:42767 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265558AbUAHQzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:55:48 -0500
Date: Thu, 8 Jan 2004 16:55:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Meadors <clubneon@hereintown.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MegaRAID on AMD64 under 2.6.1
Message-ID: <20040108165545.A12313@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Meadors <clubneon@hereintown.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1073512887.8211.39.camel@clubneon.priv.hereintown.net> <20040108121227.B8987@infradead.org> <1073580718.8870.45.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073580718.8870.45.camel@clubneon.priv.hereintown.net>; from clubneon@hereintown.net on Thu, Jan 08, 2004 at 11:51:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 11:51:58AM -0500, Chris Meadors wrote:
> It looks like megaraid_probe_one() only gets called if
> megaraid_pci_tbl[] contains the right IDs.

Yupp.

> i.e. PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3
> 
> When I added the lines for that combination to megaraid_pci_tbl[], the
> driver found the card.  So, I'm cool now.

Care to send a patch to Linus to add it?  And my apologies for losing
that entry. 


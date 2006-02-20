Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWBTWxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWBTWxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWBTWxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:53:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64717 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932689AbWBTWxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:53:38 -0500
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francesco Biscani <biscani@pd.astro.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602202226.43772.biscani@pd.astro.it>
References: <1140445182.26526.1.camel@localhost.localdomain>
	 <200602202226.43772.biscani@pd.astro.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Feb 2006 22:57:07 +0000
Message-Id: <1140476227.26526.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-20 at 22:26 +0100, Francesco Biscani wrote:
> The CDROM on the second ide channel was not recognized (what's up with that 
> WARNING?). And the HD was pretty slow (around 1-2 MB/s), I guess that's 
> because UDMA support is not there yet?

UDMA support is there and was selected. Older chip revisions have
special handing for LBA48 (large disks/large requests) but I thought I
had that all sorted now so wouldn't expect such a hit.

Please send me an lspci -vxx

Thanks.


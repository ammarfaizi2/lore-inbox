Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWJQNGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWJQNGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWJQNGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:06:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30672 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750870AbWJQNGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:06:12 -0400
Subject: Re: [PATCH] pata_marvell: Marvell 6101/6145 PATA driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <45341A59.6000402@pobox.com>
References: <1161013206.24237.85.camel@localhost.localdomain>
	 <20061016163134.4560d253.akpm@osdl.org>  <45341A59.6000402@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 14:32:35 +0100
Message-Id: <1161091955.24237.163.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 19:48 -0400, ysgrifennodd Jeff Garzik:
> > hm.  pci_resource_start() returns a possibly-64-bit resource_size_t
> > nowadays.  But ioremap() doesn't know how to remap such a thing.
> 
> These days, pci_iomap() should be used anyway.

Updated to pci_iomap and will push that next time around


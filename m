Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWCUKNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWCUKNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWCUKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:13:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62626 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932383AbWCUKNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:13:33 -0500
Subject: Re: [git patches] libata updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <441F52F7.8030309@garzik.org>
References: <20060320111658.GA16172@havoc.gtf.org>
	 <1142872556.21455.7.camel@localhost.localdomain>
	 <441F52F7.8030309@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Mar 2006 10:20:20 +0000
Message-Id: <1142936420.21455.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-20 at 20:12 -0500, Jeff Garzik wrote:
> In my [no doubt warped] brain, I equate the SFF-8038 interface to "PCI 
> IDE BMDMA", and from there, view most hardware as a subset of PCI IDE 
> BMDMA.  It might not do DMA, might not be PCI, might not do irqs, but 
> most PATA hardware seems able to be driven by a "bmdma driver".  Thus, 
> the name :)

Most of that file is ST-506 type register interfaces, only a tiny bit is
SFF PCI IDE with DMA.

Expect some patches soon. I've got my tree merged against the git tree
now, just needs some testing.

Alan


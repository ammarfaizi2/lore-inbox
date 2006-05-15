Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWEOX2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWEOX2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEOX2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:28:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46771 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750757AbWEOX2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:28:03 -0400
Subject: Re: [RFT] major libata update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4469081D.7080608@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org>
	 <20060515230256.GB4699@animx.eu.org>  <4469081D.7080608@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 00:40:51 +0100
Message-Id: <1147736451.26686.227.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 19:00 -0400, Jeff Garzik wrote:
> Always helpful.  ata_piix should support Intel PATA controllers, modulo 
> some bugs that Alan is fixing / has fixed.  If your PCI ID isn't listed, 
> you will have to add it, and an associated info entry.  Again, take a 
> look at Alan's libata PATA patches for guidance.

Without the patches I've got everything non ATAPI should work (ATAPI
will I think 99% work) and anything that is ICH or later (UDMA66 or
higher) should behave correctly.

PIIX/MPIIX won't work with it, and UDMA33 chips may work providing the
scribbles to the wrong register happen to be harmless.

Alan


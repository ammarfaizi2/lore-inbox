Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbUCZBiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUCZBiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 20:38:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27612 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263856AbUCZBhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 20:37:21 -0500
Message-ID: <40638943.9010206@pobox.com>
Date: Thu, 25 Mar 2004 20:37:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sata] Promise PATA port on PDC2037x SATA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anybody wanna give this a quick test?  It doesn't actually _do_ anything 
yet, except attempt to detect the PATA port.

Latest libata...

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-libata14.patch.bz2

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc2-bk6-libata1.patch.bz2

BitKeeper repositories:
	http://gkernel.bkbits.net/libata-2.[46]

The latter 2.6 patch applies to the current BK tree, will be -bk6 when 
that snapshot is generated tonight.  It _should_ apply to earlier 
2.6.5-rc2, but applying to earlier kernels you -may- need to 
s/pci_dma_mapping_error/pci_dma_error/, or completely remove the 
pci_dma_[mapping_]error() check.

	Jeff





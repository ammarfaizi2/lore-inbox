Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757654AbWKXREH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654AbWKXREH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 12:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757800AbWKXREH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 12:04:07 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:48556 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1757654AbWKXREE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 12:04:04 -0500
Date: Fri, 24 Nov 2006 17:03:59 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: Removal of pci_dma_* functions
Message-ID: <20061124170359.GA9355@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A grep for

  pci_dac_dma_supported()
  pci_dac_page_to_dma()
  pci_dac_dma_to_page()
  pci_dac_dma_to_offset()
  pci_dac_dma_sync_single_for_cpu()
  pci_dac_dma_sync_single_for_device()

reveals that only a some platforms implement these functions and there seems
to be no single user.  Any objections against removing?  Or why did we ever
add them anyay ...

  Ralf

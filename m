Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWJPKdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWJPKdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWJPKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:33:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56538 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750825AbWJPKdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:33:17 -0400
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, matthew@wil.cx, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <200610151716.36337.david-b@pacbell.net>
References: <1160161519800-git-send-email-matthew@wil.cx>
	 <200610151545.59477.david-b@pacbell.net>
	 <20061015161834.f96a0761.akpm@osdl.org>
	 <200610151716.36337.david-b@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 11:59:53 +0100
Message-Id: <1160996393.24237.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-15 am 17:16 -0700, ysgrifennodd David Brownell:
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Acked-by: Alan Cox <alan@redhat.com>
> 
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -499,7 +499,7 @@ int __must_check pci_enable_device_bars(
>  void pci_disable_device(struct pci_dev *dev);
>  void pci_set_master(struct pci_dev *dev);
>  #define HAVE_PCI_SET_MWI
> -int __must_check pci_set_mwi(struct pci_dev *dev);
> +int pci_set_mwi(struct pci_dev *dev);
>  void pci_clear_mwi(struct pci_dev *dev);
>  void pci_intx(struct pci_dev *dev, int enable);
>  int pci_set_dma_mask(struct pci_dev *dev, u64 mask);

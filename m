Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUFNV5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUFNV5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFNV5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:57:36 -0400
Received: from havoc.gtf.org ([216.162.42.101]:55947 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264519AbUFNV5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:57:34 -0400
Date: Mon, 14 Jun 2004 17:57:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: David Eger <eger@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcibios_write_config_dword()?  porting drivers to 2.6
Message-ID: <20040614215732.GA29550@havoc.gtf.org>
References: <20040614214554.GA25127@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614214554.GA25127@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 05:45:54PM -0400, David Eger wrote:
> I've been working on a port of the Cirrus Logic framebuffer driver to
> Linux 2.6, and stumbled upon the line:
> 
>       pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0,
>          0x00000000);
> 
> What did this used to mean?  It's been deleted as old cruft in 2.6...

pci_write_config_dword

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUFNVsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUFNVsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUFNVq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:46:56 -0400
Received: from havoc.gtf.org ([216.162.42.101]:42635 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264519AbUFNVp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:45:56 -0400
Date: Mon, 14 Jun 2004 17:45:54 -0400
From: David Eger <eger@havoc.gtf.org>
To: Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: pcibios_write_config_dword()?  porting drivers to 2.6
Message-ID: <20040614214554.GA25127@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on a port of the Cirrus Logic framebuffer driver to
Linux 2.6, and stumbled upon the line:

      pcibios_write_config_dword (0, pdev->devfn, PCI_BASE_ADDRESS_0,
         0x00000000);

What did this used to mean?  It's been deleted as old cruft in 2.6...

-dte

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUFPQew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUFPQew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUFPQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:34:52 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16569 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264164AbUFPQeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:34:46 -0400
Date: Wed, 16 Jun 2004 17:34:15 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - via_agp.c: VP3 souldn't work /  "Detected VIA %s chipset" fails (kernel 2.6.7)
Message-ID: <20040616163415.GA16097@redhat.com>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Carsten Rietzschel <cr7@os.inf.tu-dresden.de>,
	linux-kernel@vger.kernel.org
References: <200406161732.23630.cr7@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406161732.23630.cr7@os.inf.tu-dresden.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 05:32:23PM +0200, Carsten Rietzschel wrote:

 > The attached patch:
 > - adds ID(PCI_DEVICE_ID_VIA_82C597_0) to pci_device_id agp_via_pci_table[]

Applied, thanks.

 > - it compares the correct number of entries in both tables in init-function
 >   (agp_via_pci_table vs. via_agp_device_ids), if it doesn't match in prints a 
 >   warning 
 >   <--- this is not neccessary, but  just to be sure :)

I didn't like this bit, so dropped.

Thanks again.

		Dave


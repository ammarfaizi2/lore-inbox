Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTJVLFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTJVLFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:05:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28835 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263522AbTJVLFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:05:21 -0400
Date: Wed, 22 Oct 2003 03:59:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] pci_dma_sync_to_device
Message-Id: <20031022035949.6b6e59b0.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310211151000.4246-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0310211151000.4246-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 12:37:13 +0200 (CEST)
Martin Diehl <lists@mdiehl.de> wrote:

> following your suggestion this patch adds the missing 
> pci_dma_sync_to_device_{single,sg} call to sync streaming write buffers 
> after cpu modification. Like other pci dma calls it's a pci specific 
> wrapper plus corresponding generic function in asm-i386/dma-mapping.h. 
> Other platforms still need their individual implementations.
> 
> Patch below is against 2.6.0-test8. Testing was done using a modified 
> version of the vlsi_ir driver which calls pci_dma_to_device_single instead 
> of a private implementation.

Thanks a lot Martin, I promise to make more forward progress
with this work between now and the end of the weekend.

Thanks again.

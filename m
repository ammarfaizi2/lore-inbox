Return-Path: <linux-kernel-owner+w=401wt.eu-S1750842AbXAKQl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXAKQl5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXAKQl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:41:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43434 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750725AbXAKQl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:41:56 -0500
Date: Thu, 11 Jan 2007 16:48:53 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let BLK_DEV_AMD74XX depend on X86
Message-ID: <20070111164853.5de4ddfa@localhost.localdomain>
In-Reply-To: <20070111134917.GE20027@stusta.de>
References: <20070111134917.GE20027@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 14:49:17 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> It's unlikely that this driver will ever be of any use on other 
> architectures.
> 
> This fixes the following compile error on ia64:

NAK

pci_get_legacy_ide_irq() is a required method for all platforms and is
usually filled in by asm-generic/pci.h

Please fix the IA64 tree to do the right thing.

Alan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUIPWW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUIPWW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIPWVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:21:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:59794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268113AbUIPWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:20:43 -0400
Date: Thu, 16 Sep 2004 15:24:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: adaplas@pol.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1: Setting IDE DMA fails
Message-Id: <20040916152429.72f57281.akpm@osdl.org>
In-Reply-To: <200409170534.24034.adaplas@hotpop.com>
References: <200409170534.24034.adaplas@hotpop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
> Hi,
> 
> IDE DMA setting fails in 2.6.9-rc2-mm1 with the ff. dmesg:
> ...
> VP_IDE: IDE controller at PCI slot 0000:00:11.1
> ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
> ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
> VP_IDE: (ide_setup_pci_device:) Could not enable device.
> ...
> 
> Reversing the following patches fixed it for me:
> 
> incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch
> incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi-fix.patch
> incorrect-pci-interrupt-assignment-on-es7000-for-platform-gsi.patch
> 

Yeah, those patches didn't work out.  I've asked Natalie to work on them
with Len.  Thanks.


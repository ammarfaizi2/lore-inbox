Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbULVUSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbULVUSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 15:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbULVUSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 15:18:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61878 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262019AbULVUSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 15:18:06 -0500
Message-ID: <41C9D679.70209@pobox.com>
Date: Wed, 22 Dec 2004 15:18:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Broustinov <edichka@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can't activate dma on ide/sata under 2.6.5/9 + Intel E7520 chipset
References: <1103708275.570197.31660@z14g2000cwz.googlegroups.com>	 <20041222094014.B5A1E5F727@attila.bofh.it> <641bfad604122201527736eca6@mail.gmail.com>
In-Reply-To: <641bfad604122201527736eca6@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Broustinov wrote:
> Hi,
> hdparm -d1 /dev/hda (or /dev/sda) returns "HDIO_SET_DMA failed:
> Operation not permitted" on both disks. 
> Is it possible that there's no (full?) support for ICH5-R in those kernels?
> The motherboard is Intel SE7520BD2, exact kernel versions which were
> tried are:
> 2.6.9-1.667smp #1 SMP Tue Nov 2 15:09:11 EST 2004 x86_64 x86_64 x86_64
> GNU/Linux (FC3 64bit)
> 2.6.5-1.358smp #1 SMP Sat May 8 09:28:14 EDT 2004 x86_64 x86_64 x86_64
> GNU/Linux (FC2 64bit)
> 
> 2.4.21/22 (RH9) and 2.6.7* (AS3.0) do not show this problem on the board.
> 
> Does anybody have any idea/patch/hack?

If you are using libata (/dev/sdX), then DMA is unconditionally enabled.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbTF3WFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265918AbTF3WFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:05:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63120
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265915AbTF3WFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:05:13 -0400
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030630221542.GA17416@alf.amelek.gda.pl>
References: <20030630221542.GA17416@alf.amelek.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057011399.17567.50.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2003 23:16:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-30 at 23:15, Marek Michalkiewicz wrote:
> Hi,
> 
> After upgrading the kernel from 2.4.20 to 2.4.21, sometimes I see
> the following messages:
> 
> hda: dma_timer_expiry: dma status == 0x24
> hda: lost interrupt
> hda: dma_intr: bad DMA status (dma_stat=30)
> hda: dma_intr: status=0x50 { DriveReady SeekComplete }

Does it happen if you disable local apic support ?


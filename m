Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVKIPVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVKIPVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbVKIPVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:21:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61633 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750706AbVKIPVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:21:21 -0500
Subject: Re: PATCH: libata PATA patches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4371FA47.1070806@ru.mvista.com>
References: <1131460386.25192.45.camel@localhost.localdomain>
	 <4371FA47.1070806@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Nov 2005 15:52:17 +0000
Message-Id: <1131551537.6540.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-09 at 16:31 +0300, Sergei Shtylylov wrote:
>     I found somewhat strange that you check for 0xABCDExxx signature in 32-bit 
> PCI config. reg. 0x78 while HighPoint's own drivers read BM reg. 0x90 (i.e. 
> PCI config. 0x70) for that. PCI reg. 0x7A is DPLL precision adjust reg. and 
> 0x7B is the input clock select and IRQ reg., so it'd be quite strange if the 
> BIOS used them for any kind of signature...

Yeah thats a bug. What I get for reading the comments in the old driver
and not double checking against the HPT reference code. Thanks

Alan


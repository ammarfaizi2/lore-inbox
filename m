Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVK0STU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVK0STU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVK0STU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:19:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10409 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751133AbVK0STT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:19:19 -0500
Subject: Re: memory allocation for DMA operations from network interface
From: Arjan van de Ven <arjan@infradead.org>
To: Mateusz Berezecki <mateuszb+lkml@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <aec8d6fc0511271006v265a3537r6a90e7d53f706d26@mail.gmail.com>
References: <aec8d6fc0511271006v265a3537r6a90e7d53f706d26@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 19:19:15 +0100
Message-Id: <1133115556.2853.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 19:06 +0100, Mateusz Berezecki wrote:
> Hello List,
> 
> My question is about DMA transfers from network device. I suspect
> these transfers require allocating physically contiguous memory 
> blocks. What is the proper way to allocate such contiguous memory for
> DMA purposes inside the kernel? Also what is the proper and
> architecture independent way to convert virtual address to physical
> one?

see Documentation/DMA-mapping.txt



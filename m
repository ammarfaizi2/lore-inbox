Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRHTTYj>; Mon, 20 Aug 2001 15:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRHTTY3>; Mon, 20 Aug 2001 15:24:29 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:22289 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S268922AbRHTTYW>; Mon, 20 Aug 2001 15:24:22 -0400
Message-ID: <000801c129ad$c50c8e60$0200a8c0@home.lan>
From: "Chris Pockele" <chrisp@newmail.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15Yrzo-0006LI-00@the-village.bc.nu>
Subject: Re: sound crashes in 2.4
Date: Mon, 20 Aug 2001 21:24:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you try one other thing.
> 
> Edit drivers/pci/quirks.c
> 
> find 
> 
> int isa_dma_bridge_buggy; /* Exported */
> 
> and make it read
> 
> int isa_dma_bridge_buggy = 1;
> 
> recompile reboot and see if it helps
> 
Unfortunately, it does not help.  The machine rebooted
suddenly (i forgot to mention that: sometimes it reboots
too, but mostly it just hangs).

btw the system doesn't have a PCI bus, so its kernel
does not have PCI support enabled

(it's a SIS85C471B-based ISA/VLB motherboard)


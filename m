Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbRGCPg5>; Tue, 3 Jul 2001 11:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbRGCPgi>; Tue, 3 Jul 2001 11:36:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264779AbRGCPgd>; Tue, 3 Jul 2001 11:36:33 -0400
Subject: Re: Memory access
To: guillaumelancelin@yahoo.es (=?iso-8859-1?q?Guillaume=20Lancelin?=)
Date: Tue, 3 Jul 2001 16:33:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010703144532.11007.qmail@web4201.mail.yahoo.com> from "=?iso-8859-1?q?Guillaume=20Lancelin?=" at Jul 03, 2001 04:45:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HSBD-0007s3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My question: is the kernel using or protecting this area of the memory,
> and is there a way to deprotect it??? (how dangerous!)

The kernel maps ISA space at different addresses. What address and how it is
accessed depends on the CPU and system

	isa_readb/readw/readl(addr)
	isa/writeb/writew/writel(value,addr)

to read/write 8,16,32 bit values 


	

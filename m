Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277220AbRJDUsZ>; Thu, 4 Oct 2001 16:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277222AbRJDUsL>; Thu, 4 Oct 2001 16:48:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46607 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277220AbRJDUsE>; Thu, 4 Oct 2001 16:48:04 -0400
Subject: Re: Whining about 2.5 (was Re: [PATCH] Re: bug? in using generic read/write functions to read/write block devices in 2.4.11-pre2O
To: landley@trommello.org
Date: Thu, 4 Oct 2001 21:53:06 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <01100318274901.00728@localhost.localdomain> from "Rob Landley" at Oct 03, 2001 06:27:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFUQ-00045y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there really a NUMA machine out there where you can DMA out of another 
> node's 16 bit ISA space?  So far the differences in the zones seem to be 

DMA engines are tied to the node the device is tied to not to the processor
in question in most NUMA systems.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288760AbSAQOGv>; Thu, 17 Jan 2002 09:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288765AbSAQOGm>; Thu, 17 Jan 2002 09:06:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288760AbSAQOG1>; Thu, 17 Jan 2002 09:06:27 -0500
Subject: Re: [patch] VAIO irq assignment fix
To: jes@trained-monkey.org (Jes Sorensen)
Date: Thu, 17 Jan 2002 14:18:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <15430.55835.417188.484427@trained-monkey.org> from "Jes Sorensen" at Jan 17, 2002 09:05:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RDMy-0003W6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan> Surely pci_enable_device should do that anyway?
> 
> The problem is that the interrupt is not set in the PIRQ table so if we
> don't shoehorn it in, the interrupt source wont be found.

What happens if you use the current ACPI patch btw ?


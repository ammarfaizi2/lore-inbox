Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288747AbSAQODB>; Thu, 17 Jan 2002 09:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288760AbSAQOCw>; Thu, 17 Jan 2002 09:02:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288747AbSAQOCi>; Thu, 17 Jan 2002 09:02:38 -0500
Subject: Re: [patch] VAIO irq assignment fix
To: jes@wildopensource.com (Jes Sorensen)
Date: Thu, 17 Jan 2002 14:14:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <15430.5138.319243.798770@trained-monkey.org> from "Jes Sorensen" at Jan 16, 2002 07:00:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RDJS-0003Ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have gotten a Sony VAIO R505TL laptop which has a Richo RL5C574
> Cardbus controller however the broken bios doesn't assign an irq to the
> controller even though it is attached.

Surely pci_enable_device should do that anyway?

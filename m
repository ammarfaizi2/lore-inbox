Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRIFNRt>; Thu, 6 Sep 2001 09:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270646AbRIFNRj>; Thu, 6 Sep 2001 09:17:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37646 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270645AbRIFNR0>; Thu, 6 Sep 2001 09:17:26 -0400
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow?
To: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 6 Sep 2001 14:21:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010906150451.A5256@bytesex.org> from "Gerd Knorr" at Sep 06, 2001 03:04:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ez6A-00086y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW:  There is another issue I've noticed on my Desktop box, where I'm
> not sure what the best way to deal with:  Some pnpbios-reported I/O
> ranges clash with stuff reserved by pci quirks:

Thats fine. Quirks is there to register stuff that might otherwise get
stomped, pnp bios serves that purpose too. We just need to avoid warning
printks


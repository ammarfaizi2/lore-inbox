Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752989AbWKFMrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbWKFMrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbWKFMrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:47:43 -0500
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:24707 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1752992AbWKFMrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:47:42 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Wilco Beekhuizen <wilcobeekhuizen@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 12:47:33 +0000
Message-Id: <1162817254.5460.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Mon, 2006-11-06 at 12:38 +0100, Wilco Beekhuizen wrote:
> Hi, since 2.6.17.17 in drivers/pci/quirks.c (quirk_via_irq) all VIA
> chipsets are listed seperately instead of the "include everything"
> PCI_ANY_ID.
> 
> This is however problematic with my chipset.
> The ethernet controller, a VT6102 (Rhine-II) and the audio controller,
> VT8233/A/8235/8237 need a fix to work.
> Including PCI_ANY_ID again fixes these problems but is of course a
> pretty evil fix. The problem is I can't find out which PCI ids to
> include. I'm new to this list so suggestions are welcome.

this is the latest patch 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/via-irq-quirk-behaviour-change.patch
about this issue please try it and report the experience :) 


> 
> Wilco
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


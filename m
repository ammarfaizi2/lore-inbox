Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbQLLAjC>; Mon, 11 Dec 2000 19:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbQLLAiw>; Mon, 11 Dec 2000 19:38:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34065 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131368AbQLLAin>; Mon, 11 Dec 2000 19:38:43 -0500
Subject: Re: [PATCH] ide-pci.c: typo
To: 0@pervalidus.net (Frédéric L . W . Meunier)
Date: Tue, 12 Dec 2000 00:10:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001211212027.A1245@pervalidus> from "Frédéric L . W . Meunier" at Dec 11, 2000 09:20:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145d1i-0000NT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
> -		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
> +		printk("%s: not 100% native mode: will probe irqs later\n", d->name);
>  		pciirq = ide_special_settings(dev, d->name);

I disagree with the patch. The bug is in printk


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

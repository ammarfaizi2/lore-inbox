Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQJ3O76>; Mon, 30 Oct 2000 09:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJ3O7t>; Mon, 30 Oct 2000 09:59:49 -0500
Received: from web.sajt.cz ([212.71.160.9]:6409 "EHLO web.sajt.cz")
	by vger.kernel.org with ESMTP id <S129042AbQJ3O7h>;
	Mon, 30 Oct 2000 09:59:37 -0500
Date: Mon, 30 Oct 2000 15:58:33 +0100 (CET)
From: pavel rabel <pavel@web.sajt.cz>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-net@vger.kernel.org,
        netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <39FD3CB6.2F641BBF@yahoo.com>
Message-ID: <Pine.LNX.4.21.0010301551060.13164-100000@web.sajt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2000, Paul Gortmaker wrote:

> There is no urgency in trying to squeeze a patch like this in the back
> door of a 2.4.0 release.  For example, there are people out there now
> who are using the ne.c driver to run both ISA and PCI cards in the same 
> box without having to use 2 different drivers.  We can wait until 2.5.0
> to break their .config file.

I am not quite sure how it will work when you try to use both ne.c and
ne2k-pci drivers in the same box. Which driver will be used for PCI card?
Maybe people with both cards are forced to use inferior driver for PCI
card.

Pavel Rabel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

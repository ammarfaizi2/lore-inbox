Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQLBT4R>; Sat, 2 Dec 2000 14:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130168AbQLBT4H>; Sat, 2 Dec 2000 14:56:07 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:14616 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129886AbQLBTzr>; Sat, 2 Dec 2000 14:55:47 -0500
Date: Sat, 2 Dec 2000 13:25:19 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Wolfgang Spraul <wspraul@q-ag.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: hangs while "Probing PCI hardware" for Sony Vaio C1VE (Crusoe)
In-Reply-To: <975784798.3a294b5eb738e@ssl.local>
Message-ID: <Pine.LNX.3.96.1001202132310.1450D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2000, Wolfgang Spraul wrote:
> PhoenixBIOS, Sony Vaio C1VE
> 
> I did some printk() debugging, but the kernel hangs at various places in
> pci_setup_device(), mostly in pci_read_bases().

This is a Transmeta laptop, right?

See the recent thread with "Transmeta" in the subject.  The problem
seems to have been identified, and hopefully the fix will appear in
test12-pre4, when released...

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbQLBU7y>; Sat, 2 Dec 2000 15:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130440AbQLBU7o>; Sat, 2 Dec 2000 15:59:44 -0500
Received: from colorfullife.com ([216.156.138.34]:26378 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130348AbQLBU71>;
	Sat, 2 Dec 2000 15:59:27 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Subject: Re: 2.4.0-test11: hangs while "Probing PCI hardware" for Sony Vaio C1VE (Crusoe)
Message-ID: <975789131.3a295c4be5dee@ssl.local>
Date: Sat, 02 Dec 2000 21:32:11 +0100 (CET)
From: Wolfgang Spraul <wspraul@q-ag.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001202132310.1450D-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <Pine.LNX.3.96.1001202132310.1450D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 172.26.20.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the C1VE has a Crusoe processor (5600 stepping 03).
I didn't find the "Transmeta" thread, though.
test12-pre still has the problem. And to change the PCI access from <Any> to
<BIOS> or <Direct> doesn't help either.
In the thread you mentioned, did they post any patches?
Wolfgang

Quoting Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>:

> On Sat, 2 Dec 2000, Wolfgang Spraul wrote:
> > PhoenixBIOS, Sony Vaio C1VE
> > 
> > I did some printk() debugging, but the kernel hangs at various places
> in
> > pci_setup_device(), mostly in pci_read_bases().
> 
> This is a Transmeta laptop, right?
> 
> See the recent thread with "Transmeta" in the subject.  The problem
> seems to have been identified, and hopefully the fix will appear in
> test12-pre4, when released...
> 
> 	Jeff
> 
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbREHWmH>; Tue, 8 May 2001 18:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135575AbREHWl5>; Tue, 8 May 2001 18:41:57 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:971 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S135548AbREHWlo>; Tue, 8 May 2001 18:41:44 -0400
Date: Tue, 08 May 2001 15:38:09 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_pool_free from IRQ
To: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Pete Zaitcev <zaitcev@redhat.com>, johannes@erdfelt.com,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Message-id: <050701c0d80f$8f876ca0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
 <E14xFD5-0000hh-00@the-village.bc.nu>
 <15096.27479.707679.544048@pizda.ninka.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete's patch to pci_pool_free() is fine with me, and I'd be glad
to see that bit of pci interface cleaned up.  Any changes needed
other than the pci.txt doc update?

- Dave

----- Original Message -----
From: "David S. Miller" <davem@redhat.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>; "Pete Zaitcev" <zaitcev@redhat.com>;
<david-b@pacbell.net>; <johannes@erdfelt.com>; <rmk@arm.linux.org.uk>;
<linux-kernel@vger.kernel.org>
Sent: Tuesday, May 08, 2001 2:55 PM
Subject: Re: pci_pool_free from IRQ


>
> Alan Cox writes:
>  > I suspect we should fix the documentation (and if need be the code) to reflect
>  > the fact that you have to be completely out of your tree to handle device
>  > removal in the irq handler
>
> Agreed.
>
> Later,
> David S. Miller
> davem@redhat.com


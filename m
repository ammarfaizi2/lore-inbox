Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUFWCnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUFWCnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266081AbUFWCnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:43:43 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:2240 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S265087AbUFWCnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:43:41 -0400
Date: Tue, 22 Jun 2004 20:38:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Don't want to share interrupts
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <010601c458cb$5ea2cef0$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.fgubnj1.o18lhn@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only reason I can see for the IRQ allocation to be different is that one OS
is using APIC and the other is not..



----- Original Message ----- 
From: <gin@ginandtonic.ca>
Newsgroups: fa.linux.kernel
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, June 22, 2004 7:38 AM
Subject: Don't want to share interrupts


> I have been trying to get some platforms to work with a quad port
> Ethernet card.
> Some hardware is OK, others...well, not so OK.
>
> An IBM x335 works OK under Linux (2.4.9) and Win2K3
> An IBM x365 Does not work under Linux.
>
> Looks like Linux shares an IRQ between all 4 ports whereas win2k3
> doesn't .... each is assigned it's own IRQ.  Is there anyway to
> duplicate this behavior under Linux? (i.e. have an IRQ assigned to each
> port instead of sharing one for the whole card?).
>
> Thanks,
>
> -Garreth-
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


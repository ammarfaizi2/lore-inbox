Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268550AbRGYJoR>; Wed, 25 Jul 2001 05:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268551AbRGYJoG>; Wed, 25 Jul 2001 05:44:06 -0400
Received: from staf.steva.nl ([213.84.5.97]:41227 "HELO charon.staf.steva.nl")
	by vger.kernel.org with SMTP id <S268550AbRGYJn6>;
	Wed, 25 Jul 2001 05:43:58 -0400
Message-ID: <000e01c114ee$4ade2910$140bc90a@delphi>
From: "Jordi Verwer" <jordiv@steva.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <E15P6QK-0000aq-00@the-village.bc.nu>
Subject: Re: Externally transparent routing
Date: Wed, 25 Jul 2001 11:43:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> And what happens if you get a routing loop ?
Bad Things would happen, but I only have one router and since it's a NAT box
it isn't very likely to end up in a routing loop anyway.

> A NAT box really does need to drop the TTL. Nothing stops you giving it a
> more bizarre name, or indeed you can do what a few folks have found
> excruciatingly funny to do to tracerouters which is to spoof totally bogus
> icmp unreachables so they see crazy paths
What I wanted to do was be able to send my traceroutes to websites that
don't function properly, but since my NAT box is headless and I'd like to
avoid the hassle of SSH-ing to it, I do these traceroutes from one of my
internal machines. If I don't manually remove my NAT box from the list, the
braindead webmaster will allways blame my NAT box (which naturally is
innocent;)). But I suppose you do not want this to be possible. That is
understandable, but still BSD has a very clean implementation of
transrouting and I see no reason not to let Linux do this.

Jordi Verwer
P.S.: I adjust my computer's (which isn't mine btw, but belongs to my
"boss") date.
P.P.S.: Still not subscribed, so please CC any replies to me. Thank you.


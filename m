Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRFQPji>; Sun, 17 Jun 2001 11:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbRFQPj2>; Sun, 17 Jun 2001 11:39:28 -0400
Received: from p61.nas1.is5.u-net.net ([195.102.200.61]:31214 "EHLO
	keston.u-net.com") by vger.kernel.org with ESMTP id <S261289AbRFQPjM>;
	Sun, 17 Jun 2001 11:39:12 -0400
Message-ID: <00c301c0f743$9da4d9f0$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Daniel Phillips" <phillips@bonn-fries.net>
Cc: <rjd@xyzzy.clara.co.uk>, "Bill Pringlemeir" <bpringle@sympatico.ca>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk> <0106171701100P.00879@starship> <3B2CC7DC.EEAF3253@mandrakesoft.com>
Subject: Re: Newbie idiotic questions.
Date: Sun, 17 Jun 2001 16:38:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 192.168.0.50
X-Return-Path: Dave@keston.u-net.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Daniel Phillips wrote:
> > Yep, the only thing left to resolve is whether Jeff had coffee or not.
;-)
> >
> > -       if ((card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout),
GFP_KERNEL))
> > +       if ((card->mpuout = kmalloc(sizeof(*card->mpuout), GFP_KERNEL))
>
> Yeah, this is fine.  The original posted omitted the '*' which was not
> fine :)

The only other thing left to ask, is which is easier to read when glancing
through the code, and which is easier to read when maintaining the code.
imho, ist the former for reading the code, i dont know about maintaing the
code since i dont do that, however in my own projects i prefere the former
when maintaing the code.

What are others oppinions on this ?

Thanks,

Dave Flynn

>
> --
> Jeff Garzik      | Andre the Giant has a posse.
> Building 1024    |
> MandrakeSoft     |
>



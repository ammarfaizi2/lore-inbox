Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSFFCaR>; Wed, 5 Jun 2002 22:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFFCaQ>; Wed, 5 Jun 2002 22:30:16 -0400
Received: from maillog.promise.com.tw ([210.244.60.166]:36101 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S316667AbSFFCaQ>; Wed, 5 Jun 2002 22:30:16 -0400
Message-ID: <004501c20d02$4ac734a0$c0cca8c0@promise.com.tw>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <andre@serialata.org>,
        <marcelo@conectiva.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <arjanv@redhat.com>, "Linus Chen" <linusc@promise.com.tw>,
        <jordanr@promise.com>
In-Reply-To: <E16lBmI-0006nf-00@the-village.bc.nu><039701c20892$3940ca30$c0cca8c0@promise.com.tw><1022855592.4124.415.camel@irongate.swansea.linux.org.uk> <01bd01c20ab1$ece95900$c0cca8c0@promise.com.tw> <1023119309.3439.79.camel@irongate.swansea.linux.org.uk>
Subject: Re: [PATCH] 2.4.19pre9 in pdc202xx.c bug
Date: Thu, 6 Jun 2002 10:31:39 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dears.

    I saw the kernel patch 2.4.19pre10 and 2.4.19pre10ac2 release at
3.Jun.2002
The item 1 to 4 bugs still inside in 2.4.19pre10, Alan has fix some in his
tree.
Our latest driver patch is for kernel 2.4.18, you can reference the mail I
sent before.
Someone I don't know always modify our patch code and make things
complicated.

    Andre, only your name list in pdc202xx.c, So I think the problems should
be solved
by you. Could you fix all ASAP? If linux kernel wants our patch code, I
think they should
not modify our patch code and maintains by ourself.
Or do not make troubles for our company.


Thanks in advance
Hank Yang

----- Original Message -----
From: Alan Cox
To: Hank Yang
Cc: andre@linuxdiskcert.org ; marcelo@conectiva.com.br ;
torvalds@transmeta.com ; linux-kernel@vger.kernel.org ; arjanv@redhat.com ;
Linus Chen ; Crimson Hung ; Jenny Liang ; jordanr@promise.com
Sent: 2002年6月3日 下午 11:48
Subject: Re: [PATCH] 2.4.19pre9 in pdc202xx.c bug


On Mon, 2002-06-03 at 04:51, Hank Yang wrote:
>     There is something wrong in drivers/ide/pdc202xx.c ide driver.
> Andre Hedrick has merged ide stuff to 2.4.18 kernel that released for
> RedHat 7.3, SuSE 8.0 and Mandrake 8.2. That has a bug inside to
> harmful our company.

Item 4 is already done in my tree. As I said before the patch you sent
me a while back did not apply and appeared to be for an old 2.4.17/8
tree. I never got an update beyond that so I had assumed the problem had
already been resolved.

Andre - want to go over the rest and send me the bits ? Or Hank do you
want to send me a patch versus 2.4.19pre to fix those bugs

Alan


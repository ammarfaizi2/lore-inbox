Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135946AbREGNfz>; Mon, 7 May 2001 09:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136094AbREGNfp>; Mon, 7 May 2001 09:35:45 -0400
Received: from smtp.kpnqwest.com ([193.242.92.8]:59653 "EHLO ntexgswp02.DMZ")
	by vger.kernel.org with ESMTP id <S135946AbREGNfc>;
	Mon, 7 May 2001 09:35:32 -0400
Message-ID: <5F6171E541C8D311B9F200508B63D32801C31F52@ntexgvie01>
From: "Bene, Martin" <Martin.Bene@KPNQwest.com>
To: "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: what causes Machine Check exception? revisited (2.2.18)
Date: Mon, 7 May 2001 15:33:54 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

> On Mon, 7 May 2001, Bene, Martin wrote:
> 
> > Definitely not caused by:
> > 	Bad Rams, mb-chipset.
> 
> Erm, it was bad RAM everytime it happened to me. On standard PCs, you
> don't see those because you don't have ECC and the error is simply not
> detected.

Strange - definitely, strange. Of course you're correct about memory errors
going undetected on standard PC hardware, and usually these undetected
errors lead to other failures later on:

You get SIG11 errors when running programs(kernel compile seems to be agood
example), you get crashing processes, you get all sorts of weird funnies but
you really shouldn't get machine check exceptions.

I don't think there is a way a machine check exception can be triggered by
software - which it would have to be in order to be caused by bad RAMs.

Bye, Martin

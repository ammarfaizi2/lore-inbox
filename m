Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289051AbSA0XJb>; Sun, 27 Jan 2002 18:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSA0XJV>; Sun, 27 Jan 2002 18:09:21 -0500
Received: from zarjazz.demon.co.uk ([194.222.135.25]:44160 "EHLO
	zarjazz.demon.co.uk") by vger.kernel.org with ESMTP
	id <S289051AbSA0XJL>; Sun, 27 Jan 2002 18:09:11 -0500
Message-ID: <00b901c1a787$99dee5f0$0201010a@frodo>
From: "Vincent Sweeney" <v.sweeney@barrysworld.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16UyCO-0002zE-00@the-village.bc.nu>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
Date: Sun, 27 Jan 2002 23:08:58 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Vincent Sweeney" <v.sweeney@barrysworld.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, January 27, 2002 10:54 PM
Subject: Re: PROBLEM: high system usage / poor SMP network performance


> >     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
> >     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
>
> The important bit here is     ^^^^^^^^ that one. Something is causing
> horrendous lock contention it appears. Is the e100 driver optimised for
SMP
> yet ? Do you get better numbers if you use the eepro100 driver ?

It's been a while since I tested with the eepro100 drivers (I switch to e100
about 2.4.4 due to some unrelated problems) so I cannot give a comparision
just at present. I will test the eepro100 driver tomorrow on one of the
servers and post results then.

I will also try Andrew Morton's profiling tips on another box with the e100
driver.

Vince.



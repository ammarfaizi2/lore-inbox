Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130797AbQLUDTu>; Wed, 20 Dec 2000 22:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130872AbQLUDTk>; Wed, 20 Dec 2000 22:19:40 -0500
Received: from gear.torque.net ([204.138.244.1]:29710 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130797AbQLUDTa>;
	Wed, 20 Dec 2000 22:19:30 -0500
Message-ID: <3A416F1B.8E2FB200@torque.net>
Date: Wed, 20 Dec 2000 21:46:51 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test13-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ian Stirling <root@mauve.demon.co.uk>
Subject: Re: Laptop system clock slow after suspend to disk. (2.4.0-test9/hinote 
 VP)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Stirling <root@mauve.demon.co.uk> wrote:

> I've not noticed this on earlier kernel versions, is there something
> silly I'm missing that's making my DEC hinote VP (p100 laptop)s 
> system clock slow by a factor of five or so after resume?
> Not the CPU or cmos clock, only the system clock.
> Thoughts welcome.

I saw something like this on my thinkpad (RH6.2)
and it turned out to be connected to /etc/adjtime .
It was cured by changing the large numbers in
there to zeroes.

Could someone explain the mechanism?

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

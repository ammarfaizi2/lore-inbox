Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268296AbRG3VZ5>; Mon, 30 Jul 2001 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268233AbRG3VZr>; Mon, 30 Jul 2001 17:25:47 -0400
Received: from [64.7.140.42] ([64.7.140.42]:14784 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S268055AbRG3VZ2>;
	Mon, 30 Jul 2001 17:25:28 -0400
Message-ID: <060201c1193e$bbc1edc0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Thomas Hood" <jdthoodREMOVETHIS@yahoo.co.uk>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3B65CDC8.7ECE387A@yahoo.co.uk>
Subject: Re: "serial" does not show up in /proc/interrupts
Date: Mon, 30 Jul 2001 17:29:37 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

From: "Thomas Hood" <jdthoodREMOVETHIS@yahoo.co.uk>
> I am not using /dev/ttyS0 at the moment, so IRQ4 isn't listed
> as used.  I assume that's normal.  But I do have /dev/ttyS1

That is normal. serial.c unregisters the irq if it's no longer
needed.

> open; it uses IRQ3.  But note that the name of the serial
> driver is not printed in the list.  Why not?
>
>   3:       1979          XT-PIC

If you have it open, it should appear.

> Fishy!

Indeed.

..Stu



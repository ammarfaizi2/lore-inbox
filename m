Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276347AbRI1WQw>; Fri, 28 Sep 2001 18:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276346AbRI1WQn>; Fri, 28 Sep 2001 18:16:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57867 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276348AbRI1WQ1>; Fri, 28 Sep 2001 18:16:27 -0400
Subject: Re: floppy hang with 2.4.9-ac1x
To: thunder7@xs4all.nl
Date: Fri, 28 Sep 2001 23:21:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010928210355.A2837@middle.of.nowhere> from "thunder7@xs4all.nl" at Sep 28, 2001 09:03:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n60s-00006n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.9-ac10 onwards, IIRC) hard-hangs my linux system....

Knowing exactly which release would be useful

> dual P3/700, SMP kernel, gcc-3.0.1, Abit VP6 with VIA 694X chipset,
> mtools-3.9.7

Does it occur with gcc 2.95/2.96 ?

> the console hangs, and switching to another doesn't work. Also the
> num-lock key is dead. The floppy light stays on, but it doesn't sound
> like it is doing anything but spinning the motor.
> There are no messages in the system logs.
> 
> Any hints on what to do?

Try an older gcc to eliminate that case (I dont think it is the guilty party
but I dont trust the memory barriers in such an old ugly driver to be right)
and then find out which precise release broke it

Alan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317960AbSGLA6J>; Thu, 11 Jul 2002 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317961AbSGLA6I>; Thu, 11 Jul 2002 20:58:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37135 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317960AbSGLA6I>; Thu, 11 Jul 2002 20:58:08 -0400
Subject: Re: HZ, preferably as small as possible
To: rml@tech9.net (Robert Love)
Date: Fri, 12 Jul 2002 02:24:16 +0100 (BST)
Cc: thunder@ngforever.de (Thunder from the hill),
       oliver@klozoff.com (Stevie O), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <1026435320.1178.362.camel@sinai> from "Robert Love" at Jul 11, 2002 05:55:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SpAO-00021K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uh, HZ is not scheduler calls per second.
> 
> Neither exactly is it interrupts per second, but _timer_ interrupts per
> second.  It is the frequency of the timer interrupt.

Its not exactly that either. Its 'rate at which jiffies is incremented'.
The distinction is not pedantic its rather critical when you go to a 
variable timer tick...

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRJFNIL>; Sat, 6 Oct 2001 09:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275137AbRJFNIB>; Sat, 6 Oct 2001 09:08:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275126AbRJFNHr>; Sat, 6 Oct 2001 09:07:47 -0400
Subject: Re: Question about rtc_lock
To: jdthood@mail.com (Thomas Hood)
Date: Sat, 6 Oct 2001 14:13:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1002373586.813.119.camel@thanatos> from "Thomas Hood" at Oct 06, 2001 09:06:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15prGs-0001G3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The CMOS isnt accessed from IRQ handlers
> 
> No, but what if the rtc interrupts while the lock is held in this
> bit of code?

Thats fine. It wont take the lock


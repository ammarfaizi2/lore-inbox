Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285071AbRLFJ0v>; Thu, 6 Dec 2001 04:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285069AbRLFJ0l>; Thu, 6 Dec 2001 04:26:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285071AbRLFJ0b>; Thu, 6 Dec 2001 04:26:31 -0500
Subject: Re: SMTP->Windows connection with 2.4.16
To: lkml@andyjeffries.co.uk (Andy Jeffries)
Date: Thu, 6 Dec 2001 09:32:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011206091418.4d031a5c.lkml@andyjeffries.co.uk> from "Andy Jeffries" at Dec 06, 2001 09:14:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16But9-00012x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> server with a 2.4.16 Kernel.  He has helpfully provided the following
> information to illustrate the problem.  Is this a known issue with 2.4.16?

Nope

>  Can anyone help?  If so, what more information do you need (tcpdump

tcpdump data

> # telnet smtp.blueyonder.co.uk 25 
> Connection refused
> 
> # ping smtp.blueyonder.co.uk
> Replied normally

Quite reasonable. smtp servers stop listening when under high load

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbRFBR0n>; Sat, 2 Jun 2001 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262639AbRFBR0e>; Sat, 2 Jun 2001 13:26:34 -0400
Received: from venus.Sun.COM ([192.9.25.5]:60083 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S262633AbRFBR02>;
	Sat, 2 Jun 2001 13:26:28 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <2d8672e722.2e7222d867@mysun.com>
Date: Sat, 02 Jun 2001 19:17:32 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: SMC-IRCC broken? 2.4.5-pre4 / -ac5+
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > The kernel stops while booting at:
> > TCP: Hash tables configured (established 16384 bind 16384)
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > SMC IrDA Controller found; IrCC version 2.0, port 0x118, dma=3, 
> irq=3
> IRDA compiled in  ? If so is it ok modular . It sounds like yet 
> another boot
> ordering wonder

Just got it working as a module in -ac5, but still the kernel frezes
if I use it compiled in. -ac6 makes no diff.


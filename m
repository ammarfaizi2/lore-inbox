Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290150AbSAKW4U>; Fri, 11 Jan 2002 17:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290152AbSAKW4K>; Fri, 11 Jan 2002 17:56:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39178 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290150AbSAKWzw>; Fri, 11 Jan 2002 17:55:52 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: rth@twiddle.net (Richard Henderson)
Date: Fri, 11 Jan 2002 23:07:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020111141850.A9873@twiddle.net> from "Richard Henderson" at Jan 11, 2002 02:18:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PAld-0000c9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It means the compiler for -m686 shouldn't have assumed cmov was available
> 
> Eh?  -march=i686 *asserts* that cmov is available.

So why is it called "i686" when the intel i686 machine definition says
its optional ? Its just the naming that seems odd

> What's the point of optimizing an IF to a cmov if I have
> to insert another IF to see if I can use cmov?

I've always wondered. Intel made the instruction optional yet there isnt
an obvious way to do runtime fixups on it

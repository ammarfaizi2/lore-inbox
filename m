Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290547AbSARASw>; Thu, 17 Jan 2002 19:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290549AbSARASo>; Thu, 17 Jan 2002 19:18:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10001 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290547AbSARASa>; Thu, 17 Jan 2002 19:18:30 -0500
Subject: Re: hangs using opengl
To: nickm@kabelfoon.nl (Nick Martens)
Date: Fri, 18 Jan 2002 00:06:34 +0000 (GMT)
Cc: Frank.dekervel@student.kuleuven.ac.Be (Frank Dekervel),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C47284A.9080607@kabelfoon.nl> from "Nick Martens" at Jan 17, 2002 08:38:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RMYE-0005OO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok thanx all Another thing when it crashes the hd load seems extremely 
> high. system config is Intel P3 1ghz, intel 815 chipset, kernel 2.4.5 
> ,xf86 4.1, kde 2.2

How old is your 815 chipset ? I had problems with high load crashes on
three 815 based boards all of which were the same (MX3S) and all of which
went back.

Intel has errata on the 815 where the SDRAM voltage drive is apparently
wrong and board level corrections to cope. I've never been able to find
out if the board had these.

> Jan 17 20:15:23 nick kernel: agpgart: unsupported bridge
> Jan 17 20:15:23 nick kernel: agpgart: no supported devices found.

How old is your kernel - and do you have both the 440BX and i81x AGP 
included. The AGP on the i815 basically has two totally different worlds
1.	The rather nice onboard 2D/3D (i810 alike)
2.	When you plug in a video card (440 alike)

Alan

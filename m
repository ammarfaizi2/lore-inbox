Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268544AbTBWTfF>; Sun, 23 Feb 2003 14:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbTBWTfF>; Sun, 23 Feb 2003 14:35:05 -0500
Received: from smtp2.EUnet.yu ([194.247.192.51]:49105 "EHLO smtp2.eunet.yu")
	by vger.kernel.org with ESMTP id <S268544AbTBWTfE>;
	Sun, 23 Feb 2003 14:35:04 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@EUnet.yu>
To: Sheng Long Gradilla <skamoelf@netscape.net>
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Date: Sun, 23 Feb 2003 19:21:27 +0100
User-Agent: KMail/1.5
References: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu> <200302231450.47506.toptan@EUnet.yu> <3E58F07B.3030801@netscape.net>
In-Reply-To: <3E58F07B.3030801@netscape.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200302231921.27024.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp2.eunet.yu id h1NJjDF32662
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana nedelja 23. februar 2003. 17:02 napisali ste:
> I tested on an Asus A7V8X motherboard (KT400) with a GeForce4 Ti 4200
> AGP8X. The module loads correctly, at last! It sets the apperture size
> correctly and all, but when I start XFree, I get do not get any
> graphical screen, but text mode garbage. Characters of all colors, with
> no sense at all. I had exactly the same problem in other kernels.
>
	What kernels? Are you using old agpgart or new one with other kernels?

> I played a bit with the NvAGP option on XF86Config file. According to
> the documentation, 0 is PCI mode, 1 is NvAGP or fallback to PCI if
> failed, 2 is AGPGART mode or fallback to PCI if failed, 3 is autodetect.
> If I set it to 2, 3 or comment it, I got the same problem with the
> garbage and had to reset the PC. Setting it to 0 would make it run in
> PCI mode, and it always works. I tried setting it to 1, thinking that
> maybe the documentation is wrong. X started successfully, but the card
> was in PCI mode. I read the logs to confirm it, and indeed, the NvAGP
> module fails to identify the AGP chipset and falls back to PCI.
>
> I tried setting NvAGP to 2 again, to read the logs and see if there is
> something I could find out, but unfortunately the log had nothing but
> garbage. I tried several times with no success. The log is always garbage.
>
	Try fetching latest nVidia drivers.

	I'll try to isolate problem, and send patch if neccessery.

> - Sheng Long Gradilla

-- 
Pozdrav,
Tanasković Toplica



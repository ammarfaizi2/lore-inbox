Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268962AbTBWU0o>; Sun, 23 Feb 2003 15:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbTBWU0o>; Sun, 23 Feb 2003 15:26:44 -0500
Received: from smtp1.EUnet.yu ([194.247.192.50]:36504 "EHLO smtp1.eunet.yu")
	by vger.kernel.org with ESMTP id <S268962AbTBWU0l>;
	Sun, 23 Feb 2003 15:26:41 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@EUnet.yu>
To: Sheng Long Gradilla <skamoelf@netscape.net>
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Date: Sun, 23 Feb 2003 21:36:09 +0100
User-Agent: KMail/1.5
References: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu> <200302231921.27024.toptan@EUnet.yu> <3E59299B.8090200@netscape.net>
In-Reply-To: <3E59299B.8090200@netscape.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200302232136.09903.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp1.eunet.yu id h1NKajV00520
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana nedelja 23. februar 2003. 21:05 napisali ste:
> The "other kernels" I am talking about are 2.4.19 and 2.4.20 with the
> old agpgart. As I said, the new agpgart module now loads but the results
> are the same. I yet have to try some other tricks like setting the AGP
> rate manually.
>
> I am also using the latest nvidia modules, which are 1.0-4191
>
	Thank God, it's not agpgart's fault, it is the fact that Dave Jones mentioned 
earlier, I doubdt that any (ATI, nVidia..) drivers support AGP8x transfer 
rate.
	If this agpgart works fine with 2x and 4x transfer rates, than I believe that 
my backport is correct. We will have to wait drivers that support 8x transfer 
rate, and then test it, or to hack their binaries, but I doubdt that any one 
of us have time to do such a thing.
	The fact that it now sets aperture size correctly for 8x is a good sign :)
-- 
Pozdrav,
Tanasković Toplica



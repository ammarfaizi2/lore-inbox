Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268409AbTBWNoN>; Sun, 23 Feb 2003 08:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268410AbTBWNoN>; Sun, 23 Feb 2003 08:44:13 -0500
Received: from smtp1.EUnet.yu ([194.247.192.50]:49600 "EHLO smtp1.eunet.yu")
	by vger.kernel.org with ESMTP id <S268409AbTBWNoM>;
	Sun, 23 Feb 2003 08:44:12 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@EUnet.yu>
To: <camber@yakko.cs.wmich.edu>
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Date: Sun, 23 Feb 2003 14:50:47 +0100
User-Agent: KMail/1.5
References: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu>
In-Reply-To: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200302231450.47506.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp1.eunet.yu id h1NDsLV30492
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana nedelja 23. februar 2003. 00:07 napisali ste:
> The apeture is now set correctly. The ATI 4.2.0-2.5.1 drivers don't work
> but I think that is a dri problem. Everything works fine with the vesa
> drivers using XFree86 4.2.99.
>

	That's good, but ATI 4.2.0-2.5.1. should work, try loading fglrx.o manualy:

telinit 3
insmod /path/fglrx.o
telinit 5

Then go and check ATI control panel, and please send me results, on my R9000 
it reports AGP4x which is OK, I hope it will be 8x for you.
-- 
Pozdrav,
Tanasković Toplica



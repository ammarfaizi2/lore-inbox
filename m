Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268518AbTBWSgP>; Sun, 23 Feb 2003 13:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268523AbTBWSgP>; Sun, 23 Feb 2003 13:36:15 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:760 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S268518AbTBWSgN> convert rfc822-to-8bit;
	Sun, 23 Feb 2003 13:36:13 -0500
Reply-To: <camber@yakko.cs.wmich.edu>
From: "Edward Killips" <camber@yakko.cs.wmich.edu>
To: "Toplica Tanaskovic" <toptan@EUnet.yu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: AGP backport from 2.5 to 2.4.21-pre4
Date: Sun, 23 Feb 2003 13:46:24 -0500
Message-ID: <JJEJKAPBMJAOOFPKFDFKEELJCEAA.camber@yakko.cs.wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <200302231450.47506.toptan@EUnet.yu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I tried. fglrx.o loads without errors, but when X starts I get a blank screen. The last thing that appears in the logs for XFree86 (version 4.2.99) is the drm initialization. The card and the XF86Config file both work fine under Linux if I use them with a machine that only supports 4x AGP and does not support AGP 3.0.
 
- -Edward Killips

- -----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Toplica
Tanaskovic
Sent: Sunday, February 23, 2003 8:51 AM
To: camber@yakko.cs.wmich.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4


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
- -- 
Pozdrav,
Tanaskovic Toplica


- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQA/AwUBPlkW/3g7wzlNS3haEQLBzgCfUN9Vm64w4nij+JUZ47x7GOjYvy4An3LA
9w0w/sWkxyUJuzfG+w4P0j93
=3sfk
-----END PGP SIGNATURE-----


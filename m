Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269085AbTBXCSF>; Sun, 23 Feb 2003 21:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269086AbTBXCSF>; Sun, 23 Feb 2003 21:18:05 -0500
Received: from smtp2.EUnet.yu ([194.247.192.51]:55229 "EHLO smtp2.eunet.yu")
	by vger.kernel.org with ESMTP id <S269085AbTBXCRY>;
	Sun, 23 Feb 2003 21:17:24 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@EUnet.yu>
To: Bryan Andersen <bryan@bogonomicon.net>
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Date: Mon, 24 Feb 2003 03:01:36 +0100
User-Agent: KMail/1.5
References: <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu> <200302232136.09903.toptan@EUnet.yu> <3E59426D.2070708@bogonomicon.net>
In-Reply-To: <3E59426D.2070708@bogonomicon.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200302240301.36366.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp2.eunet.yu id h1O2RXF30796
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana nedelja 23. februar 2003. 22:51 napisali ste:
> > 	Thank God, it's not agpgart's fault, it is the fact that Dave Jones
> > mentioned earlier, I doubdt that any (ATI, nVidia..) drivers support
> > AGP8x transfer rate.
	I forgot to add through agpgart.
>
> The nVidia 1.0-4191 kernel driver release notes say they now support AGP
> 8X (AGP 3.0).  I did notice a slight speed up on some very heavy
> graphics tasks but that is it.
>
	That is correct, but I do not think that they knew about my backport, it is 
not official, and it is still untested well and only few days old. From my 
previos experience with nVidia and ATI drivers I can tell you that they have 
bulit in AGP support, and they do not need agpgart to run. They will use it 
for sure for 2x and 4x but it is questionable, that they do any checking if 
agpgart can do 8x. 

	I've never programmed graphics but I intend, as soon as I find some extra 
time, to try to write a small program which will check if all AGP modes work 
correctly with my backport.

-- 
Pozdrav,
Tanasković Toplica



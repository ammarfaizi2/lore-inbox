Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbSLNOqo>; Sat, 14 Dec 2002 09:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbSLNOqo>; Sat, 14 Dec 2002 09:46:44 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:19073 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S267620AbSLNOqo> convert rfc822-to-8bit;
	Sat, 14 Dec 2002 09:46:44 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Matti Aarnio <matti.aarnio@zmailer.org>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: i4l dtmf errors
Date: Sat, 14 Dec 2002 15:54:29 +0100
User-Agent: KMail/1.4.1
References: <200212121145.26108.roy@karlsbakk.net> <20021212121004.GC32122@mea-ext.zmailer.org>
In-Reply-To: <20021212121004.GC32122@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212141554.29354.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Quick reading of  drivers/isdn/isdn_audio.c(*)  shows that it does use
>   fixed-point Görtzel (Goertzel in english) algorithm for detecting
>   tones, but it does _not_ do comparison of received overall signal
>   power vs. detected DTMF tone powers.
>
>   When there is signal power outside the DTMF channels, signal should
>   not be detected.  Also, DTMF tone powers should be roughly equal,
>   and exactly two tones should be present for valid detection.
>
>       http://www.numerix-dsp.com/goertzel.html
>
>   Adding those power tests should be fairly trivial, but I leave it
>   to Somebody Else...

Is there a 'somebody else' (perhaps the isdn maintainer?) that have time to 
look at this?

thanks

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.


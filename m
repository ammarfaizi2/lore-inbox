Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288902AbSANTAF>; Mon, 14 Jan 2002 14:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288932AbSANS6p>; Mon, 14 Jan 2002 13:58:45 -0500
Received: from racine.noos.net ([212.198.2.71]:50292 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S288923AbSANS6N>;
	Mon, 14 Jan 2002 13:58:13 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jeremy Lumbroso <j.lumbroso@noos.fr>
To: salvador@inti.gov.ar
Subject: Re: Driver via ac97 sound problem (VT82C686B)
Date: Mon, 14 Jan 2002 19:56:03 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16PZOe-0003fZ-00@the-village.bc.nu> <1010956965.3260.0.camel@raul> <3C4311BC.A99CEF31@inti.gov.ar>
In-Reply-To: <3C4311BC.A99CEF31@inti.gov.ar>
Cc: Raul Sanchez Sanchez <raul@dif.um.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Paul Lorenz <p1orenz@yahoo.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114185833Z288923-13996+5546@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi 
i apply the patch and compile with the two values but i still heard no sound .
Did someone got this driver works ?
thx 


Le Lundi 14 Janvier 2002 18:13, salvador a écrit :
> As Alan says: "The VIA driver doesnt appear to support the ac97 ops."
> Here I'm attaching a brut force test, I created a small function that turns
> ON the EAPD and another to turn it OFF. Note that according to dataseets a
> 1 will disable the external amplifier, but you should try with the two
> values. I attached the modified code. It have a 1886 entry that will
> initialize the codec setting EAPD output to 0. The code have a commented
> entry that does the reverse, try both.
> I also attached the diffs so Alan can check if that could work.
> Note: I didn't compile it so watch for typos ;-)
>
> SET

-- 
__________________________
Lumbroso Jeremy
188 bd malesherbes 
75017 PARIS
01,47,64,07,94
06,19,77,01,25
__________________________

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbRGLFOF>; Thu, 12 Jul 2001 01:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbRGLFNz>; Thu, 12 Jul 2001 01:13:55 -0400
Received: from pluto.runbox.com ([193.71.199.39]:45574 "EHLO pluto.runbox.com")
	by vger.kernel.org with ESMTP id <S267431AbRGLFNr>;
	Thu, 12 Jul 2001 01:13:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Chris Bacott <cbacot@runbox.com>
To: "Daniel Harvey" <daniel@amristar.com.au>,
        "Daniel Harvey" <daniel@amristar.com.au>,
        "Chris Wedgwood" <cw@f00f.org>, <hahn@coffee.psychology.mcmaster.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: FW: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Date: Wed, 11 Jul 2001 12:14:57 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <NEBBJDBLILDEDGICHAGACEAGCGAA.daniel@amristar.com.au>
In-Reply-To: <NEBBJDBLILDEDGICHAGACEAGCGAA.daniel@amristar.com.au>
MIME-Version: 1.0
Message-Id: <01071112145701.00269@darkstar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the card? Are they still using the SiS 530? I have a Presario, with 
192 meg RAM, and a SiS 530 onboard, using 8 meg shared mem. I have no 
problems concerning that, Linux se---hmm, never noticed before. Total mem 
(-swap): 183.2 meg. Doesn't say anything about the shared mem. I thought 
Linux totalled up all RAM, even that in the vid card, to be used as RAM? 
Someone told me that.....can't remember who. Never noticed that. Anyway, I'm 
not having any other problems, other than now I have to make sure the missing 
8 meg, err, 9meg, is being used. Dammit, something _else_ to investigate.

> Got an idea - the video card in the Compaq uses a piece of shared memory
> (between 2-8M).
>
> Would Linux be able to detect that?
>
> Daniel.
>
> >
> > At last getting something different!
> >
> > linux 2.4.5 with:
> >
> > no options - slow
> > mem=64M - fast
> > mem=128M - fast
> > mem=200M - fast
> > mem=224M - fast
> > mem=240M - fast
> > mem=248M - fast
> > mem=249M - fast/medium, fast 'make dep' but slow boot/reboot
> > mem=250M - slow
> > mem=252M - slow
> > mem=256M - hangs on boot, last line="Freeing unused kernel
> > memory: 196k freed"
> >

-- 
Chris Bacott

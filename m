Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbRBJA0E>; Fri, 9 Feb 2001 19:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129924AbRBJAZz>; Fri, 9 Feb 2001 19:25:55 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:48381 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129336AbRBJAZs>; Fri, 9 Feb 2001 19:25:48 -0500
Date: Fri, 9 Feb 2001 16:25:32 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Alex Deucher <adeucher@UU.NET>
cc: rainer@konqui.de, linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
In-Reply-To: <3A7863E4.C7323E96@uu.net>
Message-ID: <Pine.LNX.4.21.0102091624110.26669-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might also want to run setiathome with the -nice option...for
instance i *always* run it with -nice 19 so that it lays in the background
consuming otherwise idle cycles. anything wanting cpu time will then take
it from seti.


On Wed, 31 Jan 2001, Alex Deucher wrote:

> Rainer,
> 
> 	I'm not too familiar with the ct5880 sound chip that comes built onto
> motherboards.  I do know that alot of the AC'97 compliant built in sound
> chips tend to let the host cpu do most of the processing involved in
> playing the sound.  That being said, even if you have a dedicated sound
> processor, mp3 decoding is very processor intensive.  It just so happens
> that seti is also very processor intensive.  Both of these processes are
> vying for time on the cpu.  Since both of these processes are so
> processor intensive and the cpu can only do one thing at a time, the
> performance of one or the other process will suffer from time to time.
> 
> Alex
> 
> 
> ----------------------------------------
> 
> Hi, 
> 
> I hope you can help me. I have a problem with my on board soundcard and 
> seti. I have a Gigabyte GA-7ZX Creative 5880 sound chip. I use the
> kernel 
> driver es1371 and it works goot. But when I run seti@home I got some
> noise 
> in my sound when I play mp3 and other sound. But it is not every time
> 10s 
> play good than for 2 s bad and than 10s good 2s bad and so on. When I
> kill 
> seti@home every thing is ok. So what can I do? 
> 
> I have a Athlon 800 Mhz and 128 MB RAM 
> 
> cu 
> Rainer
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318867AbSG1Akv>; Sat, 27 Jul 2002 20:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318868AbSG1Aku>; Sat, 27 Jul 2002 20:40:50 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:33298 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318867AbSG1Akr>;
	Sat, 27 Jul 2002 20:40:47 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207280043.g6S0hop72617@saturn.cs.uml.edu>
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
To: jdow@earthlink.net (jdow)
Date: Sat, 27 Jul 2002 20:43:50 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
       acahalan@cs.uml.edu (Albert D. Cahalan),
       wowbagger@sktc.net (David D. Hagood),
       arodland@noln.com (Andrew Rodland), linux-kernel@vger.kernel.org
In-Reply-To: <04a801c235b9$03f699f0$1125a8c0@wednesday> from "jdow" at Jul 27, 2002 03:00:26 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdow writes:
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
>> On Sat, 2002-07-27 at 19:56, Albert D. Cahalan wrote:

>>> I'm one of the 42 remaining people with a terminal. My VT510
>>> mostly sits unplugged due to heat, and it's taking up space.
>>
>> There is a vt420 sitting next to the rack right here.

Alan is #2 out of the 42 people with terminals.

> Alan, the really perverse can actually read 45.45bps Baudot RTTY streams
> by ear. (Ironically the person I have watched do it is also named Alan.)
> Should it also send out Baudot as an option?

Yow. That's 60 to 65 WPM for a continuous transmission.

For the PC speaker, Baudot RTTY is easy. Data pulses are 22 ms
and stop pulses are 22, 31, or 33 ms. If the kernel is compiled
with HZ==100 then you must do the European "50 bauds" instead,
at 66.67 WPM with 20 ms data and 30 ms stop.

Ask that other Alan what frequency shift he likes; mark/space
may be 2125/2975, 2125/2295, 1275/2125, or 1275/1445.

> Now, are you sure
> that you are going to be ready to type in the Morse you copy in your head
> as the machine surprises you with a crash and bleats of Morse code?

It needs to repeat.

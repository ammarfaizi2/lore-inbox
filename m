Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSL1XMF>; Sat, 28 Dec 2002 18:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbSL1XMF>; Sat, 28 Dec 2002 18:12:05 -0500
Received: from fluent2.pyramid.net ([206.100.220.213]:5768 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S266363AbSL1XME>; Sat, 28 Dec 2002 18:12:04 -0500
Message-Id: <5.2.0.9.0.20021228151707.01d44ec0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 28 Dec 2002 15:20:21 -0800
To: "Folkert van Heusden" <folkert@vanheusden.com>,
       "'John Bradford'" <john@grabjohn.com>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: RE: Want a random entropy source?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <003c01c2aeaf$ac673530$3640a8c0@boemboem>
References: <200212281600.gBSG0P4r001160@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:28 PM 12/28/02 +0100, Folkert van Heusden wrote:
>JB> How can you guarantee that you are sampling noise, though, what if a
>JB> sound card was picking up 50 Hz mains hum, for example,  that would
>JB> de-randomise the data quite a bit.
>
>Well, the 50hz from the mains isn't a perfect 50hz; it has random (yes)
>fluctuations.

As a start, I would slot out 50 Hz, 60 Hz (for people in the US and 
US-engineered power systems in other countries), 4 kHz and 
harmonics.  Actually, if you are sampling at roughly random intervals you 
would get about four to six bits per sample of somewhat random values, and 
that would give you entropy as good as you get from mouse movement.

If someone were playing a CD at the time you were sampling the sound card, 
you would get considerably more bits of entropy, but using the six bottom 
bits would still be useful.

Hey, people, it's just a thought.  Turning lemons into lemonade, if you will.

Satch


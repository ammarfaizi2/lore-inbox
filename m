Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130634AbRAaTK4>; Wed, 31 Jan 2001 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130881AbRAaTKp>; Wed, 31 Jan 2001 14:10:45 -0500
Received: from cmr1.ash.ops.us.uu.net ([198.5.241.39]:5782 "EHLO
	cmr1.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S130634AbRAaTKh>; Wed, 31 Jan 2001 14:10:37 -0500
Message-ID: <3A7863E4.C7323E96@uu.net>
Date: Wed, 31 Jan 2001 14:13:40 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: rainer@konqui.de, linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer,

	I'm not too familiar with the ct5880 sound chip that comes built onto
motherboards.  I do know that alot of the AC'97 compliant built in sound
chips tend to let the host cpu do most of the processing involved in
playing the sound.  That being said, even if you have a dedicated sound
processor, mp3 decoding is very processor intensive.  It just so happens
that seti is also very processor intensive.  Both of these processes are
vying for time on the cpu.  Since both of these processes are so
processor intensive and the cpu can only do one thing at a time, the
performance of one or the other process will suffer from time to time.

Alex


----------------------------------------

Hi, 

I hope you can help me. I have a problem with my on board soundcard and 
seti. I have a Gigabyte GA-7ZX Creative 5880 sound chip. I use the
kernel 
driver es1371 and it works goot. But when I run seti@home I got some
noise 
in my sound when I play mp3 and other sound. But it is not every time
10s 
play good than for 2 s bad and than 10s good 2s bad and so on. When I
kill 
seti@home every thing is ok. So what can I do? 

I have a Athlon 800 Mhz and 128 MB RAM 

cu 
Rainer
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSHGPNK>; Wed, 7 Aug 2002 11:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSHGPNJ>; Wed, 7 Aug 2002 11:13:09 -0400
Received: from 194-106-48-114.dsl.freedom2surf.net ([194.106.48.114]:39822
	"EHLO tim.rpsys.net") by vger.kernel.org with ESMTP
	id <S316853AbSHGPNI>; Wed, 7 Aug 2002 11:13:08 -0400
Message-ID: <03a501c23e25$707dcd40$0301a8c0@rpnet.com>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel from 2.5.5 onwards won't boot on a P200 MMX
Date: Wed, 7 Aug 2002 16:16:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm having trouble getting the 2.5 kernels from 2.5.5 onwards to run on my
> Pentium 200 MMX system. The same kernels all work fine on my K6-2-400. I
> am compiling for the right processor (I've tried a few different ones with
no
> effect).

> It's getting to the "Uncompressing Linux..." stage but I never get the Ok
> message.

I've finally tracked this down (at least partially). It's something to do
with the sound drivers... If I disable the sound system it all works fine.
The sound options I was using were probably a bit weird as I wasn't sure
what I needed.

I've tried removing individual options from the sound section to try and
narrow this down but they all the options seem to be interdependent.

For reference the sound system was moved from /drivers/sound to /sound in
2.5.5 which is where the kernels stopped working from.

--
RP
Please CC: me in any reply.


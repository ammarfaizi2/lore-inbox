Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSJYCGO>; Thu, 24 Oct 2002 22:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSJYCGN>; Thu, 24 Oct 2002 22:06:13 -0400
Received: from ns.cinet.co.jp ([210.166.75.130]:18193 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S261274AbSJYCGM>;
	Thu, 24 Oct 2002 22:06:12 -0400
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A30E@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Cc: "'Takashi Iwai '" <tiwai@suse.de>,
       "'LKML '" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHSET 22/25] add support for PC-9800 architecture (sound 
	alsa)
Date: Fri, 25 Oct 2002 11:12:16 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much.

-----Original Message-----
From: Alan Cox
To: Takashi Iwai
Cc: Osamu Tomita; LKML
Sent: 2002/10/24 1:29
Subject: Re: [PATCHSET 22/25] add support for PC-9800 architecture (sound
alsa)

> On Wed, 2002-10-23 at 16:46, Takashi Iwai wrote:
>> the question is, whether cs4232 module works on PC9800, or not.
>> i guess the control-port is not used on this card.  in such a case,
>> you can deactivate the control-port via module option (or even add
>> ifdef for the specific kernel config).
>
> In the longer run it may well be much cleaner to make pc98 a variable
> just like eisa, mca are. On a non pc98 box it might happen to be a
> constant 0 and optimised but that is a detail.
> 
> Its much easier to follow
> 
> 	if(!pc98)
> 		outb(a,b);
I will try to use this way, at appropriate point.

Regards
Osamu Tomita


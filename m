Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWB1Aor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWB1Aor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWB1Aor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:44:47 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:4264 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751506AbWB1Aoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:44:46 -0500
Message-ID: <44039CEF.3060508@vilain.net>
Date: Tue, 28 Feb 2006 13:44:31 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Peter Gordon <codergeek42@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <fa.deNPP6WI8uOxYJJt5IRsDHJHqNc@ifi.uio.no> <200602271647.48600.dhazelton@enter.net> <7e90c9180602271430m35051882jcc3e5b1608fb6be9@mail.gmail.com> <200602271724.39562.dhazelton@enter.net>
In-Reply-To: <200602271724.39562.dhazelton@enter.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton wrote:
>>>This value is also reported by the drive. I don't know about DVD drives,
>>>but for CD drives it is a multiplier. 1x == 256K/sec transfer off the
>>>disc [...]
>>For CDs, 1x is actually 150 KByte/sec.
> Well, I've been known to be wrong before, and this number was more based on 
> the fact that I once measured a sustained transfer rate of 1M/sec on a 4x 
> CDROM

Think about audio.  Single speed = 75 frames of 2352 bytes per second, 
or 176kB/s.  However with data tracks you only get 2k per frame/sector, 
so that works out to be 153kB/s.

Due to the CLV nature of CD-ROMs you may find the drive is faster 
reading some parts of the disc than others.

>>According to WikiPedia, the DVD speed rating is almost 9 times that of
>>CD speeds. I.e., 1x DVD is about 1.32 MByte/sec.
> This was based on DVDx16 == CDx48 - I'm guessing someone is doing some monkey 
> work if a DVD is 9x a CD and a 16x DVD can't hit that mystical 52x of my 
> favorite CDRW drive in pure CD read mode.

You can do a similar calculation with DVDs.  While I can't find a 
reference for the maximum DVD total bitrate of ~10Mbit/s, this at 1.25 
MByte/s this roughly agrees with the 1.32 quoted.

Sam.

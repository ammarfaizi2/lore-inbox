Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVGLNFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVGLNFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGLNFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:05:21 -0400
Received: from alog0200.analogic.com ([208.224.220.215]:19657 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261317AbVGLNEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:04:13 -0400
Date: Tue, 12 Jul 2005 09:02:42 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <Pine.LNX.4.61.0507121448240.5529@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0507120857001.2868@chaos.analogic.com>
References: <Pine.LNX.4.61.0507121448240.5529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Jan Engelhardt wrote:

> Hi,
>
>
> Vojtech Pavlik @ Tue, 12 Jul 2005 14:10:08 +0200 wrote:
> (http://lkml.org/lkml/2005/7/12/122)
>
>> On Mon, Jul 11, 2005 at 05:38:05PM -0700, George Anzinger wrote:
>>> HZ  	TICK RATE	jiffie(ns)	second(ns)	 error (ppbillion)
>>>  100	 1193180	10000000	1000000000	       0
>
>> The PIT crystal runs at 14.3181818 MHz (CGA dotclock, found on ISA, ...)
>> and is divided by 12 to get PIT tick rate
>> 	14.3181818 MHz / 12 = 1193182 Hz
>
> What exactly is the frequency of the PIT? Many internet resources say 1193180
> (including the original post), some say 1193181, and you say 1193182 Hz.
> Which one is correct? (Ignoring temperature for now..)
>

The original specification was based upon the NTSC color subcarrier
frequency of 3.579545. The dotclock is 4 times this:

 	3.579745 * 4 = 14.31818000

You can type 3.579545 into google and see it's used practically
everywhere as the magic number that started it all ;^) The
crooked-earth society uses this for PI (just kidding).


> IMO 1193181 could be, because it matches the almost-magical number 0x1234DD.
>
>
> Jan Engelhardt
> -- 
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

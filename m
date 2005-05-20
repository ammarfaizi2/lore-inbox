Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVETV2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVETV2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVETV2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:28:37 -0400
Received: from alog0213.analogic.com ([208.224.220.228]:59085 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261596AbVETV2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:28:02 -0400
Date: Fri, 20 May 2005 17:27:36 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jon Smirl <jonsmirl@gmail.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <9e4733910505201421cf36902@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505201725460.4930@chaos.analogic.com>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org>
 <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
 <9e4733910505201421cf36902@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Jon Smirl wrote:

> On 5/20/05, Richard B. Johnson <linux-os@analogic.com> wrote:
>> On Fri, 20 May 2005, Linus Torvalds wrote:
>> Yes, and I didn't want to. However a customer wants some status to
>> be always displayed in the upper-right-hand corner of a 4x5 LCD
>> with a tiny CPU board.
>
> The console implements a tiny terminal emulator. Does the emulator
> implement the escape sequence for locking an unscrollable line at the
> top of the screen? If so lock the line, write your info there, and the
> rest of the display will work like normal.
>
> -- 
> Jon Smirl
> jonsmirl@gmail.com
>

I'll experiment. I know that real VT100s can set a scrolling region
so I could set a scrolling region from line 2 to 25 if it works.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5554.17 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUKIMsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUKIMsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 07:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUKIMsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 07:48:42 -0500
Received: from alog0093.analogic.com ([208.224.220.108]:16768 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261537AbUKIMsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 07:48:36 -0500
Date: Tue, 9 Nov 2004 07:44:11 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Adrian Bunk <bunk@stusta.de>
cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill IN_STRING_C
In-Reply-To: <20041108230859.GL15077@stusta.de>
Message-ID: <Pine.LNX.4.61.0411090742530.11563@chaos.analogic.com>
References: <20041107142445.GH14308@stusta.de> <20041108161935.GC2456@wotan.suse.de>
 <20041108163101.GA13234@stusta.de> <200411081904.13969.pluto@pld-linux.org>
 <20041108183120.GB15077@stusta.de> <Pine.LNX.4.61.0411081410560.6407@chaos.analogic.com>
 <20041108212713.GH15077@stusta.de> <Pine.LNX.4.61.0411081640320.8258@chaos.analogic.com>
 <20041108222952.GJ15077@stusta.de> <Pine.LNX.4.61.0411081751500.8711@chaos.analogic.com>
 <20041108230859.GL15077@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Adrian Bunk wrote:

> On Mon, Nov 08, 2004 at 05:57:12PM -0500, linux-os wrote:
>> ...
>> 	call	strcpy
>> ...
>> strcpy:
>> 	subl	$8, %esp
>> ...
>> It clearly invents strcpy, having never been referenced in the
>> source.
>
> The asm code you sent does _not_ call a global strcpy function.
> It calls an asm procedure named "strcpy" it ships itself.
>
> BTW: You are the second person in this thread I have to explain this to...
>
>> Cheers,
>> Dick Johnson
>
> cu
> Adrian

Explain WHAT? There is NO strcpy in the code. No such procedure
should have been called. Period. The generated code is defective.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.

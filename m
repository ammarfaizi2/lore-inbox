Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSL2Rje>; Sun, 29 Dec 2002 12:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSL2Rje>; Sun, 29 Dec 2002 12:39:34 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:54442 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265321AbSL2Rje>;
	Sun, 29 Dec 2002 12:39:34 -0500
Message-ID: <3E0F3545.4040601@colorfullife.com>
Date: Sun, 29 Dec 2002 18:47:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Paul Rolland" <rol@as2917.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] So sloowwwww......
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>> 
>> >From the .config, it looks like you have a P4.  I'm not
>> seeing that regression on K6/2 or P3 Xeon.
>
>That's correct, I have a P4. 
>Maybe something related to the CPU, but I hardly see what it can
>be...
>  
>
I'd guess power management, a runaway interrupt, bad mtrr settings, 
problems with the memory map decoding or Hyperthreading.

Check
/proc/interrupts
/proc/mtrr
The memory detection results at the top of dmesg
disable apm, acpi.
Check anything Hyperthreading related in dmesg.




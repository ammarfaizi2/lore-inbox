Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTAENN0>; Sun, 5 Jan 2003 08:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTAENN0>; Sun, 5 Jan 2003 08:13:26 -0500
Received: from [81.2.122.30] ([81.2.122.30]:32773 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264724AbTAENNZ>;
	Sun, 5 Jan 2003 08:13:25 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301051321.h05DLuTs001257@darkstar.example.net>
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
To: xizard@enib.fr (XI)
Date: Sun, 5 Jan 2003 13:21:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E183D04.8040405@enib.fr> from "XI" at Jan 05, 2003 02:11:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>SBline doesn't share interrupts well.  Usually, changing PCI slots in
>>>>order to affect what interrupt is used can help a lot.  The problem is,
>>>>depending on the motherboard, figuring out what a particular PCI slot
>>>>shares an interrupt with can be difficult.
>>>
>>>After some time, I have tested ALL possibilities with my PCI graphic
>>>card and my sound blaster live. (4 PCI slots => 12 possibilities).
>>>
>>>The problem is always the same, sound still stutter.
>>>
>>>
>>>Sum-up of my problem:
>>>The sound of my computer stutter when I move a window, watch a movie,
>>>... with a kernel 2.4.19 and 2.4.20 ; whereas with a kernel 2.4.8, it
>>>works fine.
>>>I use a sound blaster live! with a Matrox G200 PCI, and an AMD 760MPX
>>>chipset.
>>
>>
>> Try adding this line to the "Device" section of your XF86Config file:
>>
>> Option	"PciRetry"	"true"
>>
>> and let us know if it stops the stuttering or not.
>>
> This option is already set in my XF86Config-4 file. It doesn't solve the
> problem.

Try setting it to false.

Also, try both settings for "PciBurst".

John.

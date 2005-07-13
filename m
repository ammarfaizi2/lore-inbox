Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVGMMXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVGMMXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 08:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVGMMXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 08:23:04 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:20709 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262552AbVGMMXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 08:23:03 -0400
Date: Wed, 13 Jul 2005 08:29:27 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
In-reply-to: <20050713103930.GA16776@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Chuck Harding <charding@llnl.gov>,
       karsten wiese <annabellesgarden@yahoo.de>
Message-id: <200507130829.27990.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.63.0507121331480.9097@ghostwheel.llnl.gov>
 <20050713103930.GA16776@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 06:39, Ingo Molnar wrote:
>* Chuck Harding <charding@llnl.gov> wrote:
>> > CC [M]  sound/oss/emu10k1/midi.o
>> >sound/oss/emu10k1/midi.c:48: error: syntax error before
>> > '__attribute__' sound/oss/emu10k1/midi.c:48: error: syntax error
>> > before ')' token
>> >
>> >Here's the offending line:
>> >
>> >   48 static DEFINE_SPINLOCK(midi_spinlock
>> > __attribute((unused)));
>> >
>> >Lee
>>
>> I got it to compile but it won't boot - it hangs right after the
>> 'Uncompressing Linux... OK, booting the kernel' - I'm using
>> .config from 51-27 (attached)
>
>and -51-27 worked just fine? I've uploaded -29 with the -28 io-apic
>changes undone (will re-apply them once Karsten has figured out
> what's wrong).
>
> Ingo
>-

27 and 28 both worked in mode 4 here Ingo, except of course for 
tvtime.  I built a 28 in mode 3 last night but haven't rebooted to it 
yet.  I don't have an sblive in this box either.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

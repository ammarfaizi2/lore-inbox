Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbTAKNOC>; Sat, 11 Jan 2003 08:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTAKNOC>; Sat, 11 Jan 2003 08:14:02 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:25048 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266537AbTAKNOB>;
	Sat, 11 Jan 2003 08:14:01 -0500
Date: Sat, 11 Jan 2003 14:22:39 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301111322.OAA26316@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, manfred@colorfullife.com
Subject: Re: [PATCH]Re: spin_locks without smp.
Cc: linux-kernel@vger.kernel.org, solt@dns.toxicfilms.tv, wli@holomorphy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2003 18:18:39 +0000, Alan Cox wrote:
>On Fri, 2003-01-10 at 17:19, Manfred Spraul wrote:
>> 
>>     disable_irq();
>>     spin_lock(&np->lock);
>> 
>> That's what 8390.c uses, no need for an #ifdef.
>
>Does someone have a card they can test that on. If so then I agree
>entirely it is the best way to go 

I have an ISA NE2000 available for testing, if someone feeds me patches.
Only UP hardware, though.

/Mikael

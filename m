Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSGXAtZ>; Tue, 23 Jul 2002 20:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSGXAtY>; Tue, 23 Jul 2002 20:49:24 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:60858 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315634AbSGXAtY>;
	Tue, 23 Jul 2002 20:49:24 -0400
Date: Wed, 24 Jul 2002 02:52:32 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207240052.CAA16441@harpo.it.uu.se>
To: davej@suse.de, mochel@osdl.org
Subject: Re: CPU detection broken in 2.5.27?
Cc: linux-kernel@vger.kernel.org, profmakx@profmakx.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 14:08:52 -0700 (PDT), Patrick Mochel wrote:
>> I meant ->x86_model there, I assume you did too, and you have a 0xF24/0xF27 cpu.
>> I wasn't aware these were HT aware. In fact, only 0xF50 are confirmed.
>> Interesting.
>
>Actually, it's Family 15, Model 1, Stepping 2. Though the HT capability
>shows up, it's disabled, so it's one of the pre-Foster P4s (though I don't
>know what they're called).

cpuid 0xF12 is a standard Willamette core P4; I have one heating my room :-)
Model 2 should be Northwood, AFAIK.

But why the table? Aren't you using the extended cpuid levels and/or the
BrandID to get the names for cpuid 0x680 (coppermine) and above cpus?

/Mikael

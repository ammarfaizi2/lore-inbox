Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSKGQj7>; Thu, 7 Nov 2002 11:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSKGQj7>; Thu, 7 Nov 2002 11:39:59 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:39177
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261430AbSKGQj6>; Thu, 7 Nov 2002 11:39:58 -0500
Date: Thu, 7 Nov 2002 11:44:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Bill Davidsen <davidsen@tmr.com>
cc: John Levon <levon@movementarian.org>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
In-Reply-To: <Pine.LNX.3.96.1021107111731.30525A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0211071142400.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Bill Davidsen wrote:

> By any chance, does this implementation imply that if I boot SMP with
> 'noapic' the NMI watchdog won't work? It doesn't, but I am not sure I had
> it on before I turned off the APIC.
>
> Clearly this would be desirable to work, as noapic is needed on a fairly
> large minority of machines.

You're not using IO-APIC interrupt handling therefore you can't use it to 
deliver to the Local-APIC unit. You're out of luck, just use Local-APIC 
NMI watchdog.

	Zwane

PS first time i've heard 'fairly large minority' ;)

-- 
function.linuxpower.ca


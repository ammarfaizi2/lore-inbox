Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132343AbRAQIPe>; Wed, 17 Jan 2001 03:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRAQIPZ>; Wed, 17 Jan 2001 03:15:25 -0500
Received: from mail.zmailer.org ([194.252.70.162]:61195 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132197AbRAQIPJ>;
	Wed, 17 Jan 2001 03:15:09 -0500
Date: Wed, 17 Jan 2001 10:14:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mainboard with Serverworks HE Chipset
Message-ID: <20010117101450.Y25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.20.0101170020001.811-100000@citd.owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0101170020001.811-100000@citd.owl.de>; from ms@citd.de on Wed, Jan 17, 2001 at 12:33:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 12:33:09AM +0100, Matthias Schniedermeyer wrote:
> I got a "Tyan Thunder HE-SL"-Mainboard today, which has a "Severworks
> ServerSet III HE"-Chipset. (2xPIII 933, 2x512MB PC133 ECC-Registered
> SDRAM)
...
> First the question. I have an uptime of phenomenal 29minutes and "cat
> /proc/interrupts" tells me this
> 
> NMI:     175819     175819
> LOC:     175829     175828
> 
> Should i be worried? Or can i ignore it. With my former Mainboard NMI was
> (AFAIR) always 0.

	My ASUS P2B-DS with intel 440BX/ZX chipset shows the same.

	As far as I can see, that means SMP with APICs.
	"LOC" is "Local APIC", "NMI" is perhaps "Remote APIC",
	or inter-processor APIC call, or some such.
	(Global CLI, TLB flushes, ...)

> Now my problem.
> 
> The Graphic-Card is a Geforce 2, Xfree is 4.02 (compiled under 2.2.17).
> 
> When i start X, everything is fine. When i go back to text-console and
> wait "some time" and then switch back to X the computer locks solid and i
> have to press the Big-Red Button. (Switching back to X after a "short"
> periode of time, at the text-console, works "normaly")
> 
> If anyone needs more information, i will happily provide them.

	I have same card, but haven't tried to do that kind of switching..
	.. at least not recently.

	You don't mention which kernel you are running, and what userspace
	package.

> Bis denn

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

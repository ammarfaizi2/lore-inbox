Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbRLXKyC>; Mon, 24 Dec 2001 05:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284696AbRLXKxx>; Mon, 24 Dec 2001 05:53:53 -0500
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:51190 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S284694AbRLXKxi>;
	Mon, 24 Dec 2001 05:53:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: VIA Chipsets + USB + SMP == UGLY TRASH
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de>
From: Jens Gecius <jens@gecius.de>
Date: Mon, 24 Dec 2001 05:53:38 -0500
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de> (Juergen Sauer's message of
 "Mon, 24 Dec 2001 10:32:49 +0100")
Message-ID: <87zo48zy6l.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Sauer <jojo@automatix.de> writes:

> Hi!
> Merry X-Mas everywhere !

Same to you.

> So, my USB tryout is over. 
> This is the expierience report:
> You should not try to use VIA Chipsets + SMP + USB, that's
> the worst thinkable idea. It's junk (usb-Part).

Well, it's not junk, I'd say. It works fine here on my gigabyte
dualboard. 

> That's why:
> 1. not solved USB Irq errors in APIC mode, causes:
> 	Error -110, device does not accept ID
> 	USB Host is recognized fine, no device is attaced

I used to have problems with APIC and my network card, but that's
over. APIC works just fine with my box (USB mouse, USB scanner).

> This is an error somewhere in the Kernel APIC Irq routing, which may 
> worked around with "append noapic pirq="your irq" but using such a
> cutdown

As I was told by Alan, it's not that "cutdown" as you would expect.

-- 
Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
 Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097

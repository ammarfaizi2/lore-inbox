Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKOUYZ>; Wed, 15 Nov 2000 15:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKOUYQ>; Wed, 15 Nov 2000 15:24:16 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:3337 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S129094AbQKOUYE>;
	Wed, 15 Nov 2000 15:24:04 -0500
Date: Wed, 15 Nov 2000 21:53:59 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Hard lockup using emu10k1-based sound card
In-Reply-To: <20001115193318.21091.qmail@eklektix.com>
Message-ID: <Pine.LNX.4.30.0011152139540.2987-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Jonathan Corbet wrote:
> Just as another data point, I, too, had trouble with lockups with the
> emu10k1 (with the 2.4.0-test driver and ALSA both).  I noticed that it was
> sharing an interrupt with ACPI.  As soon as I rebuilt the kernel with the
> ACPI Interpreter option turned off, the problem went away.

In my case, the emu10k1 has an IRQ all to itself... (and I don't have
ACPI enabled).

Been running the kernel emu10k1 on test11-pre5 since this morning.
I've only had one lockup (older testX emu10k1's locked up more
frequently). So there still appears to be a problem with (or triggered by)
test11-pre5 emu10k1. As I was under X at that stage (XMMS & two xterms), I
did not see any panic()'s or BUG()'s.

Next I'm going to compile with serial console & see if I can see any
panic() or BUG()s.

-- Hans.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

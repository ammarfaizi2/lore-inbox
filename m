Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBBUPI>; Fri, 2 Feb 2001 15:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129487AbRBBUO7>; Fri, 2 Feb 2001 15:14:59 -0500
Received: from [216.151.155.116] ([216.151.155.116]:61965 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129232AbRBBUOv>; Fri, 2 Feb 2001 15:14:51 -0500
To: Delta <birtl00@dmi.usherb.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System unresponsitive when copying HD/HD
In-Reply-To: <3A7B1129.2ED4CCE4@dmi.usherb.ca>
From: Doug McNaught <doug@wireboard.com>
Date: 02 Feb 2001 15:13:07 -0500
In-Reply-To: Delta's message of "Fri, 02 Feb 2001 14:57:29 -0500"
Message-ID: <m3vgqsetd8.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delta <birtl00@dmi.usherb.ca> writes:

> While cp is copying from the second hard disk to the first hard disk,
> I find my system performance
> drop VERY sharply.  X is sloppy, even bash takes many seconds to
> respond.  I using two
> recent IDE disk (Fudjisu 13 gig, Maxtor 20 Gig), so I'm wondering why
> the system is so slow?  My mobo is a FIC SD11 and I have an athlon
> 550 Mhz.

You don't say what kernel you're running.  Some versions (2.2.16ish)
have very bad interactive response under I/O load.  2.2.18 is supposed
to be better, or try 2.2.19pre.

Also 'hdparm -u' may help, and turning on DMA if you're not using it.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

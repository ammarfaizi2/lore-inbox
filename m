Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131091AbRAEBEW>; Thu, 4 Jan 2001 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRAEBEM>; Thu, 4 Jan 2001 20:04:12 -0500
Received: from clueserver.org ([206.163.47.224]:8465 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S131182AbRAEBD7>;
	Thu, 4 Jan 2001 20:03:59 -0500
Date: Thu, 4 Jan 2001 17:13:35 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: Andi Kleen <ak@suse.de>
Cc: ludovic fernandez <ludovic.fernandez@sun.com>, nigel@nrg.org,
        Roger Larsson <roger.larsson@norran.net>,
        Daniel Phillips <phillips@innominate.de>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <20010105014515.A8746@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10101041707510.25513-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Andi Kleen wrote:

> On Thu, Jan 04, 2001 at 04:36:32PM -0800, ludovic fernandez wrote:
> > Saying that, I definitely agree that I want/need to one day listen to
> > my MP3s while building  my kernel.
> 
> ??? I can listen to MP3s just fine while building kernels, on a not very
> powerful K6. 

I have found that sound card "hick-ups" while doing heavy work under Linux
are an indication of an IRQ problem.  I had that problem on my P-III 650
until I went in and rearranged cards and sorted out what was on what IRQ.
(The BIOS just picked numbers, it gave you no way to determine order or
slots.  What IRQ you got depended on the slot and there was no real way
to chenge it.) 

Some boards have a very poor way of chosing the assignment
of IRQs. You just have to shuffle things until you get what you want. 

Since I did the manual reorg of the hardware, things have run MUCH
smoother.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbQKSU6D>; Sun, 19 Nov 2000 15:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbQKSU5y>; Sun, 19 Nov 2000 15:57:54 -0500
Received: from [194.213.32.137] ([194.213.32.137]:24325 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130112AbQKSU5j>;
	Sun, 19 Nov 2000 15:57:39 -0500
Message-ID: <20001119212404.A1175@bug.ucw.cz>
Date: Sun, 19 Nov 2000 21:24:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com> <20001116115730.A665@suse.cz> <20001118211231.A382@bug.ucw.cz> <20001118231354.A2796@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001118231354.A2796@suse.cz>; from Vojtech Pavlik on Sat, Nov 18, 2000 at 11:13:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Anyway, this should be solvable by checking for clock change in the
> > > timer interrupt. This way we should be able to detect when the clock
> > > went weird with a 10 ms accuracy. And compensate for that. It should be
> > > possible to keep a 'reasonable' clock running even through the clock
> > > changes, where reasonable means constantly growing and as close to real
> > > time as 10 ms difference max.
> > > 
> > > Yes, this is not perfect, but still keep every program quite happy and
> > > running.
> > 
> > No. Udelay has just gone wrong and your old ISA xxx card just crashed
> > whole system. Oops.
> 
> Yes. But can you do any better than that? Anyway, I wouldn't expect to
> be able to put my old ISA cards into a recent notebook which fiddles
> with the CPU speed (or STPCLK ratio).

PCMCIA is just that: putting old ISA crap into modern hardware. Sorry.

								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

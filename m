Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268611AbRHKR6G>; Sat, 11 Aug 2001 13:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRHKR54>; Sat, 11 Aug 2001 13:57:56 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:45586 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S268611AbRHKR5s>;
	Sat, 11 Aug 2001 13:57:48 -0400
Date: Sat, 11 Aug 2001 11:57:59 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
Message-ID: <20010811115759.B19840@qcc.sk.ca>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010811125035.A6428@thyrsus.com> <Pine.LNX.3.95.1010811100610.565O-100000@scsoftware.sc-software.com> <20010811132209.A11076@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010811132209.A11076@thyrsus.com>; from esr@thyrsus.com on Sat, Aug 11, 2001 at 01:22:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> wrote:
> John Heil <kerndev@sc-software.com>:
> > You might try a heat sink & fan on the north bridge chip.
> > Also your cpu fans ought to be of the 7+K RPM variety.
> 
> Interesting.  We're going to put Silverados on the CPUs as soon as we
> can get them -- if you don't know what those are, they're a super-well-
> designed cooler that can chill a chip by 24 degrees centigrade.

Are you sure of that spec?  24 degrees isn't a whole lot for a CPU
cooler.  An Athlon without a fan can reach 70 centigrade before it fries
a few seconds later, and many of the coolers in use with them can bring
them down to high-20s.  24 degrees isn't enough.

ALso, I doubt it's memory -- you'd see segfaults or oopses.  Bad or
overheated CPU, unstable or underpowered power supply, or faulty
mainboard is more likely for your symptoms.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------

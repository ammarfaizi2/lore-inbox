Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292931AbSBVRFH>; Fri, 22 Feb 2002 12:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292934AbSBVREr>; Fri, 22 Feb 2002 12:04:47 -0500
Received: from ns.ithnet.com ([217.64.64.10]:15122 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292931AbSBVREk>;
	Fri, 22 Feb 2002 12:04:40 -0500
Date: Fri, 22 Feb 2002 18:04:29 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: fernando@quatro.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-Id: <20020222180429.313bd377.skraw@ithnet.com>
In-Reply-To: <20020222164558.GE13774@os.inf.tu-dresden.de>
In-Reply-To: <20020220104129.GP13774@os.inf.tu-dresden.de>
	<051a01c1bb01$70634580$c50016ac@spps.com.br>
	<20020221211142.0cf0efa4.skraw@ithnet.com>
	<20020222130246.GD13774@os.inf.tu-dresden.de>
	<20020222141101.0cc342e1.skraw@ithnet.com>
	<20020222164558.GE13774@os.inf.tu-dresden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 17:45:58 +0100
Adam Lackorzynski <adam@os.inf.tu-dresden.de> wrote:

> On Fri Feb 22, 2002 at 14:11:01 +0100, Stephan von Krawczynski wrote:
> > > > I compile my kernel (2.4.18-rc2) with the attached config. Please try
> > > > it and tell your results. I can assure you that this machine runs rock
> > > > solid over here for months.
> > > 
> > > No luck here. Hangs during boot (tried with 2.4.18-rc2-ac2).
> > 
> > Please start from a setup as close to mine as possible. That is 2.4.18-rc2.
> > In setup switch MPS 1.4 support to disable and Power Management to disable.
> 
> No luck, even with completely switched off PM. "noapic" works. I
> attached the stripped down config. It mostly hangs while setting up the
> second CPU.

Your config is not identical to the one I sent. If you want to find out what the problem is, you must first try to produce a setup that is known good. So simply use my config, even if it contains stuff you don't need, and especially if it does not contain stuff you want.
Your primary goal is: let the box boot.
Your secondary goal is: add your original options to my config one by one - means: add one, test it, add next.
Somewhere in between it is expected to break. Then you probably located the reason with the last option you added.

> > > I even updated the BIOS from 1010 to 1014 as well (just in case). What
> > > BIOS version are you running? And at how many MHz are the CPUs?
> > 
> > I use BIOS 1010, 2 x P3 1 GHz and tried RAM from 512MB to 2GB.
> > Currently installed are 2GB being 2 x 1GB registered DIMM.
> 
> 2x 933, RAM is 960MB.

I have several of those boards in production environment, one of those is exactly like yours (1GB RAM and 2 x PIII(933)). All of them work flawlessly. There is a chance it is related to my configs.

Regards,
Stephan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136091AbRBFAYv>; Mon, 5 Feb 2001 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132107AbRBFAYm>; Mon, 5 Feb 2001 19:24:42 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:1042 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S136063AbRBFAYE>;
	Mon, 5 Feb 2001 19:24:04 -0500
Date: Mon, 5 Feb 2001 22:23:57 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - likely fix
Message-ID: <20010205222357.C9945@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010205150802.A1568@colonel-panic.com> <3A7F00B8.9BDE5BBB@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7F00B8.9BDE5BBB@Hell.WH8.TU-Dresden.De>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05 2001, Udo A. Steinberg wrote:
> Peter Horton wrote:
> > I've found the cause of silent disk corruption on my A7V motherboard,
> > and it might affect all boards with the same North bridge (KT133 etc).
> 
> Do you have a small test program to illustrate that bug? I have an A7V
> with PCI Master Read Caching enabled and haven't seen any corruption so
> far (which doesn't necessarily mean much). Or if you don't have a test
> program, how did you identify it's caching too much?
> Also, are you using a Thunderbird or a Duron?

	Just an extra data point here.

	I have an A7V here also and I haven't seen anything wrong with
	my setup (but I'm using 2.2.18 + the IDE patches). Perhaps,
	I'm not hitting the bad cases or I'm not stressing the system
	enough. I'm using a Quantum lct15 drive here with UDMA/66
	here.  I have a Duron 600MHz and I remember that when I was
	setting the machine (after I bought it), I left everything in
	the default settings (so, the PCI Master Read Caching is
	disabled).

> I'm using the 1003 Bios, which has proven to be the most stable so far.
> Which one do you use?

	I also use 1003, but I have not tried anything else (for fear
	of something going wrong when I'm upgrading -- like a power
	outage). :-)


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

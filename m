Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287785AbSAAKPz>; Tue, 1 Jan 2002 05:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287784AbSAAKPp>; Tue, 1 Jan 2002 05:15:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287783AbSAAKPc>; Tue, 1 Jan 2002 05:15:32 -0500
Subject: Re: New Scheduler and Digital Signal Processors?
To: landley@trommello.org (Rob Landley)
Date: Tue, 1 Jan 2002 10:25:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020101050208.OMXO20896.femail24.sdc1.sfba.home.com@there> from "Rob Landley" at Dec 31, 2001 04:00:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LM7L-0008Cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason I ask is TI has a new chip with a DSP built into it, and DSPs are 
> eventually bound to replace all the dedicated I/O chips we've got today.  A 
> DSP is just a dedicated I/O processor, they can act like modems, sound and 
> video, 3D accelerators, USB interface, serial/paralell/joystick, ethernet, 
> 802.11b wireless and bluetooth...  Just hook it up to the right output 
> adapter and feed the DSP the right program and boom, it works.

Thats the theory. If you believe it please read up on the history of the
i960 based i2o motherboard PCI controller, the 56K dsp on some Atari
machines and so on.

> of the suckers, in massive volume, and think "economies of scale".  These 
> suckers are going to be CHEAP.  And low power.  The portable market seems to 

And irrelevant

	o	An extra chip - expensive to mount and wire
	o	"But we can do that on the main processor"

etc

>From a scheduling point of view I would expect such a dsp to run a seperate
OS of its own, perhaps the rtlinux core without Linux

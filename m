Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290666AbSARKsT>; Fri, 18 Jan 2002 05:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290663AbSARKsJ>; Fri, 18 Jan 2002 05:48:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290666AbSARKr6>; Fri, 18 Jan 2002 05:47:58 -0500
Subject: Re: PROBLEM: Oops in 2.4.18-pre4
To: stijn.opheide@kotnet.org (Stijn Opheide)
Date: Fri, 18 Jan 2002 10:59:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020118112703.C9703@ace.ulyssis.org> from "Stijn Opheide" at Jan 18, 2002 11:27:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RWk6-0006cY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using sounddrivers from www.opensound.com, but I tried to load the
> joystick modules before loading soundmodules.

Not according to the oops

> >>EIP; d884312a <[sndshield]udi_interruptible_sleep_on_timeout+1e/30>
> >><=====
So you have opensound stuff loaded

> Trace; d88412fc <[gameport]gameport_open+14/40>

> Code;  d884312a <[sndshield]udi_interruptible_sleep_on_timeout+1e/30>
> 00000000 <_EIP>:
> Code;  d884312a <[sndshield]udi_interruptible_sleep_on_timeout+1e/30>
> <=====

and indeed it blew up in their code


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262697AbSJDUre>; Fri, 4 Oct 2002 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbSJDUrd>; Fri, 4 Oct 2002 16:47:33 -0400
Received: from 62-190-217-49.pdu.pipex.net ([62.190.217.49]:61188 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262697AbSJDUrc>; Fri, 4 Oct 2002 16:47:32 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210042101.g94L1eS5008337@darkstar.example.net>
Subject: Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 4 Oct 2002 22:01:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021004224547.A49400@ucw.cz> from "Vojtech Pavlik" at Oct 04, 2002 10:45:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Once booted:
> > > > 
> > > > Hot plugging either the dedicated trackball or a PS/2 mouse generates a message on connection:
> > > 
> > > Good, this is expected.
> > > 
> > > > Just to clarify, I am not trying to use them both at the same time.
> > > 
> > > Not sure if that would work, it might - depends on the notebook keyboard
> > > controller hardware.
> > 
> > I tried it, and it seems to get really confused - constant stream of seemingly random error messages.
> > 
> > > > X also works with the external PS/2 mouse,
> > > 
> > > Good.
> > > 
> > > > but not the dedicated trackball.
> > > 
> > > What are the exact symptoms?
> > 
> > No data at all from it.
> > 
> > > Does gpm work?
> > 
> > No.
> > 
> > > Does cat /dev/psaux work?
> > 
> > It doesn't say No such device, it just hangs, giving no data for the trackball, but works fine for the generic mouse.
> > 
> > > Does cat /dev/input/mice work?
> > 
> > Yes, it does the same as /dev/psaux
> > 
> > > What does cat /proc/bus/input/devices say in the
> > > case it doesn't work? ....
> > 
> > I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> > N: Name="PS/2 Generic Mouse"
> > P: Phys=isa0060/serio1/input0
> > H: Handlers=mouse0
> > B: EV=7
> > B: KEY=70000 0 0 0 0 0 0 0 0
> > B: REL=3
> > 
> > That's for both the generic mouse and the trackball.
> 
> Ok. Can you try the usual #define I8042_DEBUG_IO in
> drivers/input/serio/i8042.h?

OK, no problem, but it might take a while.  The machine in question has a fubar floppy drive, and the only way to get a new kernel over to it is via a 9600 bps serial link...  I'll get to work straight away :-)

John.

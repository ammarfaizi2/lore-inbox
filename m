Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262301AbSJDUiS>; Fri, 4 Oct 2002 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSJDUiS>; Fri, 4 Oct 2002 16:38:18 -0400
Received: from 62-190-217-49.pdu.pipex.net ([62.190.217.49]:59396 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262301AbSJDUiR>; Fri, 4 Oct 2002 16:38:17 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210042052.g94KqQmB008165@darkstar.example.net>
Subject: Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 4 Oct 2002 21:52:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021004221554.A49104@ucw.cz> from "Vojtech Pavlik" at Oct 04, 2002 10:15:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Once booted:
> > 
> > Hot plugging either the dedicated trackball or a PS/2 mouse generates a message on connection:
> 
> Good, this is expected.
> 
> > Just to clarify, I am not trying to use them both at the same time.
> 
> Not sure if that would work, it might - depends on the notebook keyboard
> controller hardware.

I tried it, and it seems to get really confused - constant stream of seemingly random error messages.

> > X also works with the external PS/2 mouse,
> 
> Good.
> 
> > but not the dedicated trackball.
> 
> What are the exact symptoms?

No data at all from it.

> Does gpm work?

No.

> Does cat /dev/psaux work?

It doesn't say No such device, it just hangs, giving no data for the trackball, but works fine for the generic mouse.

> Does cat /dev/input/mice work?

Yes, it does the same as /dev/psaux

> What does cat /proc/bus/input/devices say in the
> case it doesn't work? ....

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

That's for both the generic mouse and the trackball.

John.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132938AbRAPVn6>; Tue, 16 Jan 2001 16:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRAPVns>; Tue, 16 Jan 2001 16:43:48 -0500
Received: from eliot.thebog.net ([209.220.238.57]:25357 "EHLO mail.thebog.net")
	by vger.kernel.org with ESMTP id <S130032AbRAPVnc>;
	Tue, 16 Jan 2001 16:43:32 -0500
Date: Tue, 16 Jan 2001 16:43:29 -0500
To: "Rodney M. Jokerst" <rmjokers@gnwy29.wuh.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem:  Blank screen in X after heavy disk access (2.4 only)
Message-ID: <20010116164329.A1247@eliot.thebog.net>
In-Reply-To: <Pine.LNX.4.21.0101161503310.24100-100000@gnwy29.wuh.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101161503310.24100-100000@gnwy29.wuh.wustl.edu>; from rmjokers@gnwy29.wuh.wustl.edu on Tue, Jan 16, 2001 at 03:11:01PM -0600
From: Nathan Thompson <nate@thebog.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 03:11:01PM -0600, Rodney M. Jokerst wrote:
> This action causes my screen to go blank in X and remain blank
> unless I move the mouse or type on the keyboard.  The second I stop doing
> one of these activities, it goes blank again.  While it is blank, it seems
> to be flashing every second, as if it is recieving blank screen commands
> repeatedly.  This behavior continues until I restart the machine.  If I
> switch to a console, everything is fine.  If I restart the X server, the
> behavior continues.

Is this a VIA chipset based motherboard?

If so someone (Vojtech Pavlik ?) has a patch that helps this... 
It is a hardware error.

For what it's worth I have seen this exact same behavior on my machine
in 2.2.x.

I have an abit ka7 motherboard, via kx133 chipset.

Nate

> thanks,
> 
> Rodney M. Jokerst

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUJRJyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUJRJyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJRJvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:51:49 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:38829 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266175AbUJRJqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:46:55 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: I/O card vs linux
Date: Mon, 18 Oct 2004 05:46:53 -0400
User-Agent: KMail/1.7
Cc: Stephen Wille Padnos <spadnos@sover.net>
References: <200410160423.43597.gene.heskett@verizon.net> <41734721.3070508@sover.net>
In-Reply-To: <41734721.3070508@sover.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410180546.53707.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.58.180] at Mon, 18 Oct 2004 04:46:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 00:31, Stephen Wille Padnos wrote:
>Gene Heskett wrote:
>>Greetings;
>>
>>This may be OT, but can anyone advise me on a pci card thats
>> basicly an 8255 with a 34 pin or greater port on the card or back
>> panel to bring out all 3 ports, and a suitable linux compatible
>> driver for it?
>
>3 possibilities: (there are more, including some with industrial
>protection, isolation, etc.)
>
>www.computerboards.com : PCI-DIO24 and PCI-DIO24H, $89.  These are
>basically a single 8255 connected to the bus through a PCI glue
> chip. They don't seem to provide a driver, but I would think the
> board would be set up automatically by the PCI code, and then there
> are just the standard 4 ports to read/write (you just have to find
> the base address theough the PCI subsystem).
>
>www.ni.com : NI-PCI-6503, $145.  This is a 24 I/O board, but has
> added logic (like a programmable power-on I/O state).  There don't
> seem to be Linux drivers, but they may exist if you ask tech
> support.  (NI is fairly Linux-friendly - they made a LabView/Linux
> version).
>
>www.byterunner.com : PCI-1284-P2, $39.95.  This is a dual IEEE1284
> PCI parallel port card, with Linux drivers.  It's not quite what
> you're looking for, but it will give you 24 I/O's (16 bidir, 10
> dedicated, 2 interrupts).
>
>Hope this helps
>- Steve

I did find the NI site, but the $ scared me off, I'm trying to do this 
on the cheap since I'm mostly retired now.  I have a triple 8255 
board with 72 I/O lines from Futurlec.com coming now, with surface 
shipping, a hair over $70.  I don't believe the output is more than 
what the 8255 can sink by itself, no real buffering seems to be 
visible in the photo's on their wab page.  Its called the PCI8255.
The byterunner card might possibly be usable too but it didn't fall 
out of the search terms I used.  Bios wise, I'll find out when it 
gets here sometime this week.

Thanks Stephen.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

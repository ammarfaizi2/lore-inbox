Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUBGET2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266709AbUBGET2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:19:28 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:36600 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S266669AbUBGETX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:19:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Fri, 6 Feb 2004 23:19:19 -0500
User-Agent: KMail/1.6
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Murilo Pontes <murilo_pontes@yahoo.com.br>,
       linux-kernel@vger.kernel.org
References: <200402041820.39742.wnelsonjr@comcast.net> <20040205203840.GA13114@ucw.cz> <20040207023510.GI12503@mail.shareable.org>
In-Reply-To: <20040207023510.GI12503@mail.shareable.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402062319.19635.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.53.166] at Fri, 6 Feb 2004 22:19:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 February 2004 21:35, Jamie Lokier wrote:
>Vojtech Pavlik wrote:
>> On Thu, Feb 05, 2004 at 05:24:27PM +0000, Murilo Pontes wrote:
>> > I try kernel with/without  preempty/acpi/apic make all
>> > possibilities, then may be error is not in kernel, but in
>> > XFree86-4.3.0 which not support big changes in input system of
>> > 2.6.x, I tried compile XFree86 with linux-2.6.{0,1,2} kernel
>> > headers was 100% fail, sounds binary and source
>> > incompatibilites,
>>
>> Hey, guys, could you possibly try to figure out what your machines
>> have in common? I've switched all my computers to PS/2 mice so
>> that I have a bigger chance to reproduce the problem, but it is
>> not happening on any of them.
>
>Heh.  I have a USB mouse and I see similar problems:
>
>Red Hat 9 (more or less), XFree86-4.3.0-2, kernel 2.6.0-test10, dual
>athlon, USB Logitech optical mouse, configured to read from
>/dev/input/mice (only!).
>
>Every few hours the mouse suddenly jumps to a corner of the screen
> and seems broken for a second or so.  After that I can move it back
> to where it is useful.
>
>I never noticed such behaviour when running 2.4 on this box, nor
> when running earlier 2.6 kernels.
>
>There is nothing about "atkbd" or "mouse" or "lost synchronisation"
> in the kernel log.

FWIW, I do have those lines from atkbd, blamed on X in my logs as I 
startx.

And, I have an occasional attack of spasticity in my mouse, on this 
machine only (VIA 8233 chipset) since back in later 2.4 days.  I've 
even posted about it, but its not a *huge* problem, just a minor 
aggravation.  The exact same mouse model, and mouse cause I've traded 
them (a pair of logitech usb optical wheel mice) has no trouble at 
all on an old TYAN S-1590 mobo.  ISTR its running some version of 
2.4.20 yet, with lots of guard dogs, its my firewall.

>-- Jamie
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

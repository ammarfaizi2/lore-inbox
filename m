Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTDUNec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 09:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTDUNec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 09:34:32 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:60064 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S261258AbTDUNea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 09:34:30 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
Message-Id: <5.2.0.9.0.20030421063052.00a706c0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 21 Apr 2003 06:46:30 -0700
To: Edgar Toernig <froese@gmx.de>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: (OT) md5sum proving to be an EXCELLENT memory test
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EA3EC75.35988618@gmx.de>
References: <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
 <6uwuhpl2u5.fsf@zork.zork.net>
 <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
 <6uwuhpl2u5.fsf@zork.zork.net>
 <5.2.0.9.0.20030420132915.01d28c40@fluent2.pyramid.net>
 <5.2.0.9.0.20030420163516.02076ec0@fluent2.pyramid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:04 PM 4/21/03 +0200, you wrote:
>Stephen Satchell wrote:
> >
> > The "good memory test suite" I have didn't catch it.  The copy method you
> > suggest didn't catch it.  The BIOS memory check didn't catch it.  Only the
> > linux compile method -- mentioned on this list -- did catch it.  And so did
> > using md5sum on very long files.
>
> >From my experience it's not bad RAM that shows these failures but
>an overheating CPU.
>
>Ciao, ET.

Well, I just finished an overnight test on the server in question.  If it's 
an overheating CPU, then I don't understand how replacing the RAM stick 
fixes the problem so that it runs without failure for 12 hours.  An 
overheating RAM stick could do it, too.

In tracing through my collection of computers, I have found others with 
this flaky RAM that show intermittent failures using md5sum that other 
tests don't find (including kernel compiles).  All the failing RAM comes 
from the same manufacturer and batch.  I think it's just barely marginal 
memory, myself.  Once I replace it all, I should stop seeing the 
every-other-fortnight problems that have plagued me for the past year.

It also means I need to check the junk pile to see if the failed systems 
have RAM trouble at their heart.

(N.B.:  This little exercise has opened my eyes some little bit.  Easter 
was a great time to bring down the servers one by one, blow the crap out of 
them with compressed air, and check the RAM.  And replace questionable 
RAM.   I'm also going to have a little talk with the computer store that 
sold me a "white box" computer with PC66 SDRAM when PC100 SDRAM was called 
for.)

Here's how bad some of this stuff was:  I took an ASUS P5A-B board with an 
AMD K6-II, slowed the bus down to 87 MHz from 100 MHz, and the damn memory 
fails at the slower bus speed.  Every loose stick from that batch of RAM 
shows the failure.  (memtest86 caught the errors, by the way, so 
diagnostics aren't completely worthless.)

Kingston, Viking, and Micron are getting more of my business.


--
X -> unknown; Spurt -> drip of water under pressure
Expert -> X-Spurt -> Unknown drip under pressure.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUBASXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 13:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUBASXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 13:23:42 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:3494 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S265403AbUBASXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 13:23:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: joshk@triplehelix.org, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Date: Sun, 1 Feb 2004 13:23:37 -0500
User-Agent: KMail/1.6
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org>
In-Reply-To: <20040201163136.GF11391@triplehelix.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402011323.37900.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.53.166] at Sun, 1 Feb 2004 12:23:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 February 2004 11:31, Joshua Kwan wrote:
>On Sun, Feb 01, 2004 at 11:06:44AM +0100, Vojtech Pavlik wrote:
>> I'm getting double clicks when I click only once.
>
>I get these spuriously and i'm using only /dev/input/mice in my
> config flie.

In years past, the mouse double-click for a single click syndrome was 
caused by the pushbutton switch in the mouse becoming unsoldered, as 
in a microscopic crack in the solder you had to use a strong glass to 
see around the switches pin in the puddle of solder.  Holding the 
switch solidly against the board and resoldering fixed it right up.

Not for folks who don't know which end of the soldering iron gets 
hot...

What was happening is that the switch would close and send the event, 
but the finger then pushed the switch down against the board anotheer 
thousandth, causeing the pin to rise slightly on the bottom of the 
board, breaking the solder connection, which sent that event as a 
button rise, and the situation was then reversed as the finger came 
back up, giving 2 full clicks for one push.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270554AbTGNHGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270555AbTGNHGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:06:06 -0400
Received: from static24-72-8-145.reverse.accesscomm.ca ([24.72.8.145]:37639
	"EHLO kiyone.zre.ca") by vger.kernel.org with ESMTP id S270554AbTGNHGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:06:03 -0400
Date: Mon, 14 Jul 2003 01:20:49 -0600
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange issue with keyboard in 2.5
Message-ID: <20030714072048.GA1083@zre.ca>
References: <Pine.LNX.4.44.0307140200460.10141-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307140200460.10141-100000@coredump.sh0n.net>
User-Agent: Mutt/1.5.4i
From: sec@zre.ca (Sean Connor)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 02:01:58AM -0400, Shawn Starr wrote:
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> 
> 
> When I press certain key combinations I get this logged.
> 
> Also if I hold down a key sometimes it gets 'stuck' and repeats forever
> until I break the repeat.
> 
> Why is this happening in 2.5?
> 
> Is it due to my KVM or something else?

Are you using 'tleds', or some other program that flashes the keyboard
LEDs?

I was using the abovementioned program, which flashes the keyboard LEDs in
response to network activity, and I had the same problem.  It disappeared
when I disabled the program.

Whether this is a bug in tleds or a general issue with frobbing the keyboard
LEDs, I don't know, though.
 
-- 
  -Sean Connor  (sec@zre.ca)
                (sec@accesscomm.ca)
             
Bad command or filename! Bad!   <Whack!Whack!Whack!>

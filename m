Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275396AbTHITsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275395AbTHITsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:48:23 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19980 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S275394AbTHITsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:48:19 -0400
Date: Sat, 9 Aug 2003 21:48:18 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3 and earlier] no keyboard
Message-ID: <20030809214818.A9019@pclin040.win.tue.nl>
References: <87ptjebwb8.fsf@deneb.enyo.de> <20030809203852.A9000@pclin040.win.tue.nl> <874r0qaazr.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <874r0qaazr.fsf@deneb.enyo.de>; from fw@deneb.enyo.de on Sat, Aug 09, 2003 at 09:26:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 09:26:16PM +0200, Florian Weimer wrote:
> Andries Brouwer <aebr@win.tue.nl> writes:
> 
> >> atkbd.c: Unknown key (set 0, scancode 0xed, on isa0060/serio0) pressed.          
> 
> > Set 0 is "impossible", certainly a bug.
> > So what are the boot messages about the keyboard?
> 
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> I hope these lines are the correct ones.

But no lines like

input: AT Set 2 keyboard on isa0060/serio0

?



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbTGOIqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbTGOIqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:46:46 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39306 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266921AbTGOIqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:46:45 -0400
Date: Tue, 15 Jul 2003 11:01:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Erwin Rol <mailinglists@erwinrol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptic problems on Vaio GRX516MD
Message-ID: <20030715090132.GA28580@ucw.cz>
References: <1058259115.3600.11.camel@erwin.fe.think>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058259115.3600.11.camel@erwin.fe.think>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:51:56AM +0200, Erwin Rol wrote:
> Hello all,
> 
> i am having problems with the synaptic touchpad on my vaio GRX516MD.
> Under 2.4 it works normally (also with the synaptic XFree module) but
> under 2.5 and 2.6 it just doesn't work. The XFree module complains that
> /dev/psaux isn't a synaptic device.

You need a different XFree86 driver for 2.5 - see
	http://w1.894.telia.com/~u89404340/touchpad/index.html

> Also when i press a key on the keyboard it just shows one time, but when
> i touch the synaptic pad at the time of pressing the key the key gets
> repeated 5 or 6 times  (after releasing the key). 

This is interesting ...

> Jul 14 23:28:22 vaio kernel: mice: PS/2 mouse device common for all mice
> Jul 14 23:28:22 vaio kernel: Synaptics Touchpad, model: 1
> Jul 14 23:28:22 vaio kernel:  Firware: 5.9
> Jul 14 23:28:22 vaio kernel:  Sensor: 37
> Jul 14 23:28:22 vaio kernel:  new absolute packet format
> Jul 14 23:28:22 vaio kernel:  Touchpad has extended capability bits
> Jul 14 23:28:22 vaio kernel:  -> multifinger detection
> Jul 14 23:28:22 vaio kernel:  -> palm detection
> Jul 14 23:28:22 vaio kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
> Jul 14 23:28:22 vaio kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Jul 14 23:28:22 vaio kernel: input: AT Set 2 keyboard on isa0060/serio0
> Jul 14 23:28:22 vaio kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

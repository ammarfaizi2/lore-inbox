Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFOXbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTFOXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 19:31:49 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:27317
	"EHLO jumper") by vger.kernel.org with ESMTP id S263025AbTFOXbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 19:31:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi>
	<20030615191125.I5417@flint.arm.linux.org.uk>
	<87el1vcdrz.fsf@jumper.lonesom.pp.fi>
	<20030615212814.N5417@flint.arm.linux.org.uk>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Mon, 16 Jun 2003 02:46:00 +0300
In-Reply-To: <20030615212814.N5417@flint.arm.linux.org.uk> (Russell King's
 message of "Sun, 15 Jun 2003 21:28:14 +0100")
Message-ID: <87he6qc3bb.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Sun, Jun 15, 2003 at 11:00:00PM +0300, Jaakko Niemi wrote:
>> Russell King <rmk@arm.linux.org.uk> writes:
>> > On Sun, Jun 15, 2003 at 08:50:49PM +0300, Jaakko Niemi wrote:
>> >>  I seem to be able to reproduce crash with 2.7.70-bk and .71.
>> >>  First, I tried getting dlink dwl-650 wlan card up on my thinkpad
>> >>  570e, but orinoco_cs does not seem to want to even look at it.
>> >>  (any ideas what's the deal with that, btw?) 
>> >
>> > What happens if you plug in your cardbus card before the dlink wlan card?
>> 
>>  Same thing.
>
> Ok, I'm confused.  I suspect that it may be something to do with two
> PCI device structures appearing for the same device, however I don't
> see that happening with the code which is in 2.5.7x.

 Hmm, that second instance was not there always. I'll try to get 
 a crash without it.

> Which kernel version first showed the problem?

 2.5.71-bk13 was the first I managed to notice this with, iirc.
 If you have some older version in mind, I can try that. 

> Which modules are you loading?

 Only those that come by default with this config:

 snd, soundcore, usbkbd and usbcore

> Which version of cardmgr are you using?

 3.2.2

> Are you using any modules from the pcmcia-cs package?

 No.

                --j

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUAJVri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUAJVrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:47:37 -0500
Received: from zork.zork.net ([64.81.246.102]:2704 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265494AbUAJVrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:47:36 -0500
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do not use synaptics extensions by default
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz>
	<20040110194420.GA1212@elf.ucw.cz> <20040110195531.GD22654@ucw.cz>
	<6u1xq77e29.fsf@zork.zork.net> <20040110202348.GA23318@ucw.cz>
	<6uwu7z5y1y.fsf@zork.zork.net> <m2u133qyj7.fsf@p4.localdomain>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Jan 2004 21:47:32 +0000
In-Reply-To: <m2u133qyj7.fsf@p4.localdomain> (Peter Osterlund's message of
 "10 Jan 2004 22:33:32 +0100")
Message-ID: <6un08v5vd7.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Sean Neakums <sneakums@zork.net> writes:
>
>> Vojtech Pavlik <vojtech@suse.cz> writes:
>> 
>> > On Sat, Jan 10, 2004 at 08:18:22PM +0000, Sean Neakums wrote:
>> >
>> >> Will this also result in the passthough port not being enabled?
>> >> (I'd like to disable it.)
>> >
>> > It depends on the touchpad firmware. Most leave it enabled.
>> > In this mode we don't have any control over the passthrough port.
>> 
>> I notice that the passthrough appears as an extra device (mouse1 on my
>> system).  Is there a way to disable devices from userspace?
>
> You can write a program that grabs the event device for exclusive
> access and then just ignores all events, like this:

That works great.  Thank you!


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030778AbWI0Ue1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030778AbWI0Ue1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030780AbWI0Ue0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:34:26 -0400
Received: from khc.piap.pl ([195.187.100.11]:3457 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030778AbWI0UeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:34:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: GPLv3 Position Statement
References: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org>
	<Pine.LNX.4.64.0609271031300.3952@g5.osdl.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 27 Sep 2006 22:34:21 +0200
In-Reply-To: <Pine.LNX.4.64.0609271031300.3952@g5.osdl.org> (Linus Torvalds's message of "Wed, 27 Sep 2006 10:51:50 -0700 (PDT)")
Message-ID: <m33bad9hgy.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I generally agree with you, but...

Linus Torvalds <torvalds@osdl.org> writes:

> And it not at all uncommon to have a flash that simply cannot be upgraded 
> without opening the box. Even a lot of PC's have that: a lot (most?) PC's 
> have a flash that has a separate _hardware_ pin that says that it is 
> (possibly just partially) read-only. So in order to upgrade it, you'd 
> literally need to open the case up, set a jumper, and _then_ run the 
> program to reflash it.

I think this is history. Yes, late 486s and Pentiums (60 and 66?)
had a jumper protecting the flash. It's not true since ca. "Pentium 75+"
days - while many boards use "bootblock" chips, it's (almost?) always
unprotected (at most it just requires setting some GPIO pin(s)). The
rest of flash obviously has to be R/W to support the ESCD etc.

I think there are systems with 2 copies of the whole BIOS, and the
user selects the copy with a jumper (probably connected directly to
the most significant address line of the flash IC) - the second
copy might theoretically use a R/O bootblock but I've never checked it.

Most VGAs, disks, PCI cards etc. have flash chips with no protection
either, and I have to say I felt much better when they used (EP)ROMs.

I think almost all hardware manufacturers use a blank flash chips,
programming them "in system" with things like JTAG.
-- 
Krzysztof Halasa

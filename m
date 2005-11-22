Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVKVSlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVKVSlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVKVSlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:41:46 -0500
Received: from canardo.mork.no ([148.122.252.1]:3813 "EHLO canardo.mork.no")
	by vger.kernel.org with ESMTP id S965098AbVKVSlp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:41:45 -0500
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Organization: DoD
References: <87zmoa0yv5.fsf@obelix.mork.no>
	<d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
	<20051119234850.GC1952@spitz.ucw.cz>
	<200511220026.55589.dtor_core@ameritech.net>
	<871x19giuw.fsf@obelix.mork.no> <20051122174643.GB1752@elf.ucw.cz>
Date: Tue, 22 Nov 2005 19:41:41 +0100
In-Reply-To: <20051122174643.GB1752@elf.ucw.cz> (Pavel Machek's message of
	"Tue, 22 Nov 2005 18:46:43 +0100")
Message-ID: <871x18ed96.fsf@obelix.mork.no>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

>> A failed resume is a near catastrophy if you use and trust swsusp. And
>> how could it ever be useful if you don't?
>
> Failed resume is only as bad as powerfail.

Sure.  I can live with a failed resume.  I just don't see it as a fix
for anything.  IMHO it's the worst possible option available when
trying to resume, so it should not be chosen too easily.

(I don't really have any powerfail situations as long as swsusp works.
I use an ACPI alarm to suspend when remaing battery charge is low)

>> Maybe that even would give me a chance to fix some hardware problem
>> causing the timeout, and then retry the resume.
>
> ..while doing resume few times, trying to change hw config to make it
> resume is _way_ more dangerous.

I guess it would be.  But then, what are the chances it would make the
situation any worse?  Probably never would work, but at least I would
get the satisfaction of *trying* :-)

Falling back to a clean reboot would still be an option if everything
else failed.

That said, until 2.6.14 I had never ever experienced a failed resume
with this laptop.  So I don't really believe it would happen again,
given that the timout doesn't continue to cause unnecessary failures.

Thanks for all the good work!  I've been running Linux on a number of
laptops since 1998 and am most impressed by the swsusp evolution the
last few years.  Things weren't too bad when APM used to work and
"lots of RAM" meant 80GB, but today I don't think I could use a laptop
without swsusp.


Bjørn

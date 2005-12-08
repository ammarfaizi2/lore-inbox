Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVLHK1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVLHK1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 05:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVLHK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 05:27:43 -0500
Received: from mx.laposte.net ([81.255.54.11]:42849 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1751114AbVLHK1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 05:27:42 -0500
Message-ID: <35082.192.54.193.25.1134037636.squirrel@rousalka.dyndns.org>
Date: Thu, 8 Dec 2005 11:27:16 +0100 (CET)
Subject: Re: Linux in a binary world... a doomsday scenario
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20051204.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jeu 8 décembre 2005 01:58, Kasper Sandberg wrote:
> On Tue, 2005-12-06 at 21:39 +0000, Nicolas Mailhot wrote:
>> Arjan van de Ven <arjan <at> infradead.org> writes:
>>
>> > There are lots of opportunities to put pressure on vendors, either
>> > direct or indirect. Nvidia has a support department. If they get
>> enough
>> > calls / letters about their solution not being good enough, they're
>> more
>> > likely to consider the rearchtect solution.

>> Right now getting hardware advice is a long and painful process.
>> Hardware that
>> works is only semi-documented. Hardware which doesn't isn't at all.
>> Users have
>> to comb numerous on-line databases and mail archives (full of
>> obsolete/wrong
>> info) to spec a single linux-friendly system. Few people bother to
>> answer
>> hardware advice requests on mailing lists.

> i disagree, you make it sound like it takes we
eks of effort to find out
> which stuff works on linux, and that basically you have to be lucky to
> find it at all...
>
> basically the only thing that doesent work (i dont count binary-only
> solutions working) is nvidia and ati.

I agree you can get most systems working. If you don't care about advanced
features (PM management, hardware-specific optimizations...), the means
(nsdiswrapper, specific kernel version...) and limit yourself to very
mainstream hardware (ie two-years-old perf when windows users get the
latest enhancements).

But that's exactly the point Arjan made. Because we do not discriminate
based on support quality, whole classes of devices are choosing minimalist
support (-> erosion). Graphic cards and wireless cards are only those who
pushed this logic to its extreme.

If you trust blind luck and good enough, you don't have any purchasing
influence, and things will degenerate as they are doing now.

This is BTW why the logo idea is stupid. Logo is a boolean stuff. Either
you only give it to perfectly friendly hardware, and almost no one will
get it, or you accept all sorts of compromises, and harware makers will
only aim for the minimal requirements needed for the logo and nothing
else.

Much better a notation on a web site, showing in real time how individual
hardware/hardware makers are progressing from red to green (with shades of
orange between) or the other way.

This is what linuxprinting does, what alsa tries to (and fails somewhat,
sorry Lee) etc, etc. If a single system was used and more effort expanded
to have exhaustive hardware lists I assure you its effects would be felt
by hardware makers. Every single hardware review site could complete its
coverage for free by linking the official linux kernel hardware assessment
to its review. Right now they have no idea if a piece of hardware works
well or not, and because it's a lot of work to get the info they don't
bother. Which means kernel people opinion is worth next to nothing (as
Arjan complains).

Some people have proposed a wiki. A wiki is good but that's an
half-measure. Do it the full way - choose one of the FOSS ecommerce
stacks, replace the its comparison parameters by things we care about,
feed the underlying DB and just watch as people buy based on your
notation.

People do not follow the recommendations of every review web site because
they trust them. They follow the recommendations because it's the ones
easiest to get, and they don't want to bother with official (but difficult
to reach) sources.

Regards,

-- 
Nicolas Mailhot


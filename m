Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWGQPJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWGQPJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWGQPJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:09:47 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:3017 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750818AbWGQPJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:09:47 -0400
Date: Mon, 17 Jul 2006 16:31:06 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Diego Calleja <diegocg@gmail.com>
Cc: arjan@infradead.org, caleb@calebgray.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
In-Reply-To: <20060717160618.013ea282.diegocg@gmail.com>
Message-ID: <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
 <20060717160618.013ea282.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1890372446-43599693-1153146666=:10427"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1890372446-43599693-1153146666=:10427
Content-Type: TEXT/PLAIN; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 17 Jul 2006, Diego Calleja wrote:
> El Mon, 17 Jul 2006 13:48:02 +0200 (CEST),
> Grzegorz Kulewski <kangur@polcom.net> escribi=F3:
>> If someone thinks that Reiser4 is too unstable or evil he can set it to =
N
>> and be happy. And if Reiser4 will be abandoned by Namesys and not fixed
>
> http://wiki.kernelnewbies.org/WhyReiser4IsNotIn

I already read it when it was posted first. I am reading LKML and=20
reiserfs-list for several years and I already read all that arguments,=20
flames and so on that were ever pointed here. I think I have enough.

But if we are there:

""But just include it as experimental code regardless of everything,=20
reiser programmers will fix all the problems eventually!"

Well, no and yes. As said, nobody expects reiser 4 to be bug-free, but=20
there're some important issues that need to be fixed, the problems is=20
that reiser 4 is still working in the important ones. Some of the issues=20
fixed in the past included severe design issues, BTW. Others are about=20
being well integrated with Linux: duplication of kernel's own=20
functionality for no reason, etc. Every piece of code submitted needs to=20
have some quality - requesting developers to fix severe issues before=20
getting it into the main tree helps to have better code. If you ask=20
people people to fix those issues "in the future", they'll be lazy and=20
there'll be critical issues around all the time - this has happened in=20
Linux in the past. Quality is important, specially under a stable=20
development phase. Linux is already being critized a lot for merging new=20
features during this stable phase - that criticism happens with the=20
current quality control. Imagine what would happen if linux started to=20
merge things without caring a bit about what gets merged. Also, consider=20
what Reiser 4 is. It's a filesystem, once it gets included in the kernel=20
many people WILL use it and will DEPEND on it (your disk format is=20
reiser4): Linux needs to ensure that things don't blow up everything."

Why do some people think that users are not already depending on it? They=
=20
are. I don't know how much but I am willing to bet that at least 100=20
people. I think that there are some drivers in the kernel that have=20
smaller user base.

Keeping Reiser4 out of kernel is even worse (for those users, other users=
=20
that could test this filesystem, for Reiser4 developers and whole=20
comunity) than accepting it for a try period with a big fat warning that=20
it my be removed if Namesys abandons futher fixing of it (after some time=
=20
to let user migrate).

And any arguments like "if Reiser4 is not in the kernel then people will=20
not use and depend on it" are fundamentally flawed IMHO. Everything bad=20
that could happen with Reiser4 in the kernel can happen with Reiser4 out=20
of it.

It may look like some kernel developers are trying hard not to take=20
responsibility for Reiser4 saying that there is very huge difference=20
between selecting highly experimental kernel feature that is marked so and=
=20
patching the kernel with it. Sorry but I think there is very little=20
difference. And that little difference is only hurting users that want to=
=20
try and test something new.


Thanks,

Grzegorz Kulewski


PS. I really don't want to begin World War 4 about Reiser4. I just think=20
that curious people asking from time to time about _current_ Reiser4=20
status should not be treated bad because that could make them stop=20
testing and giving back to the open source projects.

---1890372446-43599693-1153146666=:10427--

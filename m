Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTKTE7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTKTE7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:59:52 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:59282 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264265AbTKTE7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:59:50 -0500
Message-ID: <3FBC4A42.8010806@cyberone.com.au>
Date: Thu, 20 Nov 2003 15:59:46 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au> <20031120043848.GG19856@holomorphy.com>
In-Reply-To: <20031120043848.GG19856@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>
>>>We'd lose a few things, like vmware, but it's not worth the threat of
>>>vendors migrating en masse to NDIS/etc. emulation layers and dropping
>>>all spec publication and source drivers, leaving us entirely at the
>>>mercy of BBB's (Buggy Binary Blobs) to do any io whatsoever.
>>>Seriously, the binary-only business has been doing us a disservice, and
>>>is threatening to do worse.
>>>
>
>On Thu, Nov 20, 2003 at 03:16:46PM +1100, Nick Piggin wrote:
>
>>You have to admit its good for end users though. And indirectly, what
>>is good for them is good for us. Take the nvidia example: end users get
>>either a binary driver or nothing. If we were somehow able to stop
>>nvidia from distributing their binary driver, they would say "OK".
>>I don't advocate making it easy to do non native drivers of course.
>>
>
>I'm not convinced it is good for end users. They _think_ they're
>getting something that's supported by Linux, but are instead getting
>something highly problematic that ties them to specific kernel
>versions and cuts off most, if not all, avenues of support available.
>

Well what they get is hardware accelerated 3d graphics under Linux.
If they didn't need 3d, they can use the open source drivers.
If someone downloads and installs the drivers themselves, they should
know enough to contact nvidia for support (I think nvidia have been
pretty good). Others will contact their ditro support.

There might be a problem where they percieve that Linux is unstable
while it is actually binary drivers.

>
>It's very much a second-class flavor of open source. They dare not
>change the kernel version lest the binary-only trainwreck explode.
>They dare not run with the whiz-bang patches going around they're
>interested in lest the binary-only trainwreck explode. It may oops
>in mainline, and all they can do is wait for a tech support line to
>answer. Well, they're a little better than that, they have hackers
>out and about, but you're still stuck waiting for a specific small
>set of individuals and lose all of the "many eyes" advantages.
>


I must say that I've been using the same nvidia drivers on my desktop
system for maybe a year, and never had a crash including going through
countless versions of 2.5/6. True you need to recompile the intermediate
layer, but then, nobody who knows less than me will know or care about
kernel versions. Their distro will upgrade kernel+drivers if needed, and
presumably the distro has done some sort of testing / QA.



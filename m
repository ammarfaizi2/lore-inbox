Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTKTFb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTKTFb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:31:29 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:27064 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261464AbTKTFbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:31:25 -0500
Message-ID: <3FBC50B1.2020901@cyberone.com.au>
Date: Thu, 20 Nov 2003 16:27:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com> <3FBC402E.6070109@cyberone.com.au> <20031120043848.GG19856@holomorphy.com> <3FBC4A42.8010806@cyberone.com.au> <20031120051211.GE22764@holomorphy.com>
In-Reply-To: <20031120051211.GE22764@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>
>>>I'm not convinced it is good for end users. They _think_ they're
>>>getting something that's supported by Linux, but are instead getting
>>>something highly problematic that ties them to specific kernel
>>>versions and cuts off most, if not all, avenues of support available.
>>>
>
>On Thu, Nov 20, 2003 at 03:59:46PM +1100, Nick Piggin wrote:
>
>>Well what they get is hardware accelerated 3d graphics under Linux.
>>If they didn't need 3d, they can use the open source drivers.
>>If someone downloads and installs the drivers themselves, they should
>>know enough to contact nvidia for support (I think nvidia have been
>>pretty good). Others will contact their ditro support.
>>
>
>"cuts off most, if not all, avenues of support available" == any and
>all problems with the things around are untraceable. We won't touch
>tainted bugreports and rightly so. And nvidia isn't supporting the
>whole kernel.
>
>

I guess they're tracable for nvidia. I'm not aware of how nvidia
Linux development works. I assumed from the lack of bug reports that
they had done something about it. I concede that bad support from
a vendor might cause a bad perception of Linux.

>
>On Thu, Nov 20, 2003 at 03:59:46PM +1100, Nick Piggin wrote:
>
>>There might be a problem where they percieve that Linux is unstable
>>while it is actually binary drivers.
>>
>
>Yes, that's one I'm very concerned about.
>

Bad problem.

>
>
>William Lee Irwin III wrote:
>
>>>It's very much a second-class flavor of open source. They dare not
>>>change the kernel version lest the binary-only trainwreck explode.
>>>They dare not run with the whiz-bang patches going around they're
>>>interested in lest the binary-only trainwreck explode. It may oops
>>>in mainline, and all they can do is wait for a tech support line to
>>>answer. Well, they're a little better than that, they have hackers
>>>out and about, but you're still stuck waiting for a specific small
>>>set of individuals and lose all of the "many eyes" advantages.
>>>
>
>On Thu, Nov 20, 2003 at 03:59:46PM +1100, Nick Piggin wrote:
>
>>I must say that I've been using the same nvidia drivers on my desktop
>>system for maybe a year, and never had a crash including going through
>>countless versions of 2.5/6. True you need to recompile the intermediate
>>layer, but then, nobody who knows less than me will know or care about
>>kernel versions. Their distro will upgrade kernel+drivers if needed, and
>>presumably the distro has done some sort of testing / QA.
>>
>
>They're rather sensitive to VM changes, and I've had people with
>significantly less know-how than either of us come back after trying VM
>patches in combination with nvidia stuff report things ranging from
>oopsen, to reboots, to fs corruption. The insulation layers are only
>partially effective at best. And end-users are fiddling with whiz bang
>patches for their kernels and upgrading versions by means other than
>distros. Heck, the distros aren't even shipping 2.6, and they're
>running 2.6 plus patches.
>

I didn't mean that in an elitist way (you shouldn't be compiling
kernels unless you are taller than the sign) - I just mean the knowledge
required to recompile the kernel and nvidia drivers. And the people
with that know how should generally know that the binary modules
can be unstable. Again I concede this won't always be the case.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSAMXdx>; Sun, 13 Jan 2002 18:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSAMXdn>; Sun, 13 Jan 2002 18:33:43 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:61065 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S288298AbSAMXdb>;
	Sun, 13 Jan 2002 18:33:31 -0500
Message-ID: <3C421946.6020607@pobox.com>
Date: Sun, 13 Jan 2002 15:33:26 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dieter =?ISO-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020113201352Z288089-13997+4417@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

>Yes, but I did latency testing for Robert for several months, now.
>
I'm not saying you see no improvements, I'm
saying that most actual latency tests show
that low-latency gets better low latency results.

Perhaps there are differences in how each of
our particular setups responds to the respective
approaches.

>I am, too. But more for 3D visualization/simulation (with audio).
>
Certainly not conflicting goals!

>Not for me. Even when lock-brake is applied.
>
That's odd - but IIUC preempt + lock-break was the
RML answer to the low latency patch and seems to
give similar results for a more complex solution.

>>Kernel
>>compilation time is the farthest thing from my
>>mind when e.g. playing Q3A!
>>
>
>Q3A is _NOT_ changed in any case. Even some smoother system "feeling" with Q3A and UT 436 running in parallel on an UP 1 GHz Athlon II, 640 MB. 
>
That's odd - for me the low latency kernels give
not only a smoother feel, but also markedly higher
standing on average at the end of the game.

Perhaps your setup has something that is
mitigating the beneficial effects of the low
latency modifications?

Are you running a non-ext2 filesystem?

Do you have a video card that grabs the
bus for long periods?

And you set /proc/sys/kernel/lowlatency=1...

On my PIII 933 UP w/512 MB it does help.

>Have you seen something on any Win box?
>
I have seen the games played on windoze and
have played at lan parties with win32 opponents
but I do not personally play games on windoze.
Lack of interest, I guess...

>>I'd be happy to check out the preempt patch
>>again and see if anything's changed, if the
>>problem of tux+preempt oopsing has been
>>dealt with -
>>
>
>You told me that TUX show some problems with preempt before. What problems? Are they TUX specific?
>
On a kernel with both tux and preempt, upon
access to the tux webserver the kernel oopses
and tux dies. Not good when I depend on tux.

OTOH the low latency patch plays quite well
with tux. As said, I have no anti-preempt agenda,
I just need for whatever solution I use to work,
and not crash programs and services we use.

>Some latency numbers coming soon.
>
Great!

jjs




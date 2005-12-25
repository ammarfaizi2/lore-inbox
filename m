Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVLYENa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVLYENa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 23:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLYENa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 23:13:30 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:17117 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750766AbVLYEN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 23:13:29 -0500
Message-ID: <43AE1C5B.5010002@comcast.net>
Date: Sat, 24 Dec 2005 23:13:15 -0500
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check 2.6.13.3 dual opteron
References: <43AD8631.1090605@comcast.net> <3aa654a40512241258l2d3e0c57qf2345b143304bbef@mail.gmail.com>
In-Reply-To: <3aa654a40512241258l2d3e0c57qf2345b143304bbef@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Avuton Olrich wrote:
> On 12/24/05, Andy Stewart <andystewart@comcast.net> wrote:
> 
>>My machine locked up on me and I found this message on my serial
>>console.  I have no idea how to decode its meaning - can you help?
>>
>>CPU 0: Machine Check Exception:                4
>>Bank 4: b200000000070f0f
>>TSC 39619ee1e2187
>>Kernel panic - not syncing: Machine check
>>
>>My machine is a dual Opteron running the 2.6.13.3 kernel.  I'm not
>>positive, but I think I can reproduce it.  Assuming that I can, what
>>information would be helpful to debug the problem?
>>
>>Please cc: me on the response as I am not subscribed to this mailing list.
> 
> 
> Welcome to my life. Finding out what exactly's causing the problem is
> paramount to me, also. I'm getting a random crash sometimes after an
> hour, sometimes it'll go 24 hours. But the results are consistant.
> After talking to AMD Tech support, they basically said they could do
> nothing for me. Are your opterons dual core? I've gotten an email from
> someone who was having the same problem with a similar setup but was
> running a dual core chip.
> 
> I have had one person personally email me about this subject and he
> stated that taking one of his hard drives off 'slave' helped. (I'm
> only running one hard drive at the moment, which isn't on slave and
> doesn't help).
> 
> The recommended:
> I run memtest86 (did for 24 hours, everything seems is fine there).
> 
> And they said they could help me no further.
> 
> Here's my thread on the subject.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113239372109342&w=2
> --
> avuton
> --
>  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Hello Avuton,

Thank you for your reply to my inquiry.  My Opterons are 244s and they
are not dual core.  Like you, my setup has passed 24 hours of memtest on
at least 2 or 3 separate occasions.

I'm strongly suspicious of the MB since a BIOS upgrade improved my
situation but there is still instability.  Nothing else I've done has
had as marked an effect on stability as that BIOS upgrade.

I've even turned off every spiggot on the MB and replaced them with
their own circuit boards, all to no avail.  This thing still hangs
randomly - sometimes after a couple of days, sometimes after 3 weeks,
sometimes multiple times in an evening.

I'll take a look at the thread which you referenced.  I also plan to
replace the MB due to my aforementioned suspicions.

Thanks!

Andy

- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDrhxbHl0iXDssISsRAraeAJ99WLYZNBPvAiltl21oBS1RtwIt+gCcDUIK
GJw+0tj7AOJooKb6E0gnka4=
=N+p9
-----END PGP SIGNATURE-----

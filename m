Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVI0Mha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVI0Mha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVI0Mha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:37:30 -0400
Received: from alpha.polcom.net ([217.79.151.115]:22675 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S964866AbVI0Mh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:37:29 -0400
Date: Tue, 27 Sep 2005 14:38:10 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
In-Reply-To: <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br>
Message-ID: <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net>
 <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1339650967-1030135789-1127824690=:21130"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1339650967-1030135789-1127824690=:21130
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Sep 2005, Rog=E9rio Brito wrote:

> Hi, Grzegorz. Thank you for your response.

Hi, no problem.

> On Sep 27, 2005, at 8:43 AM, Grzegorz Kulewski wrote:
>> What is your southbridge?
>
> The southbridge is a VIA VT82C686.

I know. I had the same southbridge in my Abit KG7 but I don't know if you=
=20
have version A or version B. I had version B and it has several disk=20
problems fixed. For version A there are some workarounds in the kernel.


>> Maybe there are some problems there with DMA or cables.
>
> Humm, cables. I forgot to check that. I will check that as soon as I wake=
 up.=20
> I spent the entire night trying to fix this, but of course, I gave up aft=
er=20
> some days of effort and decided to ask for help.
>
>> Anything in logs?
>
> Nothing in the logs. No oops, no stack trace, no nothing. :-( Oh, now tha=
t

I don't think that there will be any oops or something like that. But=20
maybe some IDE messages - like failed commands or something. But if there=
=20
are no such messages then chance is that this is some memory/mb problem.


> you mention it, I remember that I also made my Matrox G400 use speed 4x. =
I=20
> will try slowing it down to see if there is any influence on what I see.

Yes, slowing down your graphics card could help.


>> Maybe sourthbridge or northbridge is simply overheating? Maybe you have =
bad=20
>> power suply? What are readings of temperatures and voltages in BIOS afte=
r=20
>> some heavy disk-memmory activities?
>
> I don't know, because lmsensors doesn't give accurate measurements,=20
> unfortunately. :-(

So after burning reboot fast end check the BIOS measurements. Temperatures=
=20
will not change that much in minute or two. If your system is overheating=
=20
they will be high for at least 5 minutes after reboot.


>> You can use http://pyropus.ca/software/memtester/ to check your memory i=
n=20
>> linux. You can run cpuburn at the same time. And you can do some disk=20
>> activity at the same time (for example dd if=3D/dev/hda bs=3D200M | md5s=
um=20
>> several times to check if it will give the same results).
>
> I had already tried using memtester, but I guess that I was too ambitious=
=20
> with the amount of memory that I tried it to allocate. I will try this, b=
ut=20
> with my filesystem in read-only mode, as I cannot afford to loose what I =
have=20
> (and Debian's mondo/mind isn't working right now---I already filed a bug=
=20
> report that is shared by others).
>
>> I will bet that you have some hardware problem there. You can try to rem=
ove=20
>> the 256MB DDR module and turn HIGHMEM off. You can also try to check eac=
h=20
>> module separately.
>
> I already checked each module separately, but I didn't see any corruption=
=2E I=20
> guess that I maybe wasn't paying too much attention. I will try it again.=
=20
> Thanks for the suggestion.


Hmm... What did you change before the system started not working? Maybe=20
try with only 256MB module installed if that was the working=20
configuration...


>> And the best choice will be probably to buy new mb (for example Abit KW7=
 or=20
>> KV7) because your is very old and it can start to silently break after s=
o=20
>> many years... Today mbs are very short living parts - 3-4 years and they=
=20
>> are broken...
>
> Yes, I was just trying to avoid getting a new system now, with all the=20
> transitions going on (i386 -> x86_64 CPUs, PATA -> SATA etc). But my time=
 is

Yeah, I am waiting for stable and better x86_64 too. But I replaced my KG7=
=20
to KW7 in the mean time just to be sure I have something before I will=20
buy x86_64. :-)


> also costing me some nights of sleep... :-( It sucks not to be in the US,=
=20
> where things are cheaper. :-(

Yeah, it sucks. I live in Poland and we have really big prices for=20
computer parts here. :-(


> Thank you very much, Rog=E9rio.

No problem.


Grzegorz Kulewski
--1339650967-1030135789-1127824690=:21130--

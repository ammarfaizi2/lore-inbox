Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTH0B4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTH0B4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:56:13 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:23036 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263057AbTH0B4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:56:08 -0400
Message-ID: <3F4C0FA0.1080201@comcast.net>
Date: Tue, 26 Aug 2003 21:55:44 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: =?ISO-8859-1?Q?Diego_Calleja_Garc=EDa?= <aradorlinux@yahoo.es>,
       =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente=5F=5F=5F=5F?= 
	<retes_simbad@yahoo.es>,
       jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es> <20030825222215.GX7038@fs.tum.de> <1061857293.15168.3.camel@debian> <20030826234901.1726adec.aradorlinux@yahoo.es> <20030826215544.GI7038@fs.tum.de>
In-Reply-To: <20030826215544.GI7038@fs.tum.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Aug 26, 2003 at 11:49:01PM +0200, Diego Calleja García wrote:
> 
>>El Tue, 26 Aug 2003 02:21:34 +0200 Ramón Rey Vicente____ <retes_simbad@yahoo.es> escribió:
>>
>>
>>>I think merging ALSA in 2.4 series bring some of the advantages of the
>>>2.6 series to the stable kernel, just new drivers with improvements over
>>>OSS... but I dont think that will help in the switching to 2.6.
>>
>>
>>I agree with Ramon; OSS doesn't provide drivers for some cards (or they
>>have really low quality, like the one for my card...). It's not just easing
>>the migration.
>>
>>Reasons to include ALSA in 2.4.23:
>>
>>- Lots of people need it.
>>- 99.9 % of kernels from vendors have it (they need to include them to
>>  give good hardware support), which means they have been tested a lot.
> 
> 
> I must have missed the date when Debian's market share dropped under 
> 0.1 % ...
> 
> 
>>- Lots of non-vendor kernels have it (even more testing).
>>- Some drivers have better quality.
>>- Low impact: they don't break anything; they're just configurable drivers.
>>- They're stable.
>>- They're cool.
>>
>>Reasons against:
>><write here your opinion>
>>...
> 
> 
> - ALSA is big and there are still some bugs in ALSA; there are more
>   urgent things to be fixed in 2.4
> - it's easy to use ALSA even when it's not inside the kernel
> - within a few months 2.6.0 will be released with ALSA included -
>   together with the point above I don't see a reason why ALSA would be
>   badly needed in 2.4

Last time I checked i810 audio did NOT work under 2.4. That is why I 
switched to ALSA. (The intel8x0 driver is perfectly stable for me)
IMO, OSS should be phased out quickly as it is wasting energy to 
maintain it. Those maintainers could be fixing the broken ALSA drivers 
instead of wasting their time trying to fix the broken OSS drivers.
ALSA should be included in 2.4 to help make the 2.4 to 2.6 hop easier.
Thoughts about this?

-David


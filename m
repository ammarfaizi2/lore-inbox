Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbTLEPdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 10:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbTLEPdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 10:33:42 -0500
Received: from realityfailure.org ([209.150.103.212]:13746 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id S264561AbTLEPdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 10:33:37 -0500
Date: Fri, 5 Dec 2003 10:33:32 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: Jan Rychter <jan@rychter.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
In-Reply-To: <m2k75dzj6n.fsf@tnuctip.rychter.com>
Message-ID: <Pine.LNX.4.44.0312051021300.1469-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Jan Rychter wrote:

> >>>>> "Marcelo" == Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
>  Marcelo> The intention of this email is to clarify my position on 2.4.x
>  Marcelo> future.
> 
>  Marcelo> 2.6 is becoming more stable each day, and we will hopefully
>  Marcelo> see a 2.6.0 release during this month or January.

I would argue that 2.2 wasn't really usable until somewhere around 2.2.12.

I would also claim that 2.4 wasn't useful until 2.4.10.

If we continue to improve along these lines, can I expect 2.6 to be 
generally usable somewhere around 2.6.8? :)

> On my notebook, I have spent the last two years going through regular
> painful kernel patching and upgrades. 

<snip>

His experiences pretty much mirror my own -- ACPI has been an adventure, 
cpufreq occasionally didn't work, full USB doesn't work without ACPI, I 
need alsa drivers and ACPI in order to have acceptable sound, and I need 
to use GATOS drivers for my display, else 3d just blows chunks.

For the longest time on this beast, kernel upgrades were a day long 
adventure. 

First, to push in acpi, cpufreq, and freeswan. (Oh, look, 2.4.foo is 
out ... but the latest ACPI patch was 2.4.foo-prebar and CPUfreq is 
2.4.foo-pre(bar-2)-3weeks-earlier ... time to patch and resolve 
rejections!)

Then it was off to put in alsa, radoen, freeswan, linux-wlan-ng and so 
forth ...

Some things should be migrated in and updated. drm modules, for example. I 
would also vote for alsa being merged. ACPI was brought up to date in 
2.4.22, I believe, but I haven't checked since then. It should also be 
relativelt current, IMHO.

>   1) Please don't stop working (and that does include pulling in new
>      stuff) on 2.4, as many people still have to use it.
> 
>   2) Please don't start developing 2.7 too soon. Go for at least 6
>      months of bug-fixing. During that time, patches with new features
>      will accumulate anyway, so it isn't lost time. But it will at least
>      prevent people from saying "well, I use 2.7.45 and it works for
>      me".

I have to agree with both of these points. 2.6.0 will probably have 
problems that will take a while to sort out. Putting it on systems to test 
is one thing, putting it into production as its the only blessed solution 
is another ...

-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.



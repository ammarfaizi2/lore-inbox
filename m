Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423424AbWBBJhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423424AbWBBJhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423425AbWBBJhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:37:20 -0500
Received: from [85.8.13.51] ([85.8.13.51]:34282 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1423424AbWBBJhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:37:19 -0500
Message-ID: <43E1D2D0.2060105@drzeus.cx>
Date: Thu, 02 Feb 2006 10:37:20 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com> <200601302301.04582.brcha@users.sourceforge.net> <43E0E282.1000908@opersys.com> <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org> <43E1C55A.7090801@drzeus.cx> <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 2 Feb 2006, Pierre Ossman wrote:
>   
>> The point is not only getting access to the source code, but also being able
>> to change it. Being able to freely study the code is only half of the beauty
>> of the GPL. The other half, being able to change it, can be very effectively
>> stopped using DRM.
>>     
>
> No it cannot.
>
> Sure, DRM may mean that you can not _install_ or _run_ your changes on 
> somebody elses hardware. But it in no way changes the fact that you got 
>   

I don't consider things I've bought to be somebody elses hardware. The 
whole attitude of the big manufacturer that kindly gives me permission 
to use their product only how they see fit is very disgusting to me.

> The difference? The hardware may only run signed kernels. The fact that 
> the hardware is closed is a _hardware_ license issue. Not a software 
> license issue. I'd suggest you take it up with your hardware vendor, and 
> quite possibly just decide to not buy the hardware. Vote with your feet. 
> Join the OpenCores groups. Make your own FPGA's.
>   

I'm concerned that in a few years time such systems will be rare and 
hard to come by (possibly even illegal). I find such system pissing all 
over the spirit of the GPL. To me, the GPL has always been about the 
freedom of modifying (in place, not making a clone).

It's a fine line before we are in the territory of restricting what 
software can be used for. But for me this is not about restricting their 
rights as much as it is preventing them from restricting mine.

> And it's important to realize that signed kernels that you can't run in 
> modified form under certain circumstances is not at all a bad idea in many 
> cases.
>
> For example, distributions signing the kernel modules (that are 
> distributed under the GPL) that _they_ have compiled, and having their 
> kernels either refuse to load them entirely (under a "secure policy") or 
> marking the resulting kernel as "Tainted" (under a "less secure" policy) 
> is a GOOD THING.
>   

I dislike the former but the latter is acceptable (and, as you say, in 
some cases desirable). There is a big difference between refusing to run 
and printing/logging warnings.

> Notice how the current GPLv3 draft pretty clearly says that Red Hat would 
> have to distribute their private keys so that anybody sign their own 
> versions of the modules they recompile, in order to re-create their own 
> versions of the signed binaries that Red Hat creates. That's INSANE.
>
> Btw, what about signed RPM archives? How well do you think a secure 
> auto-updater would work if it cannot trust digital signatures?
>
>   

I'm arguing the principle here, not the wording of the current draft. 
Signatures that are required for execution should be covered, those that 
result in warnings should not be. Imagine the shit storm if Red Hat 
decided to ship an rpm that didn't allow packages that weren't signed by 
them.

It's basically about control. I do not find it reasonable to allow the 
vendor control of what goes or not on systems I've bought. They're free 
to put systems in place so they can detect that I've fiddled with it so 
they can deny me support. But if they want to make a completely closed 
system then they'll have to develop it on their own and not use my code. 
"Look but don't touch" is not sufficient for me.

Rgds
Pierre



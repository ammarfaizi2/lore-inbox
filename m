Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992685AbWJTSJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992685AbWJTSJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992687AbWJTSJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:09:14 -0400
Received: from smtp105.plus.mail.re2.yahoo.com ([206.190.53.30]:4203 "HELO
	smtp105.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S2992685AbWJTSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:09:13 -0400
Message-ID: <453910C6.4000102@tungstengraphics.com>
Date: Fri, 20 Oct 2006 19:09:10 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: Keith Packard <keithp@keithp.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
References: <20061013194516.GB19283@tau.solarneutrino.net> <1160849723.3943.41.camel@neko.keithp.com> <20061017174020.GA24789@tau.solarneutrino.net> <1161124062.25439.8.camel@neko.keithp.com> <4535CFB1.2010403@tungstengraphics.com> <20061019173108.GA28700@tau.solarneutrino.net> <4538B670.2030105@tungstengraphics.com> <20061020164008.GA29810@tau.solarneutrino.net> <45390C85.3070604@tungstengraphics.com> <20061020180354.GB29810@tau.solarneutrino.net>
In-Reply-To: <20061020180354.GB29810@tau.solarneutrino.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
> On Fri, Oct 20, 2006 at 06:51:01PM +0100, Keith Whitwell wrote:
>> Ryan Richter wrote:
>>> On Fri, Oct 20, 2006 at 12:43:44PM +0100, Keith Whitwell wrote:
>>>> Ryan Richter wrote:
>>>>> On Wed, Oct 18, 2006 at 07:54:41AM +0100, Keith Whitwell wrote:
>>>> All of your other wierd problems, like the assert failures, etc, make me 
>>>> wonder if there just hasn't been some sort of build problem that can 
>>>> only be resolved by clearing it out and restarting.
>>>>
>>>> It wouldn't hurt to just nuke your current Mesa and libdrm builds and 
>>>> start from scratch - you'll probably have to do that to get debug 
>>>> symbols for gdb anyway.
>>> I had heard something previously about i965_dri.so maybe getting
>>> miscompiled, but I hadn't followed up on it until now.  I rebuilt it
>>> with an older gcc, and now it's all working great!  Sorry for the wild
>>> goose chase.
>> Out of interest, can you try again with the original GCC and see if the 
>> problem comes back?  Which versions of GCC are you using?
> 
> The two gcc versions are the 4.1 (miscompiles) and 3.4 (OK) from Debian
> unstable.  I had originally compiled it myself with gcc-4.1 because the
> Debian libgl1-mesa-dri package didn't build i965_dri.so until I
> submitted a build patch to them to have it built.  They released a new
> package a few days ago with i965_dri.so included, presumably built with
> the same gcc-4.1, the default cc on Debian unstable.
> 
> I had exactly the same problems with my own version and theirs.  I
> rebuilt it again today with CC=gcc-3.4 and now everything works great.
> I saved a copy of the old i965_dri.so, so I can verify in the next few
> days that replacing it breaks things again.  Let me know if you want
> copies of these files to examine.

Sure, email me the 4.1 version offline.  I'll also see about installing 
4.1 here.

Keith

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWC1BWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWC1BWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWC1BWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:22:47 -0500
Received: from smtpout.mac.com ([17.250.248.84]:3071 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751194AbWC1BWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:22:46 -0500
In-Reply-To: <4428872E.3020308@wolfmountaingroup.com>
References: <20060327231049.GA30641@localhost.in.y0ur.4ss> <4428872E.3020308@wolfmountaingroup.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <69495D2A-5488-428E-970F-EA4DD8CB4C05@mac.com>
Cc: =?ISO-8859-1?Q?Friedrich_G=F6pel?= <shado23@gmail.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       alsa-user@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: hda-intel woes
Date: Mon, 27 Mar 2006 20:22:28 -0500
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2006, at 19:45:34, Jeff V. Merkey wrote:
> Visit www.redhat.com.  Purchase a support contract for customer  
> service, fastest way to get help.

First of all, Jeff, no need to be rude, he asked a reasonable  
question and provided all the pertinent useful info.  You also  
committed the grievous mailing-list etiquette violation of top- 
posting.  A more polite and useful response is as follows:

Friedrich Göpel wrote:
> This same message was sent to the alsa mailinglist 3 weeks ago, but  
> it still seems to be waiting on being moderated, so I'm resending  
> this here.

Hi!  Unfortunately messages tend to get lost on occasion due to the  
sheer volume of email.  Sometimes you may have to resend a couple  
times to get a response.  It also helps if you add relevant CC's from  
the MAINTAINERS file (added to this message).  You can also file a  
bug report on the ALSA bug tracker, I think the ALSA people tend to  
be fairly good about keeping up with that; sometimes more so than the  
mailing list.

Cheers,
Kyle Moffett

Remainder copied verbatim for those added to the CC:
> Hi,
>
> I tried installing linux on my sister's new acer extensa 6700  
> laptop. I tried Fedora FC4, FC5 test 3 and now Gentoo with various  
> kernel and alsa versions (specifically 1.0.10 and 1.0.11-rc3 and  
> whatever is in fedora before and after a full update). Also I set  
> up a friends vaio laptop also with an intel hd audio chip, which is  
> working peachy. I also tried model=basic/hp/fujitsu just in case.
>
> Just to preempt the question: I did unmute and raise the mixer levels.
>
> Anyways the damn thing is not to be convinced to produce a single  
> sound.
>
> In light of this I suppose Acer did something nasty to that chip.
>
> I'm attatching here the relevant part of lspci -vv in hopes of  
> somebody being either able to point out a fix or tell me if it's  
> going to be supported sometime soon.
>
> I could pose as a genuea pig if neccessary. Also if there is any  
> further information I should gather just tell me.
>
> Otherwise it's back to windows for my sister I guess.
>
> PS. I'm not subscribed to the list so please CC me. Thanks.
>
> 00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6  
> Family) High Definition Audio Controller (rev 04)
>        Subsystem: Acer Incorporated [ALI] Unknown device 008f
>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast  
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin A routed to IRQ 177
>        Region 0: Memory at d000c000 (64-bit, non-prefetchable)  
> [size=16K]
>        Capabilities: [50] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0 
> +,D1-,D2-,D3hot+,D3cold+)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>        Capabilities: [60] Message Signalled Interrupts: 64bit+  
> Queue=0/0 Enable-
>                Address: 0000000000000000  Data: 0000
>        Capabilities: [70] Express Unknown type IRQ 0
>                Device: Supported: MaxPayload 128 bytes, PhantFunc  
> 0, ExtTag-
>                Device: Latency L0s <64ns, L1 <1us
>                Device: Errors: Correctable- Non-Fatal- Fatal-  
> Unsupported-
>                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
>                Link: Supported Speed unknown, Width x0, ASPM  
> unknown, Port 0
>                Link: Latency L0s <64ns, L1 <1us
>                Link: ASPM Disabled CommClk- ExtSynch-
>                Link: Speed unknown, Width x0
>        Capabilities: [100] Virtual Channel
>        Capabilities: [130] Unknown (5)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289987AbSBOQRt>; Fri, 15 Feb 2002 11:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289901AbSBOQRk>; Fri, 15 Feb 2002 11:17:40 -0500
Received: from [80.224.208.53] ([80.224.208.53]:33090 "EHLO head.redvip.net")
	by vger.kernel.org with ESMTP id <S289987AbSBOQRd>;
	Fri, 15 Feb 2002 11:17:33 -0500
Message-ID: <3C6D34B5.3050900@zaralinux.com>
Date: Fri, 15 Feb 2002 17:17:57 +0100
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: funny console prob w/2.4.18-pre[479]+kpreempt+sched-o(1)
In-Reply-To: <3C66743C.9BA03219@folkwang-hochschule.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Nettingsmeier wrote:
> hello *
> 
> it happens to me regularly that the x server dies without any
> obvious reason.

I remeber that some time ago, around XFree 4.0 I also had this issues.

> funny thing is, it takes the virtual text consoles with it, which is
> why i'm posting here.
> 

Yes, the same issues, now it almost never dies, and if it dies the 
consoles work ok (I'm using FB at 1024x768 and Xfree at 1152x864)

> i end up in kdm and i can restart x alright, but when i switch vc's,
> all i see is a frozen image of the x screen. i can switch back to x,
> and it runs.
> 

When this happened to me I saw garbage from the X screen from the time 
it died, let's see, X dies, I get dropped to the console (seeing garbage 
colors of the scren) gdm restarts, everything seems ok, but going back 
to the console you see the same garbage as before.

> all tasks i started on the vc's before keep running, the mingettys
> are there, the bashes are there, and i can even blind-type commands
> that will run correctly. only the display is messed up.
> a blind-typed "reset" has no effect.
> 

I also found that enebling the xv extension in my XFree causes the 
consoles to be lost, but in a different way.

After enabling it and entering X if I switch to a console I see the 
console image, but no matter what I do the console stays the same, as 
you say I can type blindly.

> any clues ?
> i'm using x version 4.2.0 with a voodoo3 card (dri and agp enabled).
> this is an smp box with 2 p3/600 katmai.
> might this be not a kernel issue, but an x11 problem ?
> 

We have too many things in common to stablish a pattern, I'm using XFree 
4.2.0, a voodoo 3 2000 pci card, and I also have a smp box, but it's a 
2x200mmx.

I think it's a X issue by not leaving the console state consitent.

> best wishes,
> 
> jörn
> 
> 
> please keep be cc:ed, i only read lkml archives.
> 

I'm doing


-- 
Jorge Nerin
<comandante@zaralinux.com>


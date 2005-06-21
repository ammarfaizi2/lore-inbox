Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFUMHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFUMHq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVFUMGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:06:06 -0400
Received: from alog0132.analogic.com ([208.224.220.147]:153 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261280AbVFUMB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:01:27 -0400
Date: Tue, 21 Jun 2005 08:01:16 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dave Jones <davej@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <20050621115516.GC592@redhat.com>
Message-ID: <Pine.LNX.4.61.0506210756230.9871@chaos.analogic.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <20050621003203.GB28908@redhat.com> <Pine.LNX.4.61.0506210629110.8815@chaos.analogic.com>
 <20050621111301.GA592@redhat.com> <Pine.LNX.4.61.0506210714400.9115@chaos.analogic.com>
 <20050621113040.GB592@redhat.com> <Pine.LNX.4.61.0506210733430.9577@chaos.analogic.com>
 <20050621115516.GC592@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Dave Jones wrote:

> On Tue, Jun 21, 2005 at 07:36:21AM -0400, Richard B. Johnson wrote:
> > On Tue, 21 Jun 2005, Dave Jones wrote:
> >
> > >On Tue, Jun 21, 2005 at 07:17:55AM -0400, Richard B. Johnson wrote:
> > >
> > >> >> Bullshit. The source is available to anybody who wants it.
> > >> >Great. Then please explain why you pull off this kind of crap..
> > >> >(DataLink/license.c)
> > >> Because it's true.
> > >
> > >kernel/module.c:1259 disagrees with you.
> > >
> > >static inline int license_is_gpl_compatible(const char *license)
> > >{
> > >   return (strcmp(license, "GPL") == 0
> > >       || strcmp(license, "GPL v2") == 0
> > >       || strcmp(license, "GPL and additional rights") == 0
> > >       || strcmp(license, "Dual BSD/GPL") == 0
> > >       || strcmp(license, "Dual MPL/GPL") == 0);
> > >}
> > >
> > >> >MODULE_LICENSE("GPL\0 They won't allow GPL/BSD anymore!");
> > >
> > >AFAICS, this is just plain deception. I suggest reading
> > >http://marc.theaimsgroup.com/?l=linux-kernel&m=108304056922350&w=2
> > >especially the part about talking to lawyers.
> > >
> > >		Dave
> > >
> >
> > At the time the work-around was inserted it was FACT.
>
> According to the RCS file in the tarball you sent, license.c
> was written on 2004.11.09.16.54.17;
> It most certainly was around back then.
>
> > I don't
> > spend my time rewriting license strings to accommodate the
> > whims of the latest GPL fanatic, thank you.
>
> So I see. So instead you subvert the checks instead.
>
> btw, text like this..
>
> *     #                   C O N F I D E N T I A L                      #
> *     #  The information contained  in or upon  this document  is the  #
> *     #  property  of  Analogic Corporation and  is considered to  be  #
> *     #  proprietary  and  may  not  be used by any recipient without  #
> *     #  the specific written permission of Analogic Corporation.      #
>

This is USER MODE TEST code! I case you can't read, check for main().
In the real world, we write test code to verify that the driver(s)
work. The test code has the company standard header as required by
the company management. That's what real engineers have to do,
satisfy the customers, and the management. We do not, however,
have to satisfy you.

> Just fills me with confidence about the GPL'd nature of this driver.
>
> Due to the "C O N F I D E N T I A L" nature of this driver, I've stopped
> reading. Pity, datalink.c was quite amusing.
>

You are really sad.


> *  Changed a lot of code to accommodate the stupid and sometimes
> *  downright wrong changes to the Linux kernel that occurred in
> *  Version 2.6.n.
> *
> *  Yes. It's broken. I had to hard-code a bunch of stuff using
> *  "#define" where previously the kernel provided a logical
> *  value.
>
> 		Dave
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

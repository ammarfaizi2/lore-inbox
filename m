Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUCHFwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUCHFwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:52:37 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:32517 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262398AbUCHFwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:52:34 -0500
Date: Mon, 8 Mar 2004 06:38:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: psycosonic <psycosonic@rootisg0d.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: kernel 2.4.25 and SIS900 ethernet card ... ((( update )))
Message-ID: <20040308053854.GA14537@alpha.home.local>
References: <000801c404be$ca7bb9e0$0700a8c0@darkgod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801c404be$ca7bb9e0$0700a8c0@darkgod>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am suprized, I have both of these chips here, and they both work perfectly
with any kernel version, including 2.4.25. Are you sure you didn't change
anything else ? what is at the other end of the wire ? a switch ? a linux
box ? if so, was it upgraded too ? Can you check that this equipment has
been configured in 100-FD ? what does netstat -i report ? did you try to
change the cable ?

Willy

On Mon, Mar 08, 2004 at 03:38:15AM -0000, psycosonic wrote:
> 
> Well .. i've tried now with a realtek.. the problem persists.
> What should i do? i've already recompiled the kernel too many times... same 
> options that 2.4.24...
> 2.4.24 works fine with network.. but 2.4.25 don't :(
> Help me please.
> 
> Thanks
> .
> 
> ----- Original Message ----- 
> From: "psycosonic" <psycosonic@rootisg0d.org>
> To: <linux-kernel@vger.kernel.org>
> Sent: Saturday, February 28, 2004 3:11 AM
> Subject: Fw: kernel 2.4.25 and SIS900 ethernet card
> 
> 
> >
> >
> >Hey.
> >
> >I'm having some problems since i updated from kernel 2.4.24 to 2.4.25 .. 
> >it seems that 2.4.25 has some incompatibility with SIS900 ethernet card. 
> >Well it should work @ 100Mbit .. and it only works @ 10Mbit... i've used 
> >mii-tool to diagnose the problem.. what i got was this:
> >
> >root@XXX:~# mii-tool
> >eth0: negotiated 100baseTx-FD, link ok
> >eth1: negotiated 100baseTx-FD, link ok <--- this is the one i'm talkin' 
> >about ( SIS900 )
> >
> >
> >...
> >00:0e.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
> >10/100 Ethernet (rev 02)
> >...
> >
> >
> >--------
> >
> >Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , 
> >with 2.4.25 it only goes to 2,2Mb/s :(
> >
> >What should i do ? i've already tried to compile the driver from SIS but 
> >it's the same.
> >
> >I'll be waiting for an answer.
> >Thanks.
> >
> >Hope this is useful :)
> >
> >Cya m8's * *
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

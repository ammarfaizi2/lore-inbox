Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266581AbSKGV33>; Thu, 7 Nov 2002 16:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266582AbSKGV33>; Thu, 7 Nov 2002 16:29:29 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:27819 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S266581AbSKGV32>; Thu, 7 Nov 2002 16:29:28 -0500
Message-ID: <3DCADCD1.8010406@ntlworld.com>
Date: Thu, 07 Nov 2002 21:36:17 +0000
From: Steven Newbury <lkml@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nico Schottelius <schottelius@wdt.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCMCIA <dhinds@zen.stanford.edu>
Subject: Re: [BUGS 2.5.45]
References: <20021107090425.GA461@schottelius.org>
In-Reply-To: <20021107090425.GA461@schottelius.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> Hello again!
> 
> 1)
> As you'll all have noticed, the makefile for the build wants QT installed for
> a simple build process.
> 
> 2)
> PCMCIA module ds.o cannot be loaded -> somehow the kernel denies that.
> 
> 3)
> atimach64 console driver makes blank screen on
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 64)
> 
> I know, the video driver didn't work in any kernel version, but I am interested
> in fixing that. I don't know where the problem is located, but I would beta
> test drivers, if available. I would also help to trace down the problem,
> with little help from the developers.
> 
> Is there any development with this driver ? Or is it simply dead? I can't 
> find any contact in any of the kernel source files...
I have the same result here:
00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

I was also surprised to notice that there is no support in X for FBDev 
with mach64 cards.  I was under the impression that they used to be 
common on older powermacs where the fbdev was essential.

I guess the place to check on the status is the linux-fbdev-devel list.
> 
> Please tell me what todo with pcmcia/ati, I want to have those things
> usable, not only for me.
> 
> Nico
> 
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUJJLgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUJJLgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 07:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUJJLgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 07:36:41 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:16778 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S268253AbUJJLgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 07:36:20 -0400
Message-ID: <41691EB1.9040102@verizon.net>
Date: Sun, 10 Oct 2004 07:36:17 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: Matt <matt@lpbproductions.com>, Jan Dittmer <jdittmer@ppp0.net>,
       Ed Schouten <ed@il.fontys.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210> <200410091315.10988.lkml@lpbproductions.com> <41684BC1.5000500@ppp0.net> <200410091347.57256.matt@lpbproductions.com> <20041010073732.GA18628@linux-sh.org>
In-Reply-To: <20041010073732.GA18628@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Sun, 10 Oct 2004 06:36:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:

>On Sat, Oct 09, 2004 at 01:47:56PM -0700, Matt wrote:
>  
>
>>If it does go into mainline. What's to stop the inclusion of other gaming 
>>platforms into the kernel . Say for instance Playstation or Gamecube or some 
>>other variant. 
>>
>>    
>>
>PlayStation 1 won't make it due to the current state of mipsnommu.
>
>  
>

Plus, the PS1 has 2 MB RAM - dunno too much about ultra-small embedded 
systems, but that seems like too little memory even for an 
ultra-stripped kernel and a shell.

>On the other hand, Dreamcast support in the kernel as is is quite good.
>It's actually one of the best supported platforms of the sh arch.
>
>I'm not sure I get your point about keeping gaming platforms out of the
>kernel, they're just another embedded platform, what's the issue?
>
>  
>
PC gaming is one of the driving forces for the development of faster 3D 
graphics systems - should we refuse to make ATI and Nvidia graphics 
cards work since those are primarily used for games?

OTOH, Sony has a very evil reputation for sending lawyers after anyone 
who publishes programming information for their consoles - try to 
reverse-engineer the (proprietary) runtime environment that came with 
their Linux kit, and watch the nastygrams come.  Since Sony didn't do 
any silliness with digitally signed executables ala XBox, the only way 
they can keep unauthorized software from being published is to attack 
anyone who tries to release the hardware information needed to make a 
bootable CD/DVD.

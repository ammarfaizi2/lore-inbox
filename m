Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUANTTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUANTTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:19:22 -0500
Received: from port117.ds1-abc.adsl.cybercity.dk ([212.242.125.56]:31854 "EHLO
	mail.imaginere.dk") by vger.kernel.org with ESMTP id S263205AbUANTQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:16:42 -0500
Date: Wed, 14 Jan 2004 20:16:37 +0100
From: Nuno Alexandre <kernel@imaginere.dk>
To: eddie tejeda <eddie@nailchipper.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VIA and NVIDIA
Message-Id: <20040114201637.566a9330@Genbox>
In-Reply-To: <1074106424.6839.15.camel@applehead>
References: <1074106424.6839.15.camel@applehead>
Organization: Fluxmod - www.imaginere.dk
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 13:53:45 -0500 
eddie tejeda wrote:

> I have an NVidia Videocard with a VIA KT333 chipset motherboard..
> 
> i am about to burst.. i am tried just about every bug-fix, workaround
> and hack, written everywhere in the internet.. to get the Nvidia driver
> to work on my machine. NV works fine.
> 
> i've been trying this for 6months and finally caving and think that it
> has to be Linux's VIA support. which i've read there are some problems.
> 
> I am willing to present all information needed.. but this is the post
> i've posted all over NVIDIA boards:
> 
> 
> 
> ***********
> 
> 
> The screen used to go black, and flicker blue once, and stop responding.
> number lock works... i can SSH into machine to get logs.. if i try and
> kill X it crashes the machine hard... complete lock out...
> 
> when i run ps aux i can see X is running 99% of CPU
> 
> All the options enabled in XFConfig attached have been added and removed
> (when options are removed the flicker happens.. if not... I now get a
> screen with ASCII printed.. just junk.. no flicker.)
> 
> I have:
> Athlon XP 2200
> Soyo Ultra Platinum, KT333
> PNY GeForce 3 Ti200
> Crucial 512 DDR-333
> ALL tested kernels (2.4.22+, 2.6.x)
> ALL distributions (Fedora, Redhat, Debian)
> 
> I have tested with following kernel options on and off:
> ACPI/APM
> Fb-Nvidia/Riva
> Pre-empt
> AGPART
> 
> i attached my XFConfig, XFree86.log and .config(2.6.0)
> 
> 
> ************
> 
> 
> i am almost certain it is linux.. because the cards work on windows
> machines perfect. and i have tried a few cards on this linux machine the
> same happens.
> 
> also, most people who have the problems i described.... they get fixed
> with the OPTIONS that i have on my XF86Config. i have tested them all on
> and off.
> 
> 
> i would like to see linux do 3d.. one day. :o)...thanks in advance, i
> love the work you guys do and hope to contribute in the future.. 
> 

Hi Eddie.
I have Asus A7V, KT 333
AMD 1800+
Gforce 2gts
768 DDR Kingston

settings on
pre-empt
AGPART

not using framebuffer.
As you see, very similar setup, apart from the riva fb.
But I have had  a framebuffer working with help from some patches available on the gentoo forums, but they don't work on the latest
kernel build. So i dropped it.

I never had any problems with the nvidia drivers.
not on 2.4 or 2.6 always worked :)

I dont know how this can help you, but having 2 similar setups
maybe helps finding whats wrong on your setup that makes it not work.
Feel free to ask for anything that might help you.

-- 
Best regards - Nuno Alexandre - na:imaginere.dk
Gpg: EA74637D - http://www.fluxmod.dk
-----------------------------------------------/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSF3TzY>; Sun, 30 Jun 2002 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSF3TzX>; Sun, 30 Jun 2002 15:55:23 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:11712 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S315406AbSF3TzW>;
	Sun, 30 Jun 2002 15:55:22 -0400
Message-ID: <3D1F62B5.30502@candelatech.com>
Date: Sun, 30 Jun 2002 12:57:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Karlsson <anders.karlsson@meansolutions.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Spacewalker SS40
References: <20020630151510.GA21888@alien.meansolutions.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson wrote:
> Hello,
> 
> I have very recently bought a Shuttle SS40 and I have installed Debian
> Woody on it. During the install process everything works fine, and the
> machine installs nicely. Then I started adding a few of the things I
> like in all systems, like a 2.4 kernel for example. 
> 
> Debian Woody have 2.4.16 and 2.4.18 up for grabs, and I have tried
> both. The problem with the 2.4 kernels seems to be that PCI does not
> get recognised or enabled. Hence things like networking, USB and
> IEEE1394 becomes unusable.
> 
> I have tried to get 2.4.19-rc1 installed, but as that does not compile
> for various reasons I have not yet been able to test it.
> 
> Please find attached the output from /proc/pci, the output from lspci,
> lspci -v as well as the output from dmesg when I boot the 2.4.18-k7
> kernel.
> 
> Should any other details be required, let me know. I do not subscribe
> to the list, so I will look in the archives for responses but would
> appreciate it if I was CC'd.
> 
> Looking forward to hearing what the cause of the problem might be.

I don't know the exact problem, but if you add: pci=bios to
the kernel boot comand line args, then it seems to work fine,
at least with RH 7.3.

I'm also running a rc1 kernel w/out problems on it.

Ben




-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear



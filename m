Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312786AbSCVSYT>; Fri, 22 Mar 2002 13:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312787AbSCVSYK>; Fri, 22 Mar 2002 13:24:10 -0500
Received: from i216-58-91-41.igs.net ([216.58.91.41]:64005 "HELO
	server.howardfamily.2y.net") by vger.kernel.org with SMTP
	id <S312786AbSCVSX5>; Fri, 22 Mar 2002 13:23:57 -0500
From: craig.howard@shadnet.shad.ca
Date: Fri, 22 Mar 2002 13:19:57 -0500
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Upgrade Hangs!
Message-ID: <20020322181957.GD11183@choward.dyn.dhs.org>
Mail-Followup-To: Craig Howard <craig.howard@shadnet.shad.ca>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10136FA4@BHISHMA> <3C9B5C94.9020200@oeone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/03/02), Masoud Sharbiani wrote:
> Abdij Bhat wrote:
> 
> >Hi,
> >I am trying to build the 2.4.17 Kernel and upgrade my existing 2.4.7-10 Red
> >Hat Linux System. Here is the procedure I followed ( based on Red Hat
> >Documentation on the same ):
> >
[snip]
> >
> >Now when i reboot and select the linux-Mine option the screen displays
> >		Loading vmlinuz-2.4.7
> >		Uncompressing Linux... Ok, booting the kernel
> >
> >and then HANGS!!!!!!
> >
> >What might be the problem. I have followed the instruction to the T. I
> >tried without the initrd option too. I have enabled the RAM diak
> >option/disabled it....
> >
> >Please help me out on the issue.
> >
> >Thanks and Regards,
> >Abdij
> >
> Have you tried checking what CPU type is configured on your kernel? it 
> should be the same as your system's cpu.
> Masoud
> 

I'm having the same problem on an old Cyrix PR200+.  It works fine with the
2.2 kernel that comes with Slackware 8, but _nothing_ else.  I've tried the
2.4 that comes with Slackware, compiling my own 2.2, 2.4 but it always
hangs.  I've tried with both 386 and Cyrix 686 kernels, but no dice.  

I used _exactly_ the same procedure that I use to upgrade my two firewalls
and desktop system, so I know my process is correct.

The only quirk to my setup is that I've got /boot mounted on an old 120MB
drive as I can't boot off the 40GB because of the old BIOS.

One last thing, one of the kernels, doesn't just hang, it reboots the whole
system.  I can't remember which kernel did this.
-- 


Craig Howard
2B Computer Science -- University of Waterloo
craig.howard@shadnet.shad.ca

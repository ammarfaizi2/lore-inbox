Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264499AbRFJFJZ>; Sun, 10 Jun 2001 01:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbRFJFJP>; Sun, 10 Jun 2001 01:09:15 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:19633 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S264499AbRFJFJG>; Sun, 10 Jun 2001 01:09:06 -0400
Date: Sat, 09 Jun 2001 23:56:51 -0500
From: "Glenn C. Hofmann" <ghofmann@pair.com>
Subject: Re: 3C905b partial  lockup in 2.4.5-pre5 and up to 2.4.6-pre1
In-Reply-To: <3B22CEF9.6DEB1A66@uow.edu.au>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Reply-to: ghofmann@pair.com
Message-id: <3B22B7C3.20165.41EC78@localhost>
MIME-version: 1.0
X-Mailer: Pegasus Mail for Win32 (v3.12c)
Content-type: text/enriched; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<bold><color><param>0100,0100,0100</param><bigger><bigger><bigger><bigger><bigger>Andrew,

Although I don't run 
Redhat, your response 
tells me that, even though I 
was feeling that it was a 
kernel problem, it could be 
a userspace issue, which I 
also suspected.  Debian 
updated their nettools 
today, so I will see if that 
helps in any way.  Thanks 
for your help.


Glenn C. Hofmann



</bold>On Sunday, 10 June 2001 
Andrew wrote:


<color><param>7F00,0000,0000</param><smaller><smaller><smaller><smaller><smaller>> "Glenn C. Hofmann" wrote:

> > 

> > I have tried 2.4.5-pre2 up to 2.4.6-pre1 with the same results. 

> > Everything boots great and I can login fine.  When I try to assign

> > an IP via DHCP or ifconfig, the system sits and stares at me

> > indefinitely.  2.4.5-pre4 didn't compile for me, but pre3 works fine

> > and pre5 locks.  There is keyboard response, and Alt-SysRq will tell

> > me that it knows I want it to sync the disks, but won't actually do

> > it.  It will reboot, though.  I can switch between terminals, but

> > cannot type anything at the login prompt.

> > 

> > The board is a Abit KT7-RAID.  I have waited to see if this issue

> > has been resolved and will recompile the newer kernels (AC and Linus

> > flavours) to see if it has cleared up, but wanted to see if maybe

> > there is something else I should look at.  I can provide any more

> > information that might help, so please let me know.  Thanks in

> > advance.

> 

> There's a problem in some versions of `pump' where it gets

> confused and ends up spinning indefinitely.  If you're using

> pump could you please try the latest RPM?

> 

> If that doesn't help, and if you're unable to kill pump

> with ^C, and if other virtual consoles are not responding then

> it could be a kernel problem - try hitting sysrq-T and feeding

> the resulting logs through `ksymoops -m System.map'

> -

> To unsubscribe from this list: send the line "unsubscribe

> linux-kernel" in the body of a message to majordomo@vger.kernel.org

> More majordomo info at  http://vger.kernel.org/majordomo-info.html

> Please read the FAQ at  http://www.tux.org/lkml/




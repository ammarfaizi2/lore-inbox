Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284460AbRLPGk3>; Sun, 16 Dec 2001 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284461AbRLPGkT>; Sun, 16 Dec 2001 01:40:19 -0500
Received: from mta04.mail.au.uu.net ([203.2.192.84]:979 "EHLO
	mta04.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S284460AbRLPGkO>; Sun, 16 Dec 2001 01:40:14 -0500
Date: Sat, 15 Dec 2001 14:28:24 +1100
From: Caleb Moore <donscarletti@ozemail.com>
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Cc: Caleb Moore <donscarletti@ozemail.com>, linux-kernel@vger.kernel.org
Subject: Re: swapping problem on kernel >= 2.4.14
Message-ID: <20011215142824.A1306@Duron>
In-Reply-To: <20011213204810.A2759@Duron> <01121312062800.02011@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <01121312062800.02011@manta>; from vda@port.imtp.ilyichevsk.odessa.ua on Fri, Dec 14, 2001 at 01:06:28 +1100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have tried to change to kernel 2.4.16 from 2.4.13 and my system
> > crashes

> You can significantly raise probability of this being fixed with some
> investigation: does it crash with one swap partition? without swap
> partitions?
> with swap file? does it produce an oops? etc
> --
> vda

Ok I checked my system with one swap partition, no swap partitions and a 
swap file. One partition resulted in a crash but after a longer duration 
(two or three times as long. I cannot understand this). A swap file acted 
in a similar way to the single swap. After removing all swap the system 
was as stable as linux is rightly reputed to be.

The kernel does produce an oops when i crash it but for some reason the 
screen blacks out a few minutes later and i am unnable to finish recording 
the sym-debug stuff and cannot get useful information from it. It is not 
logged by klogd and I don't get much further then the registers. The 
message It gives me is unnable to handle kernel paging request at virtual 
address 00015e00 although of course this adress changes.

Is there anything else I can do?

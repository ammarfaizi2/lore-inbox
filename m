Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288946AbSANTIc>; Mon, 14 Jan 2002 14:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288932AbSANTHQ>; Mon, 14 Jan 2002 14:07:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46342 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288801AbSANTFv>; Mon, 14 Jan 2002 14:05:51 -0500
Subject: Re: Hardwired drivers are going away?
To: babydr@baby-dragons.com (Mr. James W. Laferriere)
Date: Mon, 14 Jan 2002 19:17:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.44.0201141358060.3238-100000@filesrv1.baby-dragons.com> from "Mr. James W. Laferriere" at Jan 14, 2002 02:00:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCc6-0002bb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Urban legend.
> 	I do not agree .  Got proof ?  Yes that is a valid question .

Most of the rootkit type stuff I see nowdays includes code for loading
patches into module free kernels. Its a real no win. The better ones support
regexp scanning so they can patch kernels where the sysadmin thinks he/she
is cool and has hidden or crapped in System.map

> > > case becouse the system can't know where the module will be located IIRC)
> > I defy you to measure it on x86
> 	OK ,How about sparc-64/alpha/ia64/... ?

Not generally found in your grandmothers PC

> > > 3. simplicity in building kernels for other machines. with a monolithic
> > > kernel you have one file to move (and a bootloader to run) with modules
> > > you have to move quite a few more files.
> > tar or nfs mount; make modules_install.
> 	Please my laugh'o meter is stuck already .  Sorry .  JimL

Then fix it, because the above works well. Also remember that autoconfig
tools won't be able to guess remote machines very well 8)

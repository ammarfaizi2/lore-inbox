Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbTCGVYM>; Fri, 7 Mar 2003 16:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbTCGVYM>; Fri, 7 Mar 2003 16:24:12 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:190 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261784AbTCGVYL>; Fri, 7 Mar 2003 16:24:11 -0500
Message-Id: <200303072132.WAA02244@fire.malware.de>
Date: Fri, 07 Mar 2003 22:33:07 +0100
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: Make ipconfig.c work as a loadable module.
References: <Pine.LNX.4.44.0303061500310.31368-100000@mandrake.americas.sgi.com>
		 <1046990052.18158.121.camel@irongate.swansea.linux.org.uk>
		 <20030306221136.GB26732@gtf.org>
		 <20030306222546.K838@flint.arm.linux.org.uk>
		 <1046996037.18158.142.camel@irongate.swansea.linux.org.uk>
		 <20030306231905.M838@flint.arm.linux.org.uk>
		 <1046996987.17718.144.camel@irongate.swansea.linux.org.uk>
		 <200303070715.IAA27138@fire.malware.de> <1047041676.20793.12.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

you wrote:
> > Sorry, but I must join Russel here. I have atleast one machine which has
> > a bootloader able to load exactly one file only. There is currently no
> > way to load an initrd. It would need to implement the whole (BOOTP+)TFTP
> > stuff again, just to get the initrd. So I was quite happy linux 2.4
> > still knows about mounting a NFS root filesystem without user-space
> > help.
> 
> Just glue the initrd to the kernel. This is not rocket science

Do you have a sort of glue fixing the ramdisk support on m68k to support
physically non-continous memory too? Otherwhise I have only 1 MiB for
the whole initrd.

So hopefully the removal of ipconfig.c, if decided for, does not
propagate back into the 2.4 series. It would add a heap of useless work
to do, just to get it up again.


Michael

-- 
Linux@TekXpress
http://www-users.rwth-aachen.de/Michael.Mueller4/tekxp/tekxp.html

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRLHPiM>; Sat, 8 Dec 2001 10:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281865AbRLHPiC>; Sat, 8 Dec 2001 10:38:02 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:63106 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S281854AbRLHPhv>;
	Sat, 8 Dec 2001 10:37:51 -0500
Message-Id: <m16CjXt-000OWoC@amadeus.home.nl>
Date: Sat, 8 Dec 2001 15:37:45 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: Jeff Gustafson <ncjeffgus@zimage.com>
Subject: Re: SMP 440GX+ hang on boot (2.4.16)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011208122147.C62182F055@alpha.zimage.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011208122147.C62182F055@alpha.zimage.com> you wrote:
>        Apparently this is a known problem.  On this mother board we have a
> AIC7xxx controller.  We also have a DAC960.  When the system tries to mount
> the drives on the DAC960 (nothing is connected to the AIC7xxx), the system
> hangs.  Supposedly the problem is only with UP kernels, but we get hangs 
> with a SMP compiled kernel!
>        The funny thing is that the kernels from RH 7.2 (2.4.7-10) and Alan
> Cox's latest (2.4.13-ac8) work just fine.  The 2.4.16 kernel does not 
> work.  Is there a possiblity that the fix could posted to linux-kernel?  
> Maybe it could be put into the upcoming 2.4.17 release.  Please??

1) Did you enable ACPI in your own kernel ?
2) Does "noapic" make a difference ?

and if neither is true, well, even Intel officially says the 440GX is 
unsupported in that case.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317301AbSFGPlH>; Fri, 7 Jun 2002 11:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSFGPlG>; Fri, 7 Jun 2002 11:41:06 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:59422 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S317301AbSFGPlF>; Fri, 7 Jun 2002 11:41:05 -0400
Date: Fri, 7 Jun 2002 11:36:21 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20267 + RAID can't find raid device
Message-ID: <20020607113621.P7291@coredump.electro-mechanical.com>
In-Reply-To: <20020606111918.F7291@coredump.electro-mechanical.com> <1023392854.23013.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have 2 quantum fireballlct10 05 on the controller (hde and hdg) and
> > created a stripe between these 2 disks in the controller's bios
> > I can see both disks w/o problems.
> 
> Do you have the ataraid driver loaded - what did it report ?

I tried compiling as modules to see if that would make a difference.

Upon loading ide-probe-mod.o, it finds the 2 hdds that's on the promise card
and hangs (doesn't do this when compiled into the kernel).  At this point,
sysrq works just fine so I assume it just killed userland (I can't even
telnet into the box).

The HDDs are quantum hdds, that wouldn't be causing the problem, would it?

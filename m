Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVCEWGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVCEWGL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCEWGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:06:10 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40647 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261219AbVCEWGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:06:03 -0500
Subject: Re: Linux 2.6.11.1
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503051649.58709.gene.heskett@verizon.net>
References: <20050304175302.GA29289@kroah.com>
	 <20050305174654.J3282@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0503051316510.2304@ppc970.osdl.org>
	 <200503051649.58709.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 17:06:02 -0500
Message-Id: <1110060362.12513.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-05 at 16:49 -0500, Gene Heskett wrote:
> What he said!  Perfectly good patches, which fix real problems would 
> appear to be sitting in testing/broken_out till bit rot or ???.
> 
> If you want a testers testimony, I'm running the bk-ieee1394.patch, 
> and all I can say at this point is that it Just Works(TM).  I have 
> NDI how it got a yesterdays Mar 4) date in the directory listing 
> there though, I've had it a bit longer than that by 2-3 days as my 
> copy shows a Mar 1 date.  I first got it via svn fetch at 
> linux-ieee1394.org or some such in January.
> 
> Fixes for real problems that fix real problems should somehow get a 
> faster track into final.  The current firewire in the kernel as of 
> 2.6.11 is still badly borked.

Driver updates are a hard problem.  Nothing annoys users more than
unsupported hardware.  But if you aggressively add support for new
devices you can break things that have worked for ages.

A change that makes your hardware work may break someone else's.  There
is no such thing as an obviously correct patch when you are flipping
bits in the hardware.  You can never eliminate 100% of driver
regressions, all you can do is minimize the impact by getting release
candidates tested on the widest possible range of hardware.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUFPXYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUFPXYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUFPXYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:24:18 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:45774 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264258AbUFPXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:24:17 -0400
Subject: Re: ld segfault at end of 2.6.6 compile
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200406161935.55740.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1087352698.8671.23.camel@amsa> <1087382494.8675.32.camel@amsa>
	 <200406160701.15857.eric@cisu.net>
	 <200406161935.55740.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1087428254.8669.46.camel@amsa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 19:24:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it always happens right away, even between reboots.  And just for
technicality, its ld that segfaults, not gcc.  If it makes a difference.

			--Geoff Mishkin <gmishkin@bu.edu>


On Wed, 2004-06-16 at 12:35, Denis Vlasenko wrote:
> On Wednesday 16 June 2004 15:01, Eric wrote:
> > On Wednesday 16 June 2004 05:41 am, Geoff Mishkin wrote:
> > > I couldn't find exactly what I was looking for in the BIOS utility (IBM
> > > ThinkPad T42), but I turned on Diagnostics mode and the RAM check, so at
> > > boot it checked the RAM, which all turned out okay.
> >
> > The bios does very wimpy checking of ram. If it is indeed a RAM problem,
> > you should use a tool like memtest86 in linux (you boot to it, its not a
> > linux tool per se) or prime95(is that the name?) in windows.
> 
> In my case, it wasn't enough. Neuther memtest86 nor cpuburn
> was able to trigger problem, only gcc. (I did not try prime95).
> I tweaked memory timings until gcc stopped segv'ing.
> 
> BTW, "bad memory" theory does not hold if fails _every time in the
> same place_.
> --
> vda
> 


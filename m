Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbULMODs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbULMODs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbULMODr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:03:47 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:9350 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262266AbULMODp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:03:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Weinehall <tao@debian.org>
Subject: Re: 2.6.10-rc3 vs clock
Date: Mon, 13 Dec 2004 15:04:43 +0100
User-Agent: KMail/1.7.2
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
References: <200412041111.16055.gene.heskett@verizon.net> <20041213122925.GT27718@khan.acc.umu.se>
In-Reply-To: <20041213122925.GT27718@khan.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412131504.43239.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 of December 2004 13:29, David Weinehall wrote:
> On Sat, Dec 04, 2004 at 11:11:16AM -0500, Gene Heskett wrote:
> > At -rc2 my clock kept fairly decent time, but -rc3 is running fast, 
> > about 30 seconds an hour fast.
> 
> Lucky you. Each time I suspend my laptop the clock speeds up
> approximately x2...  Usually, the time it takes me to get from home to
> work means that the computer tells me I arrived half an hour late...

I see something strange that may be related to these issues.  When I turn off 
my box and turn it on again after a couple of hours, and run Linux, the clock 
is apparently late, although it shows the right time in the CMOS setup right 
before booting the kernel.  The amount of time the clock is late (in Linux) 
depends on how much time the box has been off (it increases about 4 min. for 
each hour, so the clock is about 30 min. late if the box has been off for 8 
hours).

This has been present on all kernels since 2.6.8 at least (I did not run 
earlier kernels on this box), but I haven't tried 2.6.10-rc3-mm1 yet.

> > I've been using ntpdate, is that now officially deprecated?
> 
> I kind of doubt that...

Me too. ;-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

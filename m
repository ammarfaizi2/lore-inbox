Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSFLEN6>; Wed, 12 Jun 2002 00:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSFLEN5>; Wed, 12 Jun 2002 00:13:57 -0400
Received: from adsl-216-62-201-136.dsl.austtx.swbell.net ([216.62.201.136]:2692
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317355AbSFLEN4>; Wed, 12 Jun 2002 00:13:56 -0400
Subject: RE: [PATCH] CONFIG_NR_CPUS, redux
From: Austin Gonyou <austin@digitalroadkill.net>
To: Matt_Domsch@Dell.com
Cc: jw@pegasys.ws, linux-kernel@vger.kernel.org
In-Reply-To: <9A2D9C0E5A442340BABEBE55D81BEBDB012051FE@AUSXMPS313.aus.amer.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 11 Jun 2002 23:13:17 -0500
Message-Id: <1023855197.30822.7.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the most part, I figure that most application of Linux, ATM, is in
the server space anyway, where 2+ processors are a must.

Also, with 4 procs and HT as Matt mentioned HT below, it will *look*
like 8.(hell, might as well be at this point the way HT seems to work.)

So, the default, as it has been in the past, is for SMP to be Y. It's a
small step to turn it off, but even if you don't, *usually* it doesn't
cause UP boxes much problems.

On Tue, 2002-06-11 at 22:29, Matt_Domsch@Dell.com wrote:
> > I personally only rarely see 2-way boxes, 
> > 4-way is pretty rare, and anything more must surely count as very
> specialized.
> 
> A very large percentage of Dell PowerEdge servers sold with Red Hat Linux,
> or used with other distros, have 2 or more processors.  We today have
> servers with 1, 2, 4, or 8 CPUs, and with the advent of HyperThreading, that
> looks like even more.  More than two CPUs is not at all uncommon in the
> server space.  Desktop/notebook space, sure.
> 
> Thanks,
> Matt

-- 
Austin Gonyou <austin@digitalroadkill.net>

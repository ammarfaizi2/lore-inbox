Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317706AbSGVPmK>; Mon, 22 Jul 2002 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSGVPmJ>; Mon, 22 Jul 2002 11:42:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32506 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317706AbSGVPmI>; Mon, 22 Jul 2002 11:42:08 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E17Wf0s-0001tS-00@starship>
References: <3D361091.13618.16DC46FB@localhost>
	<20020722102342.GE1196@fib011235813.fsnet.co.uk> 
	<E17Wf0s-0001tS-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 17:57:57 +0100
Message-Id: <1027357077.31782.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 16:22, Daniel Phillips wrote:developed equivalent
> Supposing both device-mapper and (the kernel part of) EVMS get into the tree, 
> there's nothing stopping you from submitting a patch to make EVMS use 
> device-mapper.  If there's already equivalent code in EVMS, that just makes 
> the job easier.

So we end up with twice as much code to debug and lots of
incompatibilities when people want to switch around. It would be far
better if the two sets of userspace code could at least agree on a
common kernel interface

> I'm firmly in the 'we need both' camp.

If there is something important in only one then that matters. If there
are important features in each that are not in the other then that
really proves they should merge the projects


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbSLFHG4>; Fri, 6 Dec 2002 02:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbSLFHG4>; Fri, 6 Dec 2002 02:06:56 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:31889
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267673AbSLFHGz>; Fri, 6 Dec 2002 02:06:55 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3DF049F9.6F83D13@digeo.com>
References: <20021206111326.B7232@turing.une.edu.au>
	 <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random>
	 <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random>
	 <20021206021559.GK9882@holomorphy.com>
	 <20021206022853.GJ1567@dualathlon.random>
	 <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com>
	 <20021206054804.GK1567@dualathlon.random>  <3DF049F9.6F83D13@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1039158861.16565.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 06 Dec 2002 01:14:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 00:55, Andrew Morton wrote:
> Andrea Arcangeli wrote:
[...]
> > and you're totally wrong saying that mlocking 700m on a 4G box
> > could kill it.
> 
> It is possible to mlock 700M of the normal zone on a 4G -aa kernel.
> I can't immediately think of anything apart from vma's which will
> make it fall over, but it will run like crap.


Just curious, but how long would it take a system with 8GB RAM, using 4G
or 64G kernel to fall over? One thing I've noticed, is that 2.4.19aa2
runs great on a box with 8GB when I don't allocate all that much, but
seems to run into issues after a large DB has been running on it for
several days. (i.e. the system get's generally a little slower, less
responsive, and in some cases crashes after 7 days). 

Yes, I know, sounds like a memory leak in something, but aside from
patching Oracle from 8.1.7.4(dba's can't find any new patches ATM), I've
tried everything except changing my kernel. 

Could this be similar behaviour?

--The GrandMaster

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTB1OR0>; Fri, 28 Feb 2003 09:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbTB1OR0>; Fri, 28 Feb 2003 09:17:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46606 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267902AbTB1ORZ>; Fri, 28 Feb 2003 09:17:25 -0500
Date: Fri, 28 Feb 2003 09:23:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Hans Reiser <reiser@namesys.com>
cc: Steven Cole <elenstev@mesatop.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Results of using tar with 2.5.[60 63 62-mm3] and reiser[fs 4], ext3, xfs.
In-Reply-To: <3E5E71EF.2030907@namesys.com>
Message-ID: <Pine.LNX.3.96.1030228091914.25875F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003, Hans Reiser wrote:


> I would advise using a larger benchmark with  30-60 kernels being 
> copied.  Filesystems sometimes perform differently for sync than for 
> memory pressure.

Agreed, a benchmark suite gives a better view of overall performance.

When ext3 came out I benchmarked it running a usenet news server. I
configured it for one file per article and fed in about 100k articles with
each one being offered multiple times to generate both rejects and
accepts. I suppose I should do that again, it would give some insight into
performance creating *lots* of files, many in the same directory.

Needless to say for production use I configure a news server for least
resources and the filesystem plays little part in the performance.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


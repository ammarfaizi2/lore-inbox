Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTBUJcA>; Fri, 21 Feb 2003 04:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTBUJcA>; Fri, 21 Feb 2003 04:32:00 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:38789 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267264AbTBUJb6>;
	Fri, 21 Feb 2003 04:31:58 -0500
Date: Fri, 21 Feb 2003 10:41:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030221094133.GH31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <shs1y22zhm9.fsf@charged.uio.no> <20030220230430.GX9800@gtf.org> <15957.24787.735814.496471@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15957.24787.735814.496471@charged.uio.no>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 12:12:19AM +0100, Trond Myklebust wrote:
> >>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:
> 
>      > One should also consider kmap_atomic...  (bcrl suggest)
> 
> The problem is that sendmsg() can sleep. kmap_atomic() isn't really
> appropriate here.

100% correct.

Andrea

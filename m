Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSHENk3>; Mon, 5 Aug 2002 09:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318466AbSHENk2>; Mon, 5 Aug 2002 09:40:28 -0400
Received: from mons.uio.no ([129.240.130.14]:32650 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318460AbSHENk2>;
	Mon, 5 Aug 2002 09:40:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15694.33047.965504.346909@charged.uio.no>
Date: Mon, 5 Aug 2002 15:43:51 +0200
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Fragment flooding in 2.4.x/2.5.x
In-Reply-To: <20020803.031740.84726417.davem@redhat.com>
References: <200206281821.WAA00420@mops.inr.ac.ru>
	<200207011414.50465.trond.myklebust@fys.uio.no>
	<20020803.031740.84726417.davem@redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David S Miller <davem@redhat.com> writes:

     > Trond does this patch fix your problem?  It is exactly how
     > Alexey described the fix and it should work.

That looks good. In the 2.5.x kernel I've already worked around this
bug by increasing the socket buffer size. However the problem isn't
just limited to NFS.

Concerning the 2.4.x kernel: it would be very nice if this fix made it
into 2.4.19, as the bug has already been known to crash a few
servers...

Cheers,
  Trond

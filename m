Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTIDCgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264525AbTIDCgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:36:07 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:22964 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264521AbTIDCfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:35:54 -0400
Date: Wed, 03 Sep 2003 19:33:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David Lang <david.lang@digitalinsight.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SSI clusters on NUMA (was Re: Scaling noise)
Message-ID: <7710000.1062642829@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0309031844270.17581-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0309031844270.17581-100000@dlang.diginsite.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> how much of this need could be met with a native linux master and kernels
> running user-mode kernels? (your resource sharing would obviously not be
> that clean, but you could develop the tools to work across the kernel
> images this way)

I talked to Jeff and Andrea about this at KS & OLS this year ... the feeling
was that UML was too much overhead, but there were various ways to reduce
that, especially if the underlying OS had UML support (doesn't require it
right now).

I'd really like to see the performance proved to be better before basing
a design on UML, though that was my first instinct of how to do it ...

M.


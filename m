Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030655AbWJCXAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030655AbWJCXAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbWJCXAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:00:39 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:56470 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030651AbWJCXAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:00:38 -0400
Message-ID: <4522EB94.1040708@oracle.com>
Date: Tue, 03 Oct 2006 16:00:36 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH take2 0/5] dio: clean up completion phase of direct_io_worker()
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net> <20061003152004.ca255c33.akpm@osdl.org>
In-Reply-To: <20061003152004.ca255c33.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I trust a lot of testing was done on blocksize<pagesize filesystems?

I haven't, no.

> And did you test direct-io into and out of hugepages?

No, though..

> `odread' and `odwrite' from
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz can be
> used to test that.

.. I'll definitely give those a spin, thanks.

I'll see if I can get some real resources dedicated to collecting the N
different piles of tests that are kicking around into something
coherent.  It'll take a while, but I'm sure I'm not alone in being
frustrated by this disorganized collaborative works-for-me approach.

- z

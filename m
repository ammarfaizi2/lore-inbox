Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbSKKBNo>; Sun, 10 Nov 2002 20:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265297AbSKKBNo>; Sun, 10 Nov 2002 20:13:44 -0500
Received: from holomorphy.com ([66.224.33.161]:58803 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265285AbSKKBNn>;
	Sun, 10 Nov 2002 20:13:43 -0500
Date: Sun, 10 Nov 2002 17:18:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jens Axboe <axboe@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.46-mm2
Message-ID: <20021111011806.GN22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
	lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <3DCDD9AC.C3FB30D9@digeo.com> <20021110143208.GJ31134@suse.de> <20021110145203.GH23425@holomorphy.com> <20021110145757.GK31134@suse.de> <20021110150626.GI23425@holomorphy.com> <20021110155851.GL31134@suse.de> <3DCEB5E7.5147A449@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCEB5E7.5147A449@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 11:39:19AM -0800, Andrew Morton wrote:
> All of which is a bit of a hassle.  I'll do an mm3 later today which
> actually has the damn code in it and let's get in and find out whether
> the huge queue is worth pursuing.

The benchmarks/stress tests take longer to run than I have time left to
use the system where nobh really matters, and the driver breakage from
the recent SCSI changes (qlogic 2300, vendor code) isn't getting fixed
anytime in the next 8 hours anyway, esp. since I have zero SCSI knowledge.

So I'm stuck until next weekend, though I guess I can check to see if it
oopses etc. on smaller systems.


Bill

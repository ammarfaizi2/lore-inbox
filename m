Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbRHFM0Z>; Mon, 6 Aug 2001 08:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268137AbRHFM0F>; Mon, 6 Aug 2001 08:26:05 -0400
Received: from weta.f00f.org ([203.167.249.89]:58256 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S268149AbRHFMZz>;
	Mon, 6 Aug 2001 08:25:55 -0400
Date: Tue, 7 Aug 2001 00:26:50 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>,
        David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010807002650.B23937@weta.f00f.org>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <15214.24938.681121.837470@pizda.ninka.net> <20010806125705.I15925@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010806125705.I15925@athlon.random>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 12:57:05PM +0200, Andrea Arcangeli wrote:

    The point here is not if it's simple or difficult. The point is what can
    be done or not and what is faster or slower. All I'm saying is that I
    don't see why it's not possible to implement the merge_segments with
    only an O(1) additional cost of a few cycles per mmap syscall, which
    will render the feature an obvious improvement (instead of being a
    dubious improvement like in 2.2 that is walking the tree two times).

mmap does merge in many common cases.



  --cw

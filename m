Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbRHFJpZ>; Mon, 6 Aug 2001 05:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267771AbRHFJpP>; Mon, 6 Aug 2001 05:45:15 -0400
Received: from weta.f00f.org ([203.167.249.89]:53648 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S267713AbRHFJpH>;
	Mon, 6 Aug 2001 05:45:07 -0400
Date: Mon, 6 Aug 2001 21:46:02 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806214601.B23464@weta.f00f.org>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <15214.24938.681121.837470@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15214.24938.681121.837470@pizda.ninka.net>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 02:20:42AM -0700, David S. Miller wrote:

    I think he's right.  The old code was trying to do everything and
    made the locking more difficult than it needed to be.

I just posted an analysis of this (a bit nebulous and hand-waving in
nature) which seems to indicate to me this _can_ probably be fixed in
userspace, specifically glibc.

Not not that I've checked the glibc code recently...

< .... wanders off to try to grok glibc .... >



  --cw




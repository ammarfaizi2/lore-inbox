Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTARFGh>; Sat, 18 Jan 2003 00:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTARFGh>; Sat, 18 Jan 2003 00:06:37 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:41932 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262425AbTARFGg>;
	Sat, 18 Jan 2003 00:06:36 -0500
Date: Sat, 18 Jan 2003 05:15:28 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030118051528.GB18720@bjl1.asuk.net>
References: <20030118043309.GA18658@bjl1.asuk.net> <20030117210221.17ce1054.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117210221.17ce1054.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > Thus far, the best solution I have for tracking checkins is to rsync
> > the SCCS files from Rik's mirror, and use a Perl script to extract the
> > head version from each SCCS file.
> 
> Do you not use
> 
> 	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

Oh, thanks.  I didn't know about that.

> It always has the latest diff against the last-released kernel.

It is updated in real time then?
(Assuming yes) that reduces the need to talk bk protocol quite a lot :)

(I'd still like to, though).

> I snarf it hourly, so I have decent granularity for doing the
> binary-search-to-see-where-it-broke trick.

Good idea.

-- Jamie

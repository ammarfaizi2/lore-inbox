Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTCOIS7>; Sat, 15 Mar 2003 03:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbTCOIS6>; Sat, 15 Mar 2003 03:18:58 -0500
Received: from holomorphy.com ([66.224.33.161]:60112 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261338AbTCOIS6>;
	Sat, 15 Mar 2003 03:18:58 -0500
Date: Sat, 15 Mar 2003 00:29:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Andrew Morton <akpm@digeo.com>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <20030315082927.GR20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315054910.GN20188@holomorphy.com> <20030315062025.GP20188@holomorphy.com> <20030314224413.6a1fc39c.akpm@digeo.com> <m3r899yrhx.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3r899yrhx.fsf@lexa.home.net>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (AM) writes:
AM> Nope.  What we're trying to measure here is pure in-memory lock
AM> contention, locked bus traffic, context switches, etc, etc.  To
AM> do that we need to get the IO system out of the picture.

On Sat, Mar 15, 2003 at 11:16:10AM +0300, Alex Tomas wrote:
> I simple use own pretty simple test. btw, you may disable preallocation
> to increase allocation rate

This looks very interesting, but it may have to wait ca. 24 hours for
some benchmark time b/c of the long boot times and late hour in .us.

This also looks like it would be a much better stress test, and the
NUMA-Q is known for bringing out many rare races. There is are good
reasons to run this test even aside from performance.


-- wli

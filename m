Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUIKOyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUIKOyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 10:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbUIKOyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 10:54:07 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:20653 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S267977AbUIKOyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 10:54:03 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Major XFS problems...
Date: Sat, 11 Sep 2004 14:54:02 +0000 (UTC)
Organization: Cistron Group
Message-ID: <chv3ia$lnu$1@news.cistron.nl>
References: <20040908123524.GZ390@unthought.net> <4142E3EB.3080308@pointblue.com.pl> <20040911133812.GC32755@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1094914442 22270 62.216.29.200 (11 Sep 2004 14:54:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040911133812.GC32755@krispykreme>,
Anton Blanchard  <anton@samba.org> wrote:
>
>> In my expierence XFS, was right after JFS the worst and the slowest 
>> filesystem ever made.
>
>On our NFS benchmarks JFS is _significantly_ faster than ext3 and
>reiserfs. It depends on your workload but calling JFS the worst and
>slowest filesystem ever made is unfair.

Same goes for XFS. In the application I use it for it is by _far_
the fastest filesystem, whereas reiser is by far the slowest.
ext3 is somewhere in between.

And that's because XFS has extents and does pre-allocation.

Mike.
-- 
"In times of universal deceit, telling the truth becomes
 a revolutionary act." -- George Orwell.


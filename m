Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbSI1Ikk>; Sat, 28 Sep 2002 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbSI1Ikk>; Sat, 28 Sep 2002 04:40:40 -0400
Received: from packet.digeo.com ([12.110.80.53]:19861 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262745AbSI1Ikj>;
	Sat, 28 Sep 2002 04:40:39 -0400
Message-ID: <3D956C41.E2EB78FB@digeo.com>
Date: Sat, 28 Sep 2002 01:45:53 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
References: <1033196310.3d955316425bd@kolivas.net> <3D95670C.3239A357@digeo.com> <1033201873.3d9568d158a72@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 08:45:54.0088 (UTC) FILETIME=[74A0BA80:01C266CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> Ok will fix. But please Andrew use version 0.41 of contest (posted only 2 hours
> ago). The results from that are far more meaningful and reproducible.
> 

I am doing.   I just tested for the "proces load" variation which
you saw (I assume that's what the test calls "CPU load").  With
and without the -mm patches:

cpuload         2:31.55         297%
cpuload         2:31.75         295%

So...  Maybe some extra samples would be needed there.

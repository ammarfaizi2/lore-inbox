Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267214AbSKPDXr>; Fri, 15 Nov 2002 22:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbSKPDXr>; Fri, 15 Nov 2002 22:23:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:3473 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267214AbSKPDXr>;
	Fri, 15 Nov 2002 22:23:47 -0500
Message-ID: <3DD5BBD9.7DA70FFF@digeo.com>
Date: Fri, 15 Nov 2002 19:30:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47-mm3 with contest
References: <200211161422.17438.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2002 03:30:37.0494 (UTC) FILETIME=[87B34D60:01C28D20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> Note the significant discrepancy between mm1 and mm3. This reminds me of what
> happened last time I enabled shared 3rd level pagetables - Andrew do you want
> me to do a set of numbers with this disabled?

That certainly couldn't hurt.  But your tests are, in general, tesging
the IO scheduler.  And the IO scheduler has changed radically in each
of the recent -mm's.

So testing with rbtree-iosched reverted would really be the only way
to draw comparisons on how the rest of the code is behaving.

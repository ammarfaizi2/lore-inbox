Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSIXRl1>; Tue, 24 Sep 2002 13:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSIXRk6>; Tue, 24 Sep 2002 13:40:58 -0400
Received: from packet.digeo.com ([12.110.80.53]:22698 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261739AbSIXRfG>;
	Tue, 24 Sep 2002 13:35:06 -0400
Message-ID: <3D90A378.C58157AA@digeo.com>
Date: Tue, 24 Sep 2002 10:40:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       davem@redhat.com, jgarzik@mandrakesoft.com, torvalds@transmeta.com
Subject: Re: on 2.5.38-mm2 tbench 64 smptimers shows 30% improvement
References: <20020924081340.GD6070@holomorphy.com> <20020924083606.GF6070@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2002 17:40:08.0467 (UTC) FILETIME=[6CDFCE30:01C263F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> 2.5.38-mm2-smptimers:
> c01053dc 30936965 41.2616     poll_idle
> c020ee62 30635964 40.8601     .text.lock.dev       <- what's this?
> c0114c08 2499541  3.33371     load_balance
> c01175db 2141278  2.85589     .text.lock.sched
> c020ce40 2141045  2.85558     dev_queue_xmit
> c013a47e 932681   1.24394     .text.lock.page_alloc

queue lock for the loopback device?

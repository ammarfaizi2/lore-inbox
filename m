Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSJMRlg>; Sun, 13 Oct 2002 13:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJMRlg>; Sun, 13 Oct 2002 13:41:36 -0400
Received: from packet.digeo.com ([12.110.80.53]:29598 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261571AbSJMRlf>;
	Sun, 13 Oct 2002 13:41:35 -0400
Message-ID: <3DA9B1A7.A747ADD6@digeo.com>
Date: Sun, 13 Oct 2002 10:47:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.42-mm2
References: <3DA7C3A5.98FCC13E@digeo.com> <20021013101949.GB2032@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2002 17:47:19.0995 (UTC) FILETIME=[93EF00B0:01C272E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> @@ -1104,6 +1126,7 @@ static void __init free_area_init_core(s
>                         pcp->low = 0;
>                         pcp->high = 32;
>                         pcp->batch = 16;
> +                       pcp->reserved = 0;
>                         INIT_LIST_HEAD(&pcp->list);
>                 }
>                 INIT_LIST_HEAD(&zone->active_list);

OK.  But that's been there since 2.5.40-mm2.  Why did it suddenly
bite?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWIPGiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWIPGiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWIPGiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:38:24 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:7122 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S932214AbWIPGiY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:38:24 -0400
Date: Sat, 16 Sep 2006 14:38:19 +0800
From: "Zhou Yingchao" <yc_zhou@ncic.ac.cn>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       "alan" <alan@redhat.com>, "zxc" <zxc@ncic.ac.cn>
Subject: Re: Re: Re: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
X-Antivirus: avast! (VPS 0637-2, 2006-09-15), Outbound message
X-Antivirus-Status: Clean
Message-Id: <20060916063823.14432FB044@ncic.ac.cn>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I replied too hastily.  I've since looked back to your original mail
Thank you for your patience.
>(in which you do mention Infiniband as an example, which has now
>helped to jog my brain), and realized that I was misinterpreting
>what you meant by "user-level network driver".
>
>The problem, as I now see it, is precisely with do_wp_page()'s
>TestSetPageLocked, as you first said.
Yeah, I think you get it.  ^_^
>
>Yes, it would be good if we could do that check in some other,
>reliable way.  The problem is that can_share_swap_page has to
>check page_mapcount (and PageSwapCache) and page_swapcount in
>an atomic way: the page lock is what we have used to guard the
>movement between mapcount and swapcount.
>
>I'll try to think whether we can do that better,
>but not until next week.
Ok, I expect for good news.
>
>Hugh

Yingchao Zhou


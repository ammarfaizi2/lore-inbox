Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTAXCL3>; Thu, 23 Jan 2003 21:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTAXCL3>; Thu, 23 Jan 2003 21:11:29 -0500
Received: from dial-ctb04185.webone.com.au ([210.9.244.185]:27660 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267512AbTAXCL2>;
	Thu, 23 Jan 2003 21:11:28 -0500
Message-ID: <3E30A308.70607@cyberone.com.au>
Date: Fri, 24 Jan 2003 13:20:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: dmo@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org, markw@osdl.org,
       cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
References: <20030123135448.A8801@acpi.pdx.osdl.net>	<3E30990D.3090305@cyberone.com.au> <20030123180001.426f165e.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>I think this may be because
>>deadline_add_drq_rb puts "aliased" requests in the next_drq although they
>>are not put on the sort or fifo lists. This is the problem I described to
>>you before and exists in mm4.
>>
>
>Yes, but 2.5.59 doesn't do that.
>
OK yeah, I thought he said 2.5.59 was OK.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSLUHX7>; Sat, 21 Dec 2002 02:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbSLUHX7>; Sat, 21 Dec 2002 02:23:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:46522 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266761AbSLUHX6>;
	Sat, 21 Dec 2002 02:23:58 -0500
Message-ID: <3E0418EC.B55941EE@digeo.com>
Date: Fri, 20 Dec 2002 23:31:56 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: kiran@in.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       dipankar@in.ibm.com
Subject: Re: [patch] Make rt_cache_stat use kmalloc_percpu
References: <20021216192212.C26076@in.ibm.com> <20021220.230528.106417474.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Dec 2002 07:31:57.0350 (UTC) FILETIME=[0AD33C60:01C2A8C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Ravikiran G Thirumalai <kiran@in.ibm.com>
>    Date: Mon, 16 Dec 2002 19:22:12 +0530
> 
>    Here's another patch to use kmalloc_percpu.  As usual, this removes
>    NR_CPUS bloat, can work when modulized and helps node local allocation.
> 
> I can't consider this seriously until the kmalloc_percpu stuff
> actually makes it into Linus's tree.  Last I checked, Andrew had
> a lot of legitimate gripes with the ideas.

Kiran's latest (vastly simpler) version looks fine to my eye.

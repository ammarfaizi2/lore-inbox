Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSKVTjT>; Fri, 22 Nov 2002 14:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSKVTjT>; Fri, 22 Nov 2002 14:39:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:64488 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265242AbSKVTjT>;
	Fri, 22 Nov 2002 14:39:19 -0500
Message-ID: <3DDE898D.FA73C769@digeo.com>
Date: Fri, 22 Nov 2002 11:46:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.5.48 hangs during boot
References: <3DDD8F4D.8080103@us.ibm.com> <20021122021131.GW23425@holomorphy.com> <3DDE8652.5070003@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2002 19:46:22.0233 (UTC) FILETIME=[D5900890:01C2925F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:
> 
> ...
> > get the axboe/akpm fixes for the elevator deadlock and/or an intermediate
> > bk tree. This is an io scheduling issue.
> >
> >
> > Bill
> 
> Yep..  the axboe-scsi patch from the mm1 tree fixes our problem...
> 
> Linus, you'll make a bunch of NUMA-Q developers (and likely many other
> people) really happy if you add that patch to the mainline.
> 

A different fix was merged a couple of days ago. 

You can get updates from
http://www.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/ - the
"Gzipped full patch" at the top.  It's updated hourly (I think).  I'd
die without that web page.

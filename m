Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUBYDba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUBYDb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:31:29 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:22718 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262398AbUBYDb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:31:28 -0500
Message-ID: <403C170B.7020207@cyberone.com.au>
Date: Wed, 25 Feb 2004 14:31:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Cliff White <cliffw@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: reaim - 2.6.3-mm1 IO performance down.
References: <1077674458.403c01da445ea@vds.kolivas.org>
In-Reply-To: <1077674458.403c01da445ea@vds.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>
>>Running the reaim 'new_fserver' workload, we now see a performance drop on
>>2.6.3-mm1, ext3 filesystem
>>
>
>I observed a serious slowdown on non numa, non smt machines with kernbench and
>the scheduler changes (posted results a week ago here:
>http://marc.theaimsgroup.com/?l=linux-kernel&m=107719112225482&w=2 )
>
>A summary of those results is half job load (-j4 on 8x):
>2.6.3: Elapsed Time 231.274
>2.6.3-mm1: Elapsed Time 273.688
>
>The drop in reaim performance is possibly related.
>
>

I have been meaning to look at that. The STP wasn't working
for me for a couple of days, but Cliff fixed that so I'll get
on it.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTCBVsh>; Sun, 2 Mar 2003 16:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTCBVsh>; Sun, 2 Mar 2003 16:48:37 -0500
Received: from franka.aracnet.com ([216.99.193.44]:50865 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261427AbTCBVsg>; Sun, 2 Mar 2003 16:48:36 -0500
Date: Sun, 02 Mar 2003 13:58:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <85980000.1046642338@[10.10.2.4]>
In-Reply-To: <20030302210606.GS24172@holomorphy.com>
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a relatively large (12s/44s == 27%) difference between absolute
> timings on our machines, which suggests a large disturbance in the force.
> 2.5.63-bk5 virgin appears to get timings in the low 40's.

Did you actually read the previous email? 
Same config file? Same tree? same compiler (gcc 2.95.4?)

>> Would be useful if you can grab a before and after profile, and see exactly
>> what it is that's getting thrashed that you're fixing (may just be everything).
> 
>> From the profile posted it's the division in page_zone().

I think we're talking about different things:

1. Need to isolate what's causing the 6s improvement you're seeing.
Can you generate profiles & time output for before and after the patch,
and describe the test you're running (presumably make -j).

2. SDET degredation. I'll try the additional patch you sent out on that.

M.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273863AbSISXhX>; Thu, 19 Sep 2002 19:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273908AbSISXhX>; Thu, 19 Sep 2002 19:37:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54427 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S273863AbSISXhW>;
	Thu, 19 Sep 2002 19:37:22 -0400
Date: Thu, 19 Sep 2002 16:45:41 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu, Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <71640000.1032479141@w-hlinder>
In-Reply-To: <3D8A5FE6.4C5DE189@digeo.com>
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, September 19, 2002 16:38:14 -0700 Andrew Morton <akpm@digeo.com> wrote:

> Hanna Linder wrote:
>> 
>> ...
>>         So akpm's removal of lock section directives breaks down the
>> functions holding locks that previously were reported under the
>> .text.lock.filename?
> 
> Yup.  It makes the profiler report the spinlock cost at the
> actual callsite.  Patch below.

	Thanks. We've needed that for quite some time.
> 
>> Looks like fastwalk might not behave so well
>> on this 32 cpu numa system...
> 
> I've rather lost the plot.  Have any of the dcache speedup
> patches been merged into 2.5?

	Yes, starting with 2.5.11. Al Viro made some changes to
it and it went in. Havent heard anything about it since...

Hanna


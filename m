Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313403AbSDQHzS>; Wed, 17 Apr 2002 03:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313762AbSDQHzR>; Wed, 17 Apr 2002 03:55:17 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:4100 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313403AbSDQHzQ>; Wed, 17 Apr 2002 03:55:16 -0400
Message-ID: <3CBD2A56.857B6D5E@aitel.hist.no>
Date: Wed, 17 Apr 2002 09:55:02 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.8-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <15548.22093.57788.557129@napali.hpl.hp.com>
		<Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com> <15548.50859.169392.857907@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

> The last time I measured timer tick overhead on ia64 it was well below
> 1% of overhead.  I don't really like using kernel builds as a
> benchmark, because there are far too many variables for the results to
> have any long-term or cross-platform value.  But since it's popular, I
> did measure it quickly on a relatively slow (old) Itanium box: with
> 100Hz, the kernel compile was about 0.6% faster than with 1024Hz
> (2.4.18 UP kernel).

Did you try a parallell build, with the number of processes at least
2-3 times the number of processors?  Then you get more
of the cache-miss effects from switching processes, not
merely the overhead of the fairly fast scheduler.

Helge Hafting

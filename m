Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRDJTuA>; Tue, 10 Apr 2001 15:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRDJTtu>; Tue, 10 Apr 2001 15:49:50 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:59148 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S131985AbRDJTth>;
	Tue, 10 Apr 2001 15:49:37 -0400
Message-Id: <200104101949.NAA208788@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.3 Crash - (Kernel BUG at highmem.c:155)
In-Reply-To: <0104101811150C.25951@webman>
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Tue, 10 Apr 2001 13:49:32 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have seen the Kernel BUG at highmem.c:155 problem on a machine
I am testing.  It is a Dell 8 processor P-III 700Mhz with 8GB of
memory and Linux 2.4.3 + a knfsd and quota patch for reiserfs.  When
doing 5 simultaneous kernel compiles from another machine mounting the
8 processor one over nfs the 8 processor machine hung with an error
message somewhat like

nfsd: terminating on signal 2
kernel BUG at highmem.c: 155!
invalid operand: 0000
CPU: 6

I apologize for the nearly useless error information, but I am 5000
miles and 7 time zones away from this machine, so I have to depend on
others for getting me on console information until I can get it moved
over to a serial console.

>Occassional lockups lasting 5-20 seconds were experienced when working on the 
>box under 2.4.2 but seem to be much better in 2.4.3.

The machine is also having these odd lockup problems under intense
disk IO, but I will detail that in another message (look for "kswapd,
kupdated, and bdflush at 99%").

Any advice to alleviate this problem would be appreciated, and I will
provide any more information I can upon request.

--
Thanks,
Jeff Lessem.

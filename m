Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTEETkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbTEETkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:40:10 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:43943 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S261252AbTEETkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:40:08 -0400
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
From: Steven Cole <elenstev@mesatop.com>
To: Valdis.Kletnieks@vt.edu
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <200305051817.h45IHwJC003355@turing-police.cc.vt.edu>
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov>
	 <m1d6ixb8m7.fsf@frodo.biederman.org>
	 <1052157615.2163.113.camel@spc9.esa.lanl.gov>
	 <200305051817.h45IHwJC003355@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1052164261.2166.129.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 05 May 2003 13:51:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 12:17, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 05 May 2003 12:00:15 MDT, Steven Cole said:
> 
> > Perhaps two uptimes could be kept. The current concept of uptime would
> > remain as is, analogous to the reign of a king (the current kernel), and
> > a new integrated uptime would be analogous to the life of a dynasty. The
> > dynasty uptime would be one of the many things the new kernel learned
> > about on booting. This new dynasty uptime could become quite long if
> > everything keeps on ticking.
> 
> Make sure you handle the case of a dynasty that starts on a 2.7.13 kernel
> and is finally deposed by a power failure in 2.7.39.
> 
2.7.13 eh?  Wow, that's optimistic.  I guess Karim and others better get
busy.  Unless Linus throws in about 50 kernels with the -preX naming
scheme like this last time. ;)

Here's nice long uptime:

tstad% uptime
 12:58pm  up 503 days,  1:30,  3 users,  load average: 0.23, 0.04, 0.00
tstad% uname -a
ULTRIX tstad 4.3 1 RISC

I guess Ultrix didn't have a jiffie wraparound problem at 497 days. 
That DEC 5000/200 has run almost continuously for 12 years, except for
the occasional palace revolution/forest fire fiasco.

Steven



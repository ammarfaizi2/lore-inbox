Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268179AbTCFRK3>; Thu, 6 Mar 2003 12:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTCFRK3>; Thu, 6 Mar 2003 12:10:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4007
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268179AbTCFRK2>; Thu, 6 Mar 2003 12:10:28 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       rml@tech9.net, mingo@elte.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E6770F3.8030207@pobox.com>
References: <Pine.LNX.4.44.0303060710350.7206-100000@home.transmeta.com>
	 <3E6770F3.8030207@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046975159.17718.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 18:25:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 16:01, Jeff Garzik wrote:
> Pardon the suggestion of a dumb hueristic, feel free to ignore me: 
> would it work to run-first processes that have modified their iopl() 
> level?  i.e. "if you access hardware directly, we'll treat you specially 
> in the scheduler"?

Not all X servers do that. X is not special in any way. Its just a
daemon. It has the same timing properties as many other daemons doing
time critical operations for many clients



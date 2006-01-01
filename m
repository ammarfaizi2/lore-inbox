Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWAAPbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWAAPbm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWAAPbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:31:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10654 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751348AbWAAPbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:31:42 -0500
Date: Sun, 1 Jan 2006 16:31:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mark Knecht <markknecht@gmail.com>
cc: Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.15-rc7-rt1
In-Reply-To: <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601011629320.11226@yvahk01.tjqt.qr>
References: <20051228172643.GA26741@elte.hu>  <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
  <1136051113.6039.109.camel@localhost.localdomain> 
 <1136054936.6039.125.camel@localhost.localdomain>
 <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>   Happy New Year.
>
>   Is this the same problem Steven? It happened when running MythTV
>for the first time. Rerunning MythTV did not cause a second problem
>and the program then ran fine.

Try in userspace:
   strace -e open mythtv 2>&1 | grep /dev/rtc

should probably enlighten you a little more. I'd be very surprised if it 
was not rtc now..



Jan Engelhardt
-- 

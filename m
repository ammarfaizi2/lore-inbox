Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTJNBRm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTJNBRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:17:42 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:39430 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S262127AbTJNBRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:17:41 -0400
Message-ID: <3F8B4EC4.2584A2E9@compuserve.com>
Date: Mon, 13 Oct 2003 21:17:56 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.0-test7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: machine hangs in 2.6 bk latest
References: <3F89C10A.D230DD33@compuserve.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius wrote:
> 
> I've noticed a pair of machine hangs today with latest 2.6.0 bk tree.
> So far, I've been unable to retrieve information from the test machine,
> as the network is down, console is unresponsive and in power save at the
> time of the hang.  (I've haven't tried Magic-Sysrq yet.)
> 
> After reboot, logs are truncated, so no useful information there either.
> 
> System is base SuSE 8.2, running 2.6.0 bk, pulled today (Sun 16:00 EST
> or earlier).
> 
> Dual AMD MP CPUs, with reiserfs main fs on Mylex RAID disks.  2.6 bk
> kernel from about a week ago was stable on this machine.  I'll try and
> capture more info.  Any thoughts, please copy my email.


bk pulls from today behave the same.  The lockup seems to occur while
using an ssh forwarded X connection and moving a large mozilla window on
a remote machine.

The server machine is hard locked.  Alt-Sysrq does not respond at all.

-- 
Kevin

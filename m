Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVC2LgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVC2LgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVC2LgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:36:25 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:25842 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262214AbVC2LgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:36:19 -0500
Subject: Re: sched_setscheduler() and usage issues ....please help
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Arun Srinivas <getarunsri@hotmail.com>,
       nickpiggin@yahoo.com.au, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
References: <BAY10-F472EE1F6A6F80FEA2F5568D9450@phx.gbl>
	 <1112071215.3691.27.camel@localhost.localdomain>
	 <1112071867.19014.30.camel@mindpipe>
	 <Pine.LNX.4.61.0503290802170.25114@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 29 Mar 2005 06:35:47 -0500
Message-Id: <1112096147.3691.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 08:03 +0200, Jan Engelhardt wrote:
> >> > I am trying to set the SCHED_FIFO  policy for my process.I am using 
> >> > sched_setscheduler() function to do this.
> >> 
> >> Attached is a little program that I use to set the priority of tasks.
> >
> >Why not just use chrt from schedtools?
> 
> Not every distro has it yet, and I like to point out that a lot of users is 
> still using "older" distros, such as FC2, SUSE 9.1, and also olders with Linux 
> 2.4 kernels.

OK, I'm a little embarrassed. I never saw this tool. I use debian
unstable, but didn't have the package loaded.  I did a apropos on
sched_setscheduler, and it didn't come up with any tools, so I just
wrote my own!

Thanks,

-- Steve



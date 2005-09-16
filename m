Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbVIPBan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbVIPBan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 21:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVIPBan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 21:30:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50566 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161021AbVIPBam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 21:30:42 -0400
Subject: Re: inotify bug?
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@novell.com>
In-Reply-To: <20050915214848.GJ7991@shell0.pdx.osdl.net>
References: <1126815172.3185.8.camel@mindpipe>
	 <20050915214848.GJ7991@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 21:30:40 -0400
Message-Id: <1126834240.4986.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 14:48 -0700, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > I got this in dmesg with 2.6.13-rc7-rt3 the other day.  Maybe it's
> > useful.  There were no visible effects.
> > 
> > idr_remove called for id=1024 which is not allocated.
> 
> This should already be fixed in 2.6.13.
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7c657f2f25d50c602df9291bc6242b98fc090759
> 

Thanks, nice to see that my suspicion of an off by one error was right
(the 1024 was a dead giveaway).

BTW the rate of kernel development is just insane these days, even
compared to a year ago.  It's quite encouraging.  At this rate we're
going to leave the "competition" in the dust.

Lee


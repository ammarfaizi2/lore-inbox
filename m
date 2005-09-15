Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbVIOVs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbVIOVs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbVIOVs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:48:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030561AbVIOVsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:48:55 -0400
Date: Thu, 15 Sep 2005 14:48:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@novell.com>
Subject: Re: inotify bug?
Message-ID: <20050915214848.GJ7991@shell0.pdx.osdl.net>
References: <1126815172.3185.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126815172.3185.8.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> I got this in dmesg with 2.6.13-rc7-rt3 the other day.  Maybe it's
> useful.  There were no visible effects.
> 
> idr_remove called for id=1024 which is not allocated.

This should already be fixed in 2.6.13.

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7c657f2f25d50c602df9291bc6242b98fc090759

thanks,
-chris

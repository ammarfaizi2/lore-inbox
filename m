Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVAAJXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVAAJXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 04:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVAAJXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 04:23:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262204AbVAAJXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 04:23:00 -0500
Date: Sat, 1 Jan 2005 01:22:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, kernel@kolivas.org,
       rncbc@rncbc.org, paul@linuxaudiosystems.com
Subject: Re: Latency results with 2.6.10 - looks good
Message-Id: <20050101012252.7b4645b7.akpm@osdl.org>
In-Reply-To: <1104549524.3803.28.camel@krustophenia.net>
References: <1104348820.5218.42.camel@krustophenia.net>
	<1104549524.3803.28.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Followup: other audio users have confirmed that 2.6.10 is the best
>  release yet latency-wise.  It works most of the time at 64 frames
>  (~1.33ms latency).
> 
>  Now, the bad news: there are still enough xruns to make it not quite
>  good enough for, say, a recording studio; as we all know with realtime
>  constraints the worst case scenario is important.

The kernel which you should be testing is most-recent -mm.  The -mm kernels
have had a bunch of latency improvements which are queued for 2.6.11.  We
need to know how that stuff performs - 2.6.10 is largely uninteresting from
a development POV.

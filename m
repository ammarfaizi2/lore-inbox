Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUKLUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUKLUlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbUKLUlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 15:41:49 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:9897 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261614AbUKLUlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 15:41:45 -0500
Subject: Re: [PATCH 3/3] Fix sysdev time support
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041112080000.GC6307@atrey.karlin.mff.cuni.cz>
References: <1100213485.6031.18.camel@desktop.cunninghams>
	 <1100213867.6031.33.camel@desktop.cunninghams>
	 <20041112080000.GC6307@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1100291593.4090.2.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 13 Nov 2004 07:33:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-12 at 19:00, Pavel Machek wrote:
> Hi!
> 
> > Fix type of sleep_start, so as to eliminate clock skew due to math
> > errors.
> 
> Are you sure? I do not think long signed/unsigned problem can skew the
> clock by 1hour. I could see skewing clock by few years, but not by one
> hour...

It seemed small to me, too. Perhaps I just didn't notice the shift in
the date. I'll look again, if you like.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6


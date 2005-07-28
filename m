Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVG1BUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVG1BUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVG1BUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:20:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16613 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261475AbVG1BUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:20:47 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 21:20:45 -0400
Message-Id: <1122513645.22844.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 18:00 -0700, Daniel Walker wrote:
> Don't you break sched_find_first_bit() , seems it's dependent on a 
> 140-bit bitmap .

And doesn't POSIX specify 100 RT priority levels?

Lee


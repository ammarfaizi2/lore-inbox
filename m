Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVG1B1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVG1B1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 21:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVG1B1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 21:27:46 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:51702 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261483AbVG1B0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 21:26:42 -0400
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122513645.22844.15.camel@mindpipe>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513645.22844.15.camel@mindpipe>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 21:26:20 -0400
Message-Id: <1122513980.29823.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 21:20 -0400, Lee Revell wrote:
> On Wed, 2005-07-27 at 18:00 -0700, Daniel Walker wrote:
> > Don't you break sched_find_first_bit() , seems it's dependent on a 
> > 140-bit bitmap .
> 
> And doesn't POSIX specify 100 RT priority levels?

My customers don't care about POSIX :-)

-- Steve



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWGMQnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWGMQnv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWGMQnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:43:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6036 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030234AbWGMQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:43:50 -0400
Subject: Re: Where is RLIMIT_RT_CPU?
From: Lee Revell <rlrevell@joe-job.com>
To: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152663825.27958.5.camel@localhost>
References: <1152663825.27958.5.camel@localhost>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:43:59 -0400
Message-Id: <1152809039.8237.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 10:23 +1000, Jean-Marc Valin wrote:
> Hi,
> 
> I saw many references to RLIMIT_RT_CPU (e.g. in
> http://lwn.net/Articles/120797/ ) as a way of limiting the amount of CPU
> an unprivileged task can use at real-time priority. My understand was
> that the feature had been merged into 2.6.12 as part of Ingo's rt-limit
> patches. Unfortunately, I can't find any reference to that on my system
> (latest Ubuntu), so I'm wondering where it's gone. Has it been removed,
> renamed, ...? Considering that Ubuntu Dapper currently allows any user
> to make unlimited use of realtime scheduling, this feature would be
> really useful to prevent user apps from accidently crashing the system.

It was not merged.

This problem should be addressed by a userspace RT watchdog.  Ubuntu
should not have shipped their system with unlimited non-root realtime
enabled and no watchdog.

Lee


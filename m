Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVKFVkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVKFVkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVKFVkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:40:22 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49627 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932242AbVKFVkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:40:21 -0500
Subject: Re: 2.6.14-rt1: oprofile doesn't work anymore
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1131060132.4770.2.camel@mindpipe>
References: <1131053974.23154.9.camel@mindpipe>
	 <1131060132.4770.2.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 13:45:59 -0500
Message-Id: <1131302759.13599.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 18:22 -0500, Lee Revell wrote:
> I just tested this with oprofile both built into the kernel and as a
> module, and with oprofile userspace tools 0.9.1 and from CVS.  No
> change.  I have verified that /dev/oprofile is mounted.  It looks like
> the profiler never sees any samples.
> 
> rlrevell@mindpipe:~$ cat /dev/oprofile/stats/cpu0/sample_received 
> 0
> 
> Could one of the ktimers changes have broken the timer interrupt based
> profiling?

I have verified that oprofile does work with 2.6.14.  So the breakage is
unique to the -rt kernel.

Lee


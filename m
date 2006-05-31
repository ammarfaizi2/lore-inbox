Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWEaD2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWEaD2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 23:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWEaD2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 23:28:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22408 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751600AbWEaD2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 23:28:17 -0400
Subject: Re: 2.6.14-rt1: oprofile doesn't work anymore
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1131302759.13599.10.camel@mindpipe>
References: <1131053974.23154.9.camel@mindpipe>
	 <1131060132.4770.2.camel@mindpipe>  <1131302759.13599.10.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 30 May 2006 23:27:56 -0400
Message-Id: <1149046077.4239.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(replying to a very old thread)

On Sun, 2005-11-06 at 13:45 -0500, Lee Revell wrote:
> On Thu, 2005-11-03 at 18:22 -0500, Lee Revell wrote:
> > I just tested this with oprofile both built into the kernel and as a
> > module, and with oprofile userspace tools 0.9.1 and from CVS.  No
> > change.  I have verified that /dev/oprofile is mounted.  It looks like
> > the profiler never sees any samples.
> > 
> > rlrevell@mindpipe:~$ cat /dev/oprofile/stats/cpu0/sample_received 
> > 0
> > 
> > Could one of the ktimers changes have broken the timer interrupt based
> > profiling?
> 
> I have verified that oprofile does work with 2.6.14.  So the breakage is
> unique to the -rt kernel.

Ingo,

oprofile still does not work with the -rt kernel (verified with
2.6.16-rt20).

Can anyone else reproduce this?

Lee




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUJOIVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUJOIVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 04:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUJOIVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 04:21:50 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:13 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266572AbUJOIV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 04:21:28 -0400
Date: Fri, 15 Oct 2004 01:21:04 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041015082104.GA31709@nietzsche.lynx.com>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015022341.GA22831@nietzsche.lynx.com> <20041015070839.GA8373@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20041015070839.GA8373@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 15, 2004 at 09:08:39AM +0200, Ingo Molnar wrote:
> as a workaround enable HIGHMEM and PREEMPT_TIMING+LATENCY_TRACE.

Build problem:

bill


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=t

  CC      fs/reiser4/debug.o
In file included from include/linux/spinlock.h:16,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:12,
                 from fs/reiser4/kattr.h:12,
                 from fs/reiser4/debug.c:31:
include/asm/mutex.h:75:5: warning: "RWSEM_DEBUG" is not defined
  CC      fs/reiser4/stats.o
In file included from include/linux/spinlock.h:16,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:12,
                 from fs/reiser4/kattr.h:12,
                 from fs/reiser4/stats.c:46:
include/asm/mutex.h:75:5: warning: "RWSEM_DEBUG" is not defined
  CC      fs/reiser4/jnode.o
In file included from include/linux/spinlock.h:16,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:12,
                 from fs/reiser4/reiser4.h:13,
                 from fs/reiser4/jnode.c:103:
include/asm/mutex.h:75:5: warning: "RWSEM_DEBUG" is not defined
  CC      fs/reiser4/znode.o
In file included from include/linux/spinlock.h:16,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:12,
                 from fs/reiser4/reiser4.h:13,
                 from fs/reiser4/debug.h:9,
                 from fs/reiser4/znode.c:142:
include/asm/mutex.h:75:5: warning: "RWSEM_DEBUG" is not defined
  CC      fs/reiser4/key.o
In file included from include/linux/spinlock.h:16,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:12,
                 from fs/reiser4/reiser4.h:13,
                 from fs/reiser4/debug.h:9,
     


--BXVAT5kNtrzKuDFl--

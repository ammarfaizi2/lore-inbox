Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUJNUn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUJNUn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUJNUk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:40:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30359 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267549AbUJNUVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:21:33 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
From: Lee Revell <rlrevell@joe-job.com>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>, Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <200410142216.23572.l_allegrucci@yahoo.it>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <200410142216.23572.l_allegrucci@yahoo.it>
Content-Type: text/plain
Message-Id: <1097785289.2682.46.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 16:21:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 16:16, Lorenzo Allegrucci wrote:
> BTW, I'm getting a lot of "scheduling while atomic" messages
> running LTP's runalltests.sh -x 200.
> Attached is the kern.log and the latency trace.

Looks like that latency trace is mostly printk overhead from the
scheduling while atomic errors.  In general, if you are still getting
lots of printks in your logs due to bugs, the latency traces are not
very useful.

Lee


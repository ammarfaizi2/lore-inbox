Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVFVRWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVFVRWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVFVRSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:18:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:2705 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261713AbVFVRRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:17:45 -0400
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
From: Lee Revell <rlrevell@joe-job.com>
To: karim@opersys.com
Cc: paulmck@us.ibm.com, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <42B9845B.8030404@opersys.com>
References: <1119287612.6863.1.camel@localhost>
	 <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com>
	 <20050622011931.GF1324@us.ibm.com>  <42B9845B.8030404@opersys.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 13:17:40 -0400
Message-Id: <1119460661.491.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 11:31 -0400, Karim Yaghmour wrote:
> max_ipipe_delay = 27.5us
> average_ipipe_delay = 7us
> max_preempt_delay = 55us - max_ipipe_delay = 27.5us
> average_preempt_delay = 14 us - average_ipipe_delay = 7us 

Ingo, what's the status of putting irq 0 back in a thread with
PREEMPT_RT?  IIRC this had some adverse (maybe unfixable?) effects so it
was disabled a few months ago.

I don't think there's much point in comparing i-pipe to PREEMPT_RT if we
know that 21usec pipeline effect from the timer IRQ (see list archives)
is still there.

Lee


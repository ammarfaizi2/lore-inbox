Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271042AbUJUWcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbUJUWcB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbUJUWbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:31:53 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28173 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S271034AbUJUWbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:31:03 -0400
Message-ID: <41783B6C.2040502@techsource.com>
Date: Thu, 21 Oct 2004 18:42:52 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Jens Axboe <axboe@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com>
In-Reply-To: <20041021202422.GA24555@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Huey (hui) wrote:

> 
> 
> You use a semaphore to protect data, a completion isn't protecting data
> but preserving a certain kind of wait ordering in the code. The
> possibility of overloading the current mutex_t for PI makes for a conceptual
> mismatch when used in this case since having a kind of priority for
> completions is a bit odd. It's better to flat out use a completion
> instead, IMO.
> 


Could you please define "completion" for me in this context?

Thanks.


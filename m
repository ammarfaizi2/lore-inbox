Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSFTRxE>; Thu, 20 Jun 2002 13:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSFTRxD>; Thu, 20 Jun 2002 13:53:03 -0400
Received: from holomorphy.com ([66.224.33.161]:36799 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315278AbSFTRxC>;
	Thu, 20 Jun 2002 13:53:02 -0400
Date: Thu, 20 Jun 2002 10:52:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020620175229.GX22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020620172059.GW22961@holomorphy.com> <Pine.LNX.4.44.0206201929310.9805-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206201929310.9805-100000@e2>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 07:31:18PM +0200, Ingo Molnar wrote:
> looks good to me - what do you think about my other pidhash suggestion:

>> And i'm not quite sure whether it's needed to expose the pidhash to the
>> rest of the kernel - it would be much simpler to have it in
>> kernel/fork.c locally, and find_task_by_pid() would be a function
>> instead of an inline. (it has a ~49 bytes footprint on x86, it's rather
>> heavy i think.)

It's an excellent idea, I think I only forgot that was in the queue of
things to write. I'll follow up with that as well.


Thanks,
Bill

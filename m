Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUGICAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUGICAT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUGICAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:00:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:34463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262906AbUGIB7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 21:59:02 -0400
Date: Thu, 8 Jul 2004 18:57:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: pwil3058@bigpond.net.au, Alexander.Povolotsky@marconi.com,
       linux-kernel@vger.kernel.org, efault@gmx.de, rml@tech9.net,
       mingo@elte.hu, kernel@kolivas.org, elladan@eskimo.com,
       cks@utcc.utoronto.ca
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum	) que
 stio n
Message-Id: <20040708185726.1c375176.akpm@osdl.org>
In-Reply-To: <40EDF8F5.2060808@yahoo.com.au>
References: <313680C9A886D511A06000204840E1CF08F42FE6@whq-msgusr-02.pit.comms.marconi.com>
	<40EDD980.4040608@bigpond.net.au>
	<40EDF8F5.2060808@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> However well tested your scheduler might be, it needs several
>  orders of magnitude more testing ;) Maybe the best we can hope
>  for is compile time selectable alternatives.

At this stage in the kernel lifecycle, for something as fiddly as the CPU
scheduler we really should be 100% driven by problem reporting.

If someone can identify a particular misbehaviour in the CPU scheduler then
they should put their editor away and work to produce a solid testcase. 
Armed with that, we can then identify the source of the particular problem.

It is at this point, and no earlier, that we can decide what an appropriate
solution is.  We then balance the risk of that solution against the severity
of the problem which it solves and make a decision as to whether to proceed.

Right now, the ratio of quality bug reporting to scheduler patching is
bizarrely small.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTIGSMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTIGSMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:12:53 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:48142
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263418AbTIGSMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:12:50 -0400
Message-ID: <3F5B750D.9060108@cyberone.com.au>
Date: Mon, 08 Sep 2003 04:12:29 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Robert Love <rml@tech9.net>, jyau_kernel_dev@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>	<1062878664.3754.12.camel@boobies.awol.org>	<3F5ABD3A.7060709@cyberone.com.au>	<20030906231856.6282cd44.akpm@osdl.org>	<1062954122.12822.3.camel@boobies.awol.org> <20030907103447.410016f6.akpm@osdl.org>
In-Reply-To: <20030907103447.410016f6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Robert Love <rml@tech9.net> wrote:
>
>> There are a _lot_ of scheduler changes in 2.6-mm, and who knows which
>> ones are an improvement, a detriment, and a noop?
>>
>
>We know that sched-2.6.0-test2-mm2-A3.patch caused the regression, and
>we now that sched-CAN_MIGRATE_TASK-fix.patch mostly fixed it up.
>
>What we don't know is whether the thing which sched-CAN_MIGRATE_TASK-fix.patch
>fixed was the thing which sched-2.6.0-test2-mm2-A3.patch broke.
>
>

I think Robert was just talking about general improvements or regressions,
etc. I don't think Con is going too badly though - the small amount of
feedback I read about it is normally positive.

I think we might as well use -linus tree for testing while its still in
the test release phase. It probably gets a few orders of magnitude more
testing than mm.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbTIGHCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 03:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbTIGHCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 03:02:45 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:56070
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263040AbTIGHCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 03:02:43 -0400
Message-ID: <3F5AD802.8080702@cyberone.com.au>
Date: Sun, 07 Sep 2003 17:02:26 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, rml@tech9.net, jyau_kernel_dev@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>	<1062878664.3754.12.camel@boobies.awol.org>	<3F5ABD3A.7060709@cyberone.com.au>	<20030906231856.6282cd44.akpm@osdl.org>	<3F5AD03E.5070506@cyberone.com.au> <20030906234545.46c990d6.akpm@osdl.org> <3F5AD75A.6080703@cyberone.com.au>
In-Reply-To: <3F5AD75A.6080703@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Andrew Morton wrote:
>
>>
>>
>> Also, I'm concerned that sched-2.6.0-test2-mm2-A3 caused slowdowns and
>> Andrew's patch caused speedups and they just cancelled out.  Let's get
>> Andrew's patch into Linus's tree and see if it speeds things up.  If it
>> does, we probably still have a problem.
>>
>>
>
> The slowdowns are due to CPUs becoming idle too long, and the patches
> fix that. If CPUs aren't idle, the patch will have no effect.


Oh... I guess this is what you were saying?



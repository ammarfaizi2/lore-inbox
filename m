Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTLSFOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 00:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbTLSFOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 00:14:23 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:37010 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265341AbTLSFOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 00:14:22 -0500
Message-ID: <3FE2890D.1000308@cyberone.com.au>
Date: Fri, 19 Dec 2003 16:13:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031215060838.BF3D32C257@lists.samba.org> <3FDE3EF7.7000001@cyberone.com.au> <3FE28529.1010003@cyberone.com.au>
In-Reply-To: <3FE28529.1010003@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> Easier said than done... anyway, how does this patch look?
> It should also cure a possible and not entirely unlikely use
> after free of the task_struct in sched_migrate_task on NUMA
> AFAIKS.


Err, no of course it doesn't because its executed by said task.
So the get/put_task_struct can go.




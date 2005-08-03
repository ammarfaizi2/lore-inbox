Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVHCK0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVHCK0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVHCK0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:26:43 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:21356 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262202AbVHCKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:25:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YW2A+gWvuPTipXIy34u0EDn5a59JpoS9jQSEry0FqPExFJOe5Nlszl3pVyUlxSZhSb8tfSnRJ1rpL0QIi7E2kq2VSyOnjhDS3dP9RN+vTsjzcAesZt7Df3Qm3RmDsTDJHWDlFSVGj/Y8AgWrIgxZ9C31zxMakNzHVP1/MWbRotA=  ;
Message-ID: <42F09BA8.9030403@yahoo.com.au>
Date: Wed, 03 Aug 2005 20:25:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [patch 2/2] sched: reduce locking in periodic balancing
References: <42EF65A9.1060408@yahoo.com.au> <42EF65FF.2000102@yahoo.com.au> <42EF6628.4070102@yahoo.com.au> <20050803075916.GB6013@elte.hu>
In-Reply-To: <20050803075916.GB6013@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

[...]

Thanks for the corrections.

> 
> btw., holding the runqueue lock during the initial scanning portion of 
> load-balancing is one of the top PREEMPT_RT critical paths on SMP. (It's 
> not bad, but it's one of the factors that makes SMP latencies higher.)
> 

Good, I'm glad they will be of some immediate help.

> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

Thanks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

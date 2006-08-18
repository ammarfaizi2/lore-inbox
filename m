Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWHRUIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWHRUIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWHRUIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:08:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25490 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932487AbWHRUIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:08:38 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 3/7] UBC: ub context and inheritance
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E33C04.50803@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C04.50803@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Aug 2006 13:03:43 -0700
Message-Id: <1155931423.26155.74.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 19:38 +0400, Kirill Korotaev wrote:
> Contains code responsible for setting UB on task,
> it's inheriting and setting host context in interrupts.
> 
> Task references three beancounters:
>   1. exec_ub  current context. all resources are
>               charged to this beancounter.
>   2. task_ub  beancounter to which task_struct is
>               charged itself.

I do not see why task_ub is needed ? i do not see it being used
anywhere.

>   3. fork_sub beancounter which is inherited by
>               task's children on fork

>From other emails it looks like renaming fork/exec to be real/effective
will be easier to understand.

>
>
<snip>

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



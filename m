Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUIIAkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUIIAkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUIIAkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:40:00 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:32443 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269240AbUIIAj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:39:58 -0400
Message-ID: <413F997C.6090603@yahoo.com.au>
Date: Thu, 09 Sep 2004 09:45:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Lynch <nathanl@austin.ibm.com>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix schedstats null deref in sched_exec
References: <413EFFFB.5050902@yahoo.com.au> <413F0070.2020104@yahoo.com.au>	 <413F01C7.3060008@yahoo.com.au> <1094658900.14438.6.camel@booger>
In-Reply-To: <1094658900.14438.6.camel@booger>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:
> Oops, I meant to send this one with my original patchset.
> 
> In sched_exec, schedstat_inc will dereference a null pointer if no
> domain is found with the SD_BALANCE_EXEC flag set.  This was exposed
> during testing of the previous patches where cpus are temporarily
> attached to a dummy domain without SD_BALANCE_EXEC set.
> 
> Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
> 

Thanks. I'll get everything together and send it to Andrew.

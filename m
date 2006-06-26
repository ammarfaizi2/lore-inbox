Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932979AbWFZTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979AbWFZTqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbWFZTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:46:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:25751 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932979AbWFZTqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:46:22 -0400
Message-ID: <44A03988.7090104@watson.ibm.com>
Date: Mon, 26 Jun 2006 15:46:16 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jay Lan <jlan@sgi.com>, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] delay accounting taskstats interface send tgid once
References: <44A02331.8020903@watson.ibm.com>	<44A02FB0.6000505@sgi.com> <20060626123819.b5b9a156.akpm@osdl.org>
In-Reply-To: <20060626123819.b5b9a156.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Mon, 26 Jun 2006 12:04:16 -0700
>Jay Lan <jlan@sgi.com> wrote:
>
>  
>
>>Is this patch supposed to go on top of all other patches? Or is it
>>supposed to replace any? I had failure applying this patch on top
>>of all previously applied.
>>    
>>
>
>It would have got tangled up with the task-watchers patches.
>
>ahem.  Documentation/SubmitChecklist, item 2:
>  
>

>In file included from kernel/exit.c:29:
>include/linux/taskstats_kern.h: In function 'taskstats_exit_send':
>include/linux/taskstats_kern.h:80: error: parameter name omitted
>In file included from include/linux/delayacct.h:21,
>                 from kernel/fork.c:47:
>include/linux/taskstats_kern.h: In function 'taskstats_exit_send':
>include/linux/taskstats_kern.h:80: error: parameter name omitted
>make[1]: *** [kernel/exit.o] Error 1
>make: *** [kernel/exit.o] Error 2
>make: *** Waiting for unfinished jobs....
>make[1]: *** [kernel/fork.o] Error 1
>make: *** [kernel/fork.o] Error 2
>  
>
Oops. Thanks for the catch. It didn't get flagged on my compiles for 
some reason.



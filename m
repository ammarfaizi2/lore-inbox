Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTEVU2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTEVU2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:28:05 -0400
Received: from freeside.toyota.com ([63.87.74.7]:906 "EHLO freeside.toyota.com")
	by vger.kernel.org with ESMTP id S263235AbTEVU2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:28:04 -0400
Message-ID: <3ECD35E2.10109@tmsusa.com>
Date: Thu, 22 May 2003 13:41:06 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm8 improvements and one oops
References: <3ECD13A1.9060103@tmsusa.com> <20030522130731.10f34d58.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote

>You hit the free-of-a-freed-task_struct bug.
>  
>
>This bug has been hanging around for ages.  It is very rare and nobody
>knows what causes it.
>
I'm lucky I suppose -

>
>Are you running preempt?  SMP?   Is it repeatable?
>
It's preempt, defintely, always -

But just a UP kernel on a lowly UP box -

As for repeatability, I'll see if I can induce
the oops again but there's no telling...

Joe



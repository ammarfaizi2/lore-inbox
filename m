Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbTGGCNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266796AbTGGCNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:13:09 -0400
Received: from dyn-ctb-210-9-243-115.webone.com.au ([210.9.243.115]:16132 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S266793AbTGGCMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:12:52 -0400
Message-ID: <3F08DA84.7010500@cyberone.com.au>
Date: Mon, 07 Jul 2003 12:27:16 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net> <20030706204630.GA2904@ip68-4-255-84.oc.oc.cox.net>
In-Reply-To: <20030706204630.GA2904@ip68-4-255-84.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,
How repeatable are the freezes? Would you be able to get a new
kernel, and capture a sysrq-T trace once the system has frozen?
Then would you try booting with elevator=deadline and see if you
can get it to freeze?

Thanks
Nick

Barry K. Nathan wrote:

>On Thu, Jul 03, 2003 at 02:05:41AM -0700, Barry K. Nathan wrote:
>
>>When I run 2.5.73-mm[123] on a Mandrake Cooker system here, it generally
>>runs fine. However, when I run "urpmi --auto-select" to upgrade the
>>packages to the latest versions, rpm tends to freeze up during
>>installation of one of the packages. This did not seem to happen with
>>2.5.70-mm9, which was the kernel I ran before 2.5.73-mm1.
>>
>[snip]
>
>I've figured things out a bit more and filed a Bugzilla report:
>http://bugme.osdl.org/show_bug.cgi?id=877
>
>-Barry K. Nathan <barryn@pobox.com>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


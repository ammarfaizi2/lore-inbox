Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUJOLpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUJOLpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUJOLpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:45:13 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:56244 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S267689AbUJOLoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:44:55 -0400
Message-ID: <416FB827.5090509@t-online.de>
Date: Fri, 15 Oct 2004 13:44:39 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4: Kernel BUG at timer:414
References: <416EAB15.6030304@t-online.de>
In-Reply-To: <416EAB15.6030304@t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EfGQvwZc8e3CJlr+6pX62Gk4uriu3XyXwimpCF9N5xjpEmdIilB68j
X-TOI-MSGID: 023dd308-a444-4229-839b-2f8efca5aee3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What should I do to become worth a response?


Harri
-----------------------------------------------------------------------
Harald Dunkel wrote:
> Hi folks,
> 
> I got a kernel panic on amd64:
> 
> 
> Kernel BUG at timer:414
> invalid operand: 0000 [1] PREEMPT
> CPU 0
> Modules linked in: ...
> Pid: 3711, comm: mktemp Not tainted 2.6.9-rc4
> RIP: 0010: ...{cascade+46}
> :
> :
> Process mktemp (pid 3711, ...)
> Stack: ...
> Call Trace: <IRQ>
>             <...>{run_timer_softirq}
>             <...>{__do_softirq+83}
>             <...>{do_softirq+53}
>             <...>{do_IRQ+383}
>             <...>{ret_from_intr+0}
>             <EOI>
> Code 0f 0b 66 b1 2f 80 ff ff ff ff9e 01 66 66 90 66 66 90 48 8b
> RIP <...>{cascade+46}
>  <0> Kernel panic - not syncing: Aiee, killing interrupt handler!
> 
> 
> Please excuse that I did not write down every hex code
> of the error message.
> 
> 
> Regards
> 
> Harri
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWDGCvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWDGCvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 22:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWDGCvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 22:51:10 -0400
Received: from mail.tmr.com ([64.65.253.246]:47027 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932296AbWDGCvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 22:51:08 -0400
Message-ID: <4435D524.6020403@tmr.com>
Date: Thu, 06 Apr 2006 22:57:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: [RFC] sched.c : procfs tunables
References: <200603311723.49049.a1426z@gawab.com>
In-Reply-To: <200603311723.49049.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>Proper scheduling in a multi-tasking environment is critical to the success 
>of a desktop OS.  Linux, being mainly a server OS, is currently tuned to 
>scheduling defaults that may be appropriate only for the server scenario.
>  
>
I'm not sure I would agree about distribution kernels, and kernel.org 
kernels certainly have the options to trade overhead for more response.

>To enable Linux to play an effective role on the desktop, a more flexible 
>approach is necessary.  An approach that would allow the end-User the 
>freedom to adjust the OS to the specific environment at hand.
>
>So instead of forcing a one-size fits all approach on the end-User, would not 
>exporting sched.c tunables to the procfs present a flexible approach to the 
>scheduling dilemma?
>  
>

Let me agree with Mike and Con, I understand just well enough to pretty 
much leave them alone. The swappiness is available, that's one of the 
things which wants tuning. But the old 2.2 kernels did run better on 
small machines, even a stripped 2.6 kernel is slower.

>All comments that have a vested interest in enabling Linux on the desktop are 
>most welcome, even if they describe other/better/smarter approaches.
>
>Thanks!
>
>--
>Al
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-smp" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>


-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


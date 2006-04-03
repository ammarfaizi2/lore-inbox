Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWDCXEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWDCXEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWDCXEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:04:10 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:12542 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964916AbWDCXEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:04:09 -0400
Message-ID: <4431A9E7.40406@bigpond.net.au>
Date: Tue, 04 Apr 2006 09:04:07 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com>
In-Reply-To: <200604031459.51542.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 3 Apr 2006 23:04:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Peter Williams wrote:
>>> Peter Williams wrote:
>> Now available for 2.6.16 at:
> 
> Thanks a lot!
> 
>>>> You can select a default scheduler at kernel build time.  If you wish
>>>> to boot with a scheduler other than the default it can be selected at
>>>> boot time by adding:
>>>>
>>>> cpusched=<scheduler>
> 
> Can this be made runtime selectable/loadable, akin to iosched?

See <https://sourceforge.net/projects/dynsched>.  It's an extension to 
PlugSched that allows schedulers to be changed at run time.

> 
>>>> Control parameters for the scheduler can be read/set via files in:
>>>>
>>>> /sys/cpusched/<scheduler>/
> 
> The default values for spa make it really easy to lock up the system.

Which one of the SPA schedulers and under what conditions?  I've been 
mucking around with these and may have broken something.  If so I'd like 
to fix it.

> Is there a module to autotune these values according to cpu/mem/ctxt 
> performance?
> 
> Also, different schedulers per cpu could be rather useful.

I think that would be dangerous.  However, different schedulers per 
cpuset might make sense but it involve a fair bit of work.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

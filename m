Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUJIRd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUJIRd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUJIRd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:33:27 -0400
Received: from opersys.com ([64.40.108.71]:25101 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S266758AbUJIRdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:33:25 -0400
Message-ID: <416822B7.5050206@opersys.com>
Date: Sat, 09 Oct 2004 13:41:11 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
CC: linux-kernel@vger.kernel.org,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com>
In-Reply-To: <41677E4D.1030403@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sven-Thorsten Dietrich wrote:
>     - Voluntary Preemption by Ingo Molnar
>     - IRQ thread patches by Scott Wood and Ingo Molnar
>     - BKL mutex patch by Ingo Molnar (with MV extensions)
>     - PMutex from Germany's Universitaet der Bundeswehr, Munich
>     - MontaVista mutex abstraction layer replacing spinlocks with mutexes

To the best of my understanding, this still doesn't provide deterministic
hard-real-time performance in Linux.

> There are several micro-kernel solutions available, which achieve
> the required performance, but there are two general concerns with
> such solutions:
> 
>     1. Two separate kernel environments, creating more overall
>         system complexity and application design complexity.
>     2. Legal controversy.

It's been quite a while since any of this has been true.

> In line with the above mentioned previous Kernel enhancements,
> our work is designed to be transparent to existing applications
> and drivers.

I guess you haven't taken a look at the work on RTAI/fusion lately.
Applications use the same Linux API, and get deterministic
hard-real-time response times. It's really much less complicated
to use than the above-suggested aggregate.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546


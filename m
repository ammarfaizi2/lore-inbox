Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVGQQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVGQQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVGQQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 12:29:49 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:27372 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261321AbVGQQ3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 12:29:48 -0400
Message-ID: <42DA8779.3020005@stud.feec.vutbr.cz>
Date: Sun, 17 Jul 2005 18:29:45 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: rt-preempt and x86_64?
References: <200507171346.11377.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507171346.11377.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> Hi Ingo,
> 
> (I searched the list for rt realtime x86_64 x86-64 before posting this, so I 
> hope it's not a duplicate).
> 
> I've noticed -31 compiles without notable error or warning on x86-64, so I 
> thought maybe it was a valid time to file a bug report about it not working.
> 
> The machine currently runs 2.6.12 but when booting with PREEMPT_RT mode on the 
> same machine I get:
> 
> init[1]: segfault at ffffffff8010e9c4 rip ffffffff8010e9c4 rsp 
> 00007fffffe28018
> [...]

Do you have latency tracing enabled in the kernel config? Try disabling 
it. It's a known problem that it doesn't work on x86_64.

Michal

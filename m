Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWBASWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWBASWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422808AbWBASWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:22:23 -0500
Received: from ws6-3.us4.outblaze.com ([205.158.62.199]:10121 "HELO
	ws6-3.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1422850AbWBASWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:22:21 -0500
Message-ID: <43E0FC55.6080503@acm.org>
Date: Wed, 01 Feb 2006 18:22:13 +0000
From: Dave Spring <dspring@acm.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0603-4, 20/01/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> running kernels with or without PREEMPT enabled.
>>
>If you don't actually *need* accelerated 3D (or if you could do
>without it for a while), switching to the "nv" driver for a few
>days/weeks would be interresting. If the crashes go away that would
>point towards the nvidia driver, if they don't go away we'll get a
>nice untainted crash report.

It's not the nv drivers - or at least not just them.
I'm getting this bug once or twice a day on a mini-ITX 
(C3 533Mhz processor) based server which doesn't even have X installed.
For me, it appeared sometime after 2.6.12.
I'm now running with gentoo 2.6.15-r1 with Hugh's recently posted patch,
and waiting 8-|

Dave Spring


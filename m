Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbUK3RAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbUK3RAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUK3Q7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:59:05 -0500
Received: from mail4.utc.com ([192.249.46.193]:9909 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262192AbUK3Q53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:57:29 -0500
Message-ID: <41ACA668.3090809@cybsft.com>
Date: Tue, 30 Nov 2004 10:57:12 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <200411292354.05995.gene.heskett@verizon.net> <41AC9121.8020001@cybsft.com> <200411301124.18628.gene.heskett@verizon.net>
In-Reply-To: <200411301124.18628.gene.heskett@verizon.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Tuesday 30 November 2004 10:26, K.R. Foley wrote:
> 
>>"<some process> is being piggy... Read missed before next interrupt"
>>
>>2) tvtime is probably running at a RT priority of 99. The IRQ
>>handler for the rtc defaults to 48-49 (I think). If you didn't
>>already do so, you should bump the priority up as in:
>>
>>chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
> 
> 
> [root@coyote root]# chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
> bash: chrt: command not found
> 
> chrt is an unknown command here. WTH?  Basicly an FC2 system.

It's part of schedutils pkg.

kr

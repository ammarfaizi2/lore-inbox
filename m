Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbUK3QYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbUK3QYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUK3QWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:22:24 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:42977 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262171AbUK3QV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:21:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
Date: Tue, 30 Nov 2004 11:24:18 -0500
User-Agent: KMail/1.7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <200411292354.05995.gene.heskett@verizon.net> <41AC9121.8020001@cybsft.com>
In-Reply-To: <41AC9121.8020001@cybsft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411301124.18628.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.57.34] at Tue, 30 Nov 2004 10:21:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 10:26, K.R. Foley wrote:
>
>"<some process> is being piggy... Read missed before next interrupt"
>
>2) tvtime is probably running at a RT priority of 99. The IRQ
> handler for the rtc defaults to 48-49 (I think). If you didn't
> already do so, you should bump the priority up as in:
>
>chrt -f -p 99 `/sbin/pidof 'IRQ 8'`

[root@coyote root]# chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
bash: chrt: command not found

chrt is an unknown command here. WTH?  Basicly an FC2 system.

>Try that and see if it helps at all.
>
>kr

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

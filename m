Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbUB0Q4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbUB0Q4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:56:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:31113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263048AbUB0Q4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:56:37 -0500
Message-Id: <200402271656.i1RGuME16838@mail.osdl.org>
Date: Fri, 27 Feb 2004 08:56:17 -0800 (PST)
From: markw@osdl.org
Subject: Re: AS performance with reiser4 on 2.6.3
To: Nikita@Namesys.COM
cc: piggin@cyberone.com.au, reiserfs-list@Namesys.COM,
       linux-kernel@vger.kernel.org
In-Reply-To: <16446.13520.5837.193556@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb, Nikita Danilov wrote:
> markw@osdl.org writes:
>  > Hi Nick,
>  > 
>  > I started getting some results with dbt-2 on 2.6.3 and saw that reiser4
>  > is doing a bit worse with the AS elevator.  Although reiser4 wasn't
>  > doing well to begin with, compared to the other filesystems.  I have
>  > links to the STP results on our 4-ways and 8-ways here:
>  > 	http://developer.osdl.org/markw/fs/dbt2_stp_results.html
> 
> There were no changes between 2.6.2 and 2.6.3 that could affect reiser4
> performance, so it is not clear why numbers are so different. Probably
> results should be averaged over several runs. Also can you run test with
> 
> http://www.namesys.com/snapshots/2004.02.25/extra/e_05-proc-sleep.patch
> 
> applied? To use it turn CONFIG_PROC_SLEEP on (depends on
> CONFIG_FRAME_POINTER), and do "cat /proc/sleep" before and after test
> run.

http://khack.osdl.org/stp/288905/results/

There are a set of /proc/sleep files there from a 4-way system.

Mark

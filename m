Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWATUEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWATUEJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWATUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:04:09 -0500
Received: from relay00.pair.com ([209.68.5.9]:59400 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932122AbWATUEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:04:08 -0500
X-pair-Authenticated: 67.163.102.102
Date: Fri, 20 Jan 2006 14:04:04 -0600 (CST)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Andrew Morton <akpm@osdl.org>
cc: Anton Titov <a.titov@host.bg>, linux-kernel@vger.kernel.org
Subject: Re: OOM Killer killing whole system
In-Reply-To: <20060120041114.7f06ecd8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0601201401500.14198@turbotaz.ourhouse>
References: <1137337516.11767.50.camel@localhost> <20060120041114.7f06ecd8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Andrew Morton wrote:
>> Jan 15 06:05:09 vip 216477 pages slab
>
> It's all in slab.  800MB.
>
> I'd be suspecting a slab memory leak.  If it happens again, please take a
> copy of /proc/slabinfo, send it.
>

Andrew & Anton,
 	I've experienced slab leaking in my system lately too. The culprit 
was 1.5 million SCSI commands in the scsi command cache. I haven't had an 
opportunity to look into it further yet; I'll try to copy you guys when I 
do.

Thanks,
Chase

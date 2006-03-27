Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWC0DUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWC0DUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 22:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWC0DUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 22:20:32 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:32237 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750701AbWC0DUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 22:20:32 -0500
Message-ID: <442759FB.8090309@tlinx.org>
Date: Sun, 26 Mar 2006 19:20:27 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Block I/O Schedulers: Can they be made selectable/device? @runtime?
References: <4426377C.7000605@tlinx.org> <200603260706.k2Q76thB030947@turing-police.cc.vt.edu>
In-Reply-To: <200603260706.k2Q76thB030947@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> Hasn't been for quite some time. 
> From my /etc/rc.local:
>   
Great...the file "Documentation/as_iosched.txt"  is apparently
out of date.
> echo cfq > /sys/block/hda/queue/scheduler
> echo noop > /sys/block/hdb/queue/scheduler
>
> (hda is a real disk with ext3 partitions on it, hdb is a DVD/CD/RW that almost
> always has exactly one process reading or writing to it at a given time, so doing
> things in the order requested is just fine).
>
> Simple enough? ;)
>   
---
    Sounds fine.  I don't suppose it's too much to ask, but where should
should I have found the updated information? :-)

-l




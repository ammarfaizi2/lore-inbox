Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTHOQL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270142AbTHOQL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:11:56 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267576AbTHOQI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:08:58 -0400
X-Originating-IP: [194.85.81.178]
X-Originating-Email: [john_r_newbie@hotmail.com]
From: "John Newbie" <john_r_newbie@hotmail.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide drives performance issues, maybe related with buffer cache.
Date: Fri, 15 Aug 2003 19:39:43 +0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law14-F28uv4hh6nB2J0002797a@hotmail.com>
X-OriginalArrivalTime: 15 Aug 2003 15:39:43.0913 (UTC) FILETIME=[72F51990:01C36343]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > So question is : why when i am copying file from one HD to another (for
> > simplicity from /hda to /hdb)
> > the speed fall down ? Starting from about 27-30 MB/s (drives are in 
>UDMA-4,
> > hdparm -X68) it drops
> > down to 11-12 MB/s after 4-5s. In *indows transfer rate is almost 
>constant
> > and about 20-22 MB/s (same hardware). Why the h#ll we suck?
> > I feel that it's due to buffer cache, because when you use sync (while
> > copying) transfer rate is so small or even 0.
> > Drives are tuned with hdparm to highest transfer rates, readahead, 
>multiple
> > sector count (hdparm
> > for details).
> > Tried different filesystems, from classic ext2/3 to modern xfs/reiserfs. 
>The
> > same results.
> > Pure kernel from kernel.org (2.4.{19,20,21}), vendors kernels - all the

>How do you copy files? cp? dd? Midnight Commander? ;)
>Does it happen with SCSI?
>--
>vda

I've used cp & Midnight Commander (mc). Also when someone uploads big file 
on server through
samba, speed sometimes fall down to zero.

Have no idea about scsi, drives are IDE.

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269672AbUICKQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbUICKQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269635AbUICKN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:13:29 -0400
Received: from lucidpixels.com ([66.45.37.187]:53722 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S269676AbUICKLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:11:04 -0400
Date: Fri, 3 Sep 2004 06:11:00 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Alexander Lyamin <flx@msu.ru>
cc: bzolnier@milosz.na.pl, zam@namesys.com, linux-kernel@vger.kernel.org
Subject: Re:  A few filesystem benchmarks w/ReiserFS4 vs Other Filesystems
In-Reply-To: <20040903100812.GA32387@alias>
Message-ID: <Pine.LNX.4.61.0409030610450.29454@p500>
References: <Pine.LNX.4.61.0408271037080.15499@p500> <200408271745.41722.bzolnier@elka.pw.edu.pl>
 <20040903100812.GA32387@alias>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback.

On Fri, 3 Sep 2004, Alexander Lyamin wrote:

> Fri, Aug 27, 2004 at 05:45:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>> Execute rm -rf linux-2.6.8.1 on each file system.
>>> # -------------------------------------------------------------------- #
>>> ext2 | 10.26 sec @ 22% cpu
>>> ext3 | 10.02 sec @ 25% cpu
>>>   jfs | 26.67 sec @ 27% cpu
>>>   rs3 | 03.22 sec @ 74% cpu
>>>   rs4 | 25.58 sec @ 50% cpu <- What happened to reiserfs4 here?
>>>   xfs | 12.51 sec @ 47% cpu
>>> # -------------------------------------------------------------------- #
>>> Create a 500MB file with dd to each filesystem with 1MB blocks.
>>> # -------------------------------------------------------------------- #
>>> ext2 | 15.72 sec @ 26% cpu
>>> ext3 | 17.04 sec @ 31% cpu
>>>   jfs | 29.57 sec @ 25% cpu
>>>   rs3 | 15.21 sec @ 27% cpu
>>>   rs4 | 23.96 sec @ 23% cpu <- What happened to reiserfs4 here?
>>>   xfs | 19.07 sec @ 29% cpu
>
> Your answers somewhere in HCH's "silent semantics" thread.
>
> Basically reiserfs team aware that they do suck at file DELETES
> and OVERWRITES.  There seem to be a way to rectify this perfomance
> issues in future (dynamic repacker?). Altough i was somewhat surprised
> with this  dd file benchmark... probably Alexander Zarochentsev knows
> the answer.
> -- 
> "the liberation loophole will make it clear.."
> lex lyamin
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTIIU3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTIIU1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:27:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:39674 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264449AbTIIUZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:25:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: atapi write support? No
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <3F5E2BA4.60704@wmich.edu> <20030909195428.GQ4755@suse.de>
	<3F5E338F.2000007@wmich.edu>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Tue, 09 Sep 2003 22:24:55 +0200
In-Reply-To: <3F5E338F.2000007@wmich.edu> (Ed Sweetman's message of "Tue, 09
 Sep 2003 16:09:51 -0400")
Message-ID: <87brttemlk.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Sep 2003, Ed Sweetman wrote:

>Jens Axboe wrote: 
>> On Tue, Sep 09 2003, Ed Sweetman wrote:
> There is no other information needed.

There is...

> By use atapi write support i mean Get it to do anything besides error
> out reporting that it cant access the drive. If you can query the
> drive much less actually write anything to it using the ATAPI
> interface than that's more than i've been able to do.
> 
> for example   cdrecord dev=ATAPI:1,0,0 checkdisk

ATAPI: is most likely wrong for what you want to do. It's meant for
notebooks (PCATA or something).
If you just want to get rid of ide-scsi, you have to use dev=/dev/hdX in
cdrecord.

regards
Markus

PS: A little change in attitude towards people who are willing to help
you wouldn't be the worst idea. IMHO of course.



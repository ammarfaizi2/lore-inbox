Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288516AbSAHWg5>; Tue, 8 Jan 2002 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288518AbSAHWgs>; Tue, 8 Jan 2002 17:36:48 -0500
Received: from link.clearoption.com ([205.200.121.81]:59784 "EHLO
	CTECHjohnl.clearoption.com") by vger.kernel.org with ESMTP
	id <S288516AbSAHWgh>; Tue, 8 Jan 2002 17:36:37 -0500
Date: Tue, 8 Jan 2002 16:36:36 -0600 (CST)
From: John Lange <lists@darkcore.net>
X-X-Sender: wangster@CTECHjohnl.clearoption.com
Reply-To: lists@darkcore.net
To: linux-kernel@vger.kernel.org
Subject: Re: Why won't ext3 & 2.4.19 export the root?
In-Reply-To: <Pine.LNX.4.40.0201081603290.795-100000@CTECHjohnl.clearoption.com>
Message-ID: <Pine.LNX.4.40.0201081634550.1027-100000@CTECHjohnl.clearoption.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further to this issue, here is the output from exportfs -vr

---- snip ----

# exportfs -vr
exporting 205.x.x.x:/var/www
exporting 205.x.x.x:/
reexporting 205.x.x.x:/var/www to kernel
exporting 205.x.x.x:/ to kernel
205.x.x.x:/: Invalid argument

--- snip ---
Any help would be apreciated.

Thanks

John Lange

On Tue, 8 Jan 2002, John Lange wrote:

> I recently upgraded my kernel from 2.4.9 to 2.4.19 and at the same time
> started using ext3.
>
> Since that change, I can no longer export and/or mount the "/" of this
> machine for backup purposes. This is a significant problem since remotely
> mounting the file system is our primary (only) way of backing up several
> of our production machines.
>
> Exporting and mounting other than the root works normally.
>
> Here is the /etc/exports for reference.
>
> /            205.x.x.x(ro,no_root_squash)
> /var/www     205.x.x.x(ro,no_root_squash)
>
> I've googled and searched the mailing list archives but didn't find any
> mention of this.
>
> Can someone please tell me what I need to change in order to export the
> root?
>
> Thanks.
>
> John Lange
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


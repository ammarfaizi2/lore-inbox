Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSAWV0i>; Wed, 23 Jan 2002 16:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290118AbSAWV03>; Wed, 23 Jan 2002 16:26:29 -0500
Received: from [206.40.202.198] ([206.40.202.198]:15898 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S290113AbSAWV0K>; Wed, 23 Jan 2002 16:26:10 -0500
Date: Wed, 23 Jan 2002 13:25:01 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: ertzog <ertzog@bk.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: hot IDE change
In-Reply-To: <Pine.LNX.4.21.0201232301090.1053-100000@dial-up-2.energonet.ru>
Message-ID: <Pine.LNX.3.95.1020123130530.824B-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, ertzog wrote:

> Date: Wed, 23 Jan 2002 23:05:19 +0000 (GMT)
> From: ertzog <ertzog@bk.ru>
> To: linux-kernel@vger.kernel.org
> Subject: hot IDE change
> 
> This question is more about hardware, but is also related to Linux.
> If I have a harddisk, plugged into the motherboard (IDE cable and power),
> can I turn it off, plugging out first power cable, then IDE cable.
> Can it harm harddisk or motherboard?
> If I can do it, then will Linux detect it back, if I make this 
> operation back: i.e. plug IDE cable, then power cable.
> 
> Best regards.

Linux will do this fine but it wears on the south bridge mainly and the
disk secondarily. Typically the disk is the sturdier of the two.
Assuming you unmounted it first, your may get anywhere from 20 to 300+
successful removals depending on the sb chip ie how much abuse it can
endure. Then you start getting disk errors that are initially recovered
but eventually hang your box. The south bridge ide channel and possibly
the disk too, will be hosed.


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------


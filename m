Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293493AbSCFMCV>; Wed, 6 Mar 2002 07:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293498AbSCFMCJ>; Wed, 6 Mar 2002 07:02:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37127 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293493AbSCFMBz>; Wed, 6 Mar 2002 07:01:55 -0500
Message-ID: <3C8604FB.1030907@evision-ventures.com>
Date: Wed, 06 Mar 2002 13:00:59 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Ben Clifford <benc@hawaga.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj3 - ide_modes.h
In-Reply-To: <20020306034355.A30476@suse.de> <Pine.LNX.4.33.0203052245290.3642-100000@barbarella.hawaga.org.uk> <20020306124741.J6531@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Mar 05, 2002 at 10:53:58PM -0800, Ben Clifford wrote:
>  > in drivers/ide/ide_modes.h,
>  > typedef ... ide_pio_timings_t;
>  > is only defined #ifdef CONFIG_BLK_DEV_IDE_MODES.
>  > But it is used in ide.c without any ifdefs around it, resulting in a
>  > compile error.
>  > In 2.5.5-dj2, this block was in ide_modes.h within the same #ifdef as the
>  > typedef, but was moved by the -dj3 patch.
> 
>  It came from the 2.5.6pre2 merge. Hopefully the next round of Martins
>  patches will fix that up.

Yes I see the fault.


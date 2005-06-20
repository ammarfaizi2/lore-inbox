Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVFTTq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVFTTq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVFTTnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:43:51 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:6900 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261527AbVFTTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:43:00 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Nick Warne <nick@linicks.net>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Date: Mon, 20 Jun 2005 12:42:39 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: 2.6.12 udev hangs at boot
In-Reply-To: <200506202032.30771.nick@linicks.net>
Message-ID: <Pine.LNX.4.62.0506201242100.13723@qynat.qvtvafvgr.pbz>
References: <200506181332.25287.nick@linicks.net> <200506202000.08114.nick@linicks.net>
 <20050620192118.GA13586@suse.de> <200506202032.30771.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into the same issue last week on fedora core 3 so it's not _just_ a 
slackware problem.

David Lang

On Mon, 20 Jun 2005, Nick Warne wrote:

> Date: Mon, 20 Jun 2005 20:32:30 +0100
> From: Nick Warne <nick@linicks.net>
> To: Greg KH <gregkh@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 udev hangs at boot
> 
> On Monday 20 June 2005 20:21, Greg KH wrote:
>
>>> It appears the issue people are seeing is with Slack 10, which shipped
>>> with udev 0.26 - and I presume there was 'custom' rules Patrick had built
>>> in.
>>
>> Ick.  Hm, there's not been any updates for slack since then? (note,
>> there was no 0.26 release, there are no '.' in udev releases.)
>>
>> Any Slackware users want to pester them for updates?
>
> Remember this is Slackware 10 here I am talking about - Slackware 10.1 has
> been released since, that uses as stock udev 50.  Slackware current uses udev
> 54.  Trouble is here also, GLIBC has been updated in latest Slackware[s], so
> there is no real upgrade path for Slack 10 users other than the whole
> caboodle - which breaks a lot if you have all the latest 'other stuff' built
> from source anyway.
>
> I guess many users don't upgrade all the system like I do to find these
> problems.  This appears to be just a gotcha for old Slackware 10 users like
> me.  Sometimes you read stuff about doing an upgrade, and unless it pokes yer
> eye out with a big stick you miss it... so it is isn't a big deal as long as
> people know about it - it's an easy fix.
>
> Nick
> -- 
> "When you're chewing on life's gristle,
> Don't grumble, Give a whistle..."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

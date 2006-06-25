Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWFYK3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWFYK3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWFYK3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:29:55 -0400
Received: from tornado.reub.net ([202.89.145.182]:9138 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932322AbWFYK3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:29:54 -0400
Message-ID: <449E65A2.40601@reub.net>
Date: Sun, 25 Jun 2006 22:29:54 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2
References: <20060624061914.202fbfb5.akpm@osdl.org> <449E27F2.100@reub.net> <986ed62e0606250237w1e2f759bgdf255e407e873c4f@mail.gmail.com>
In-Reply-To: <986ed62e0606250237w1e2f759bgdf255e407e873c4f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/06/2006 9:37 p.m., Barry K. Nathan wrote:
> On 6/24/06, Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> 2.6.17-mm1 was a no-go for me due to the bustage with ReiserFS and 
>> bitmaps, even
>> the hotfix didn't seem to fix that...  :-(
> 
> Take 2.6.17-mm1, apply the hotfix, then apply this patch from 2.6.17-mm2 
> also:
> 
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/broken-out/reiserfs-reorganize-bitmap-loading-functions-fix2.patch 
> 
> 
> That should make 2.6.17-mm1's reiserfs work. (This way you can at
> least see whether your 2.6.17-mm2 bug happens under -mm1 as well.)

Thanks.  That seems to work a bit better...in fact -mm1 it seems to work just 
fine now.

The problem with Postfix and the disks shutting down is obviously new to -mm2.

Reuben

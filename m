Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUHaJIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUHaJIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUHaJIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:08:52 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:4793 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267548AbUHaJHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:07:22 -0400
Date: Tue, 31 Aug 2004 18:08:45 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 0/4][diskdump] x86-64 support
In-reply-to: <m3r7prcpvt.fsf@averell.firstfloor.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <98C48F3A1E8E11indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <m3r7prcpvt.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for comment.

On Sat, 28 Aug 2004 16:13:10 +0200, Andi Kleen wrote:

>> When I tested diskdump on x86-64 machine, I found that memory dump of
>> the following two areas failed.
>>
>> 1) 04000000 - 07ffffff
>> 2) around last two page
>>
>> Memory dump of the area 2) failed because page->flag was broken.
>
>Broken in what way? That should probably just be fixed in the core
>kernel.

page->flag around last two page is 0.
I tested on another machine and found all of page->flag is correct.
So this problem may be dependent on machine.

Regards,
Takao Indoh

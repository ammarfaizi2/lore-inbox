Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269596AbUICJkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269596AbUICJkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUICJki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:40:38 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57794 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269603AbUICJiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:38:55 -0400
Date: Fri, 03 Sep 2004 18:40:18 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 0/4][diskdump] x86-64 support
In-reply-to: <98C48F3A1E8E11indou.takao@soft.fujitsu.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <A7C4919A0601F8indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <98C48F3A1E8E11indou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 18:08:45 +0900, Takao Indoh wrote:

>>> When I tested diskdump on x86-64 machine, I found that memory dump of
>>> the following two areas failed.
>>>
>>> 1) 04000000 - 07ffffff
>>> 2) around last two page
>>>
>>> Memory dump of the area 2) failed because page->flag was broken.
>>
>>Broken in what way? That should probably just be fixed in the core
>>kernel.
>
>page->flag around last two page is 0.
>I tested on another machine and found all of page->flag is correct.
>So this problem may be dependent on machine.

page->flag of the following two page is 0...

PFN 1310719
PFN 1441791

Regards,
Takao Indoh


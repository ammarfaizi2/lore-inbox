Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUDESd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUDESd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:33:58 -0400
Received: from mailgate4.cinetic.de ([217.72.192.167]:31365 "EHLO
	mailgate4.cinetic.de") by vger.kernel.org with ESMTP
	id S263126AbUDESd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:33:57 -0400
Message-ID: <4071A601.5000402@web.de>
Date: Mon, 05 Apr 2004 20:31:29 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa1
References: <40707888.80006@web.de> <200404041859.47940.jeffpc@optonline.net> <20040405002028.GB21069@dualathlon.random>
In-Reply-To: <20040405002028.GB21069@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> That should reduce the scope of the problem, I had a look at the
> diff between rc3 and 2.6.5 final but I found nothing obvious that could
> explain your problem (yet).

It seems to be CONFIG_PREEMPT. I have compiled the 2.6.5-aa1 only without 
it and ET runs now 30min without a signal11.


Marcus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTIFH2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTIFH2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:28:45 -0400
Received: from dyn-ctb-203-221-72-243.webone.com.au ([203.221.72.243]:773 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S265209AbTIFH2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:28:43 -0400
Message-ID: <3F598C96.6040305@cyberone.com.au>
Date: Sat, 06 Sep 2003 17:28:22 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: scott_list@mischko.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Plans for better performance metrics in upcoming kernels?
References: <200309051641.44228.scott_list@mischko.com>
In-Reply-To: <200309051641.44228.scott_list@mischko.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Scott Chapman wrote:

>Hi,
>I'm wondering what the plans are for more accurate and more useful performance 
>metrics in upcoming kernels.
>
>CPU Utilization by process is apparently a known-inaccuracy.
>

This could be improved using Ingo's nanosecond scheduler patch.

>
>There are no disk I/O metrics per process.
>

This is now quite easy with per process IO contexts.

>
>CPU Queue Length doesn't appear to be available?
>

It wouldn't be difficult.

>
>Etc.
>
>Linux clearly falls behind the competition in this area. It makes it rather 
>tough to do system performance analysis on a Linux box!  :-)
>
>Is there a plan to deal with these issues?  ETA's?
>
>

Thinks are worked on depending on demand, and interest. I think a lot
of people are put of doing good kernel metrics due to lack of good
extensible userspace tools, and maybe a lack of standard ways to do the
exporting.



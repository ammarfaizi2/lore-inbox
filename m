Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTINM3M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 08:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbTINM3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 08:29:12 -0400
Received: from dyn-ctb-203-221-72-91.webone.com.au ([203.221.72.91]:61958 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262379AbTINM3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 08:29:11 -0400
Message-ID: <3F645F0A.1000104@cyberone.com.au>
Date: Sun, 14 Sep 2003 22:28:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KConfig help text not shown in 2.6.0-test5
References: <3F63197D.2000306@cyberone.com.au> <Pine.LNX.4.44.0309131720270.8124-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0309131720270.8124-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roman Zippel wrote:

>Hi,
>
>On Sat, 13 Sep 2003, Nick Piggin wrote:
>
>
>>In 2.6.0-test5, the help text for choice options (eg. processor type,
>>highmem) is not shown in either menuconfig or oldconfig. It does work
>>in gconfig, however. Don't know when it last worked.
>>
>
>Try the patch below, the main help should be with the choice. This patch 
>is only an example, someone else should verify the correct wording.
>BTW you can reach the individual help within 'make config' by appending a 
>'?' to the number (e.g. '1?').
>

What I am seeing is the help text for the whole choice thingy is used as
the help text for the individual choices. This patch doesn't fix that.
How is it supposed to work? I assume you tried it and saw what it was
doing, so am I just mistaken in how I think it should work?



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbTINXuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 19:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTINXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 19:50:24 -0400
Received: from dyn-ctb-210-9-246-130.webone.com.au ([210.9.246.130]:7172 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262059AbTINXuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 19:50:23 -0400
Message-ID: <3F64FEB7.6010008@cyberone.com.au>
Date: Mon, 15 Sep 2003 09:50:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KConfig help text not shown in 2.6.0-test5
References: <3F63197D.2000306@cyberone.com.au> <Pine.LNX.4.44.0309131720270.8124-100000@serv> <3F645F0A.1000104@cyberone.com.au> <Pine.LNX.4.44.0309141626540.19512-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0309141626540.19512-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roman Zippel wrote:

>Hi,
>
>On Sun, 14 Sep 2003, Nick Piggin wrote:
>
>
>>>BTW you can reach the individual help within 'make config' by appending a 
>>>'?' to the number (e.g. '1?').
>>>
>>What I am seeing is the help text for the whole choice thingy is used as
>>the help text for the individual choices. This patch doesn't fix that.
>>How is it supposed to work? I assume you tried it and saw what it was
>>doing, so am I just mistaken in how I think it should work?
>>
>
>Yes, it works here, what exactly did you try?
>

I got a clean 2.6.0-test5 kernel tree, applied your patch, ran make
oldconfig menuconfig, entered "processor type and features", move over
"processor family" and select help. That works fine. Enter "processor
family" and select help for "Pentium-4" and the same help text comes up.
I just thought you should see the individual help text for that item.



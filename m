Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273185AbTHKSCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273184AbTHKSCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:02:03 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:27073 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S273111AbTHKSBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:01:35 -0400
Message-ID: <3F37D9F6.6050208@colorfullife.com>
Date: Mon, 11 Aug 2003 20:01:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
References: <3F361F5E.10106@colorfullife.com> <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain> <3F37B4B7.9010108@colorfullife.com> <Pine.LNX.4.56.0308111723040.11173@localhost.localdomain> <3F37BED1.405@colorfullife.com> <Pine.LNX.4.56.0308111917170.17605@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0308111917170.17605@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>IMHO the mount-options API is quite unclean - since when do we guarantee
>-EFAULT semantics?
>  
>
I don't know - I found copy_mount_options() with similar code in 1.0.9 :-(

I agree that it's ugly as hell, but it's user space ABI.

--
    Manfred



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274530AbRJJUxP>; Wed, 10 Oct 2001 16:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274989AbRJJUxH>; Wed, 10 Oct 2001 16:53:07 -0400
Received: from zeke.inet.com ([199.171.211.198]:27896 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S274530AbRJJUwu>;
	Wed, 10 Oct 2001 16:52:50 -0400
Message-ID: <3BC4B534.65194553@inet.com>
Date: Wed, 10 Oct 2001 15:53:08 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Till Immanuel Patzschke <tip@internetwork-ag.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Q] kernel vs user memory (how to get more kernel mem)
In-Reply-To: <3BC4B011.C61C8AB2@internetwork-ag.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Till Immanuel Patzschke wrote:
> 
> Hi,
> 
> another simple (?) question - sorry for asking.  There seems to be some
> (fixed?) ratio user ./. kernel memory.  How do I change the amount of kernel
> memory.  I got a reply telling the std ratio is 3:1 - where/how do I change it?
> Thanks for the help,

Very carefully, and with architecture-specific concerns.
There are some #defines you will probably need to study:
PAGE_OFFSET
TASK_SIZE
and probably others...
in at least the ARM architecture, ioremap is also a concern with
VMALLOC_START and VMALLOC_END

Someone else may have a pat answer just to get the job done, though.

HTH,

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------

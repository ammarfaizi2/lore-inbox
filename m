Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbTCQNEC>; Mon, 17 Mar 2003 08:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbTCQNEC>; Mon, 17 Mar 2003 08:04:02 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:50442 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261363AbTCQNEB>; Mon, 17 Mar 2003 08:04:01 -0500
From: phillip@lougher.demon.co.uk
To: linux-kernel@vger.kernel.org
Cc: dan@intrago.co.uk
Subject: Re: PROBLEM: (kern.log) kernel BUG at shmem.c:486!
Date: Mon, 17 Mar 2003 13:14:55 +0000
User-Agent: Demon-WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <E18uuS7-0002KU-0X@anchor-post-33.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Searle wrote:
>
>Summary: Total system lockup due to 2.4.19 kernel crashing after: (kern.log)
>kernel BUG at shmem.c:486!
>
>Mar  7 16:13:16 censornet-halewood kernel: Neighbour tabe overflow.
>Mar  7 16:13:21 censornet-halewood kernel: NET: 445 messages suppressed.
>Mar  7 16:13:21 censornet-halewood kernel: Neighbour table overflow.
>
>Mar  7 18:44:48 censornet-halewood kernel: kernel BUG at shmem.c:486!
>Mar  7 18:44:48 censornet-halewood kernel: invalid operand: 0000

The kernel BUG at shmem.c:486 is not the real bug, you've
hit a kernel sanity check which has failed, because
something beforehand has got the kernel in an fscked state.

What are the syslog messages between 16:13 and 18:44?, i.e. how does
the system crash out?

Regards

Phillip Lougher





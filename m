Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132383AbRAIXNH>; Tue, 9 Jan 2001 18:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132522AbRAIXM5>; Tue, 9 Jan 2001 18:12:57 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:29973 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132383AbRAIXMk>; Tue, 9 Jan 2001 18:12:40 -0500
Date: Wed, 10 Jan 2001 01:19:44 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Steven_Snyder@3com.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Shared memory not enabled in 2.4.0?
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Message-ID: <Pine.LNX.4.21.0101100118230.12970-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>      # cat /proc/meminfo
>              total:    used:    free:  shared: buffers:  cached:
>      Mem:  130293760 123133952  7159808        0 30371840 15179776
                                         ^^^^^^^^^^

It means shared process memory, not shm. 

One thing to watch : PowerTweak. Seems to set the max shm segments to 0



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

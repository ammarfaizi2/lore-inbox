Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282340AbRKXBxR>; Fri, 23 Nov 2001 20:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282343AbRKXBxH>; Fri, 23 Nov 2001 20:53:07 -0500
Received: from [208.129.208.52] ([208.129.208.52]:50694 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S282340AbRKXBwy>;
	Fri, 23 Nov 2001 20:52:54 -0500
Date: Fri, 23 Nov 2001 18:01:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-smp@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <Pine.LNX.4.33.0111231220350.3988-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111231751150.1026-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Ingo Molnar wrote:

[...]

Isn't it better to expose "number" cpu masks instead of
"logical" ones ?
Right now you set the raw cpus_allowed field that is a "logical" cpu
bitmask.
By using "number" maps the user can use 0..N-1 w/out having to
know internal cpu mapping.




- Davide




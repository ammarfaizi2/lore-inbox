Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291783AbSBAO7C>; Fri, 1 Feb 2002 09:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291776AbSBAO6w>; Fri, 1 Feb 2002 09:58:52 -0500
Received: from sun.fadata.bg ([80.72.64.67]:64274 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S291791AbSBAO6k>;
	Fri, 1 Feb 2002 09:58:40 -0500
To: <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0202010958220.2111-100000@localhost.localdomain>
Date: 01 Feb 2002 16:59:58 +0200
Message-ID: <87vgdhw8lt.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> files are used. With one big file (or a few big files), the i_shared_lock
Ingo> will always bounce between CPUs wildly in read() workloads, degrading

Will there be difference between bounces of a rwlock in the radix tree
variant and the cache misses in hashed locks variant for the case of
concurrently accessed large file ?

Regards,
-velco


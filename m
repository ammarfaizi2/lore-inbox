Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291623AbSBAJME>; Fri, 1 Feb 2002 04:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291622AbSBAJLy>; Fri, 1 Feb 2002 04:11:54 -0500
Received: from sun.fadata.bg ([80.72.64.67]:13842 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S291621AbSBAJLp>;
	Fri, 1 Feb 2002 04:11:45 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: mingo@elte.hu, anton@samba.org, torvalds@transmeta.com, andrea@suse.de,
        riel@conectiva.com.br, stoffel@casc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <87u1t1ws20.fsf@fadata.bg>
	<Pine.LNX.4.33.0202011125030.5026-100000@localhost.localdomain>
	<20020201.010744.35469747.davem@redhat.com>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020201.010744.35469747.davem@redhat.com>
Date: 01 Feb 2002 11:13:08 +0200
Message-ID: <874rl1sgyj.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Ingo Molnar <mingo@elte.hu>
David>    Date: Fri, 1 Feb 2002 11:29:53 +0100 (CET)
   
David>    using read-write locks does not solve the scalability problem: the problem
David>    is the bouncing of the spinlock cacheline from CPU to CPU.

David> I so much wish more people understood this :(

Amen. From now on I'll have it on an yellow sticker on my display ;)



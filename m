Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289831AbSAWMcm>; Wed, 23 Jan 2002 07:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289833AbSAWMcc>; Wed, 23 Jan 2002 07:32:32 -0500
Received: from sun.fadata.bg ([80.72.64.67]:61444 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S289831AbSAWMcR>;
	Wed, 23 Jan 2002 07:32:17 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: manfred@colorfullife.com, masp0008@stud.uni-saarland.de,
        drobbins@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
	<20020123.034411.71089598.davem@redhat.com>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020123.034411.71089598.davem@redhat.com>
Date: 23 Jan 2002 14:32:57 +0200
Message-ID: <87wuy9b62u.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:
David> 4MB pages map the GART pages and "other stuff", ie. memory used by
David> other subsystems, user pages and whatever else.  This is the only
David> way the bug can be thus triggered for kernel mappings, which is why
David> turning off 4MB pages fixes this part.

Erm, why would the granularity of mapping matter at all ? Or, for that
matter, the very existanse of address translation ?

David> The only unresolved bit is the fact that we map these GART pages
David> cacheable into user space.  That ought to cause the problem too.

They're mapped with 4KB pages too, right ? What makes it diferent to
4KB kernel mappings ?



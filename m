Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289825AbSAWMkx>; Wed, 23 Jan 2002 07:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289837AbSAWMkd>; Wed, 23 Jan 2002 07:40:33 -0500
Received: from sun.fadata.bg ([80.72.64.67]:2053 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S289836AbSAWMk0>;
	Wed, 23 Jan 2002 07:40:26 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: manfred@colorfullife.com, masp0008@stud.uni-saarland.de,
        drobbins@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: Athlon/AGP issue update
In-Reply-To: <3C4E9291.8DA0BD7F@stud.uni-saarland.de>
	<20020123.034411.71089598.davem@redhat.com> <87wuy9b62u.fsf@fadata.bg>
	<20020123.043441.112625212.davem@redhat.com>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020123.043441.112625212.davem@redhat.com>
Date: 23 Jan 2002 14:41:09 +0200
Message-ID: <87r8ohb5p6.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Momchil Velikov <velco@fadata.bg>
David>    Date: 23 Jan 2002 14:32:57 +0200

David>    Erm, why would the granularity of mapping matter at all ?

David> Because on a TLB miss the speculative store would be cancelled.
David> With 4MB pages the TLB can hit, with 4K pages it cannot.

Yes. But there _is_ some instruction writing into the AGP memory, and
this instruction will still write there no matter what are mappings,
and it can still get speculatively executed and so on, leading to the
same result, no ?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312661AbSCZSDn>; Tue, 26 Mar 2002 13:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312616AbSCZSD0>; Tue, 26 Mar 2002 13:03:26 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32214 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312643AbSCZSDN>; Tue, 26 Mar 2002 13:03:13 -0500
Date: Tue, 26 Mar 2002 10:02:27 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <49720000.1017165747@flay>
In-Reply-To: <20020326180841.C13052@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> First, your backport is clearly broken because it will oops in
> copy_one_pte if the alloc_one_pte_map fails.

That doesn't suprise me ... I did a quick backport without staring
at the code too much, just so I could get some testing number to
see what the difference in performance would be. Arjan is doing
a proper backport to 2.4, and he obviously knows this patch far
better than I, so hopefully he'll address this ;-)

Thanks for pointing this out.

> ....

The bulk of the rest of this will take me a while to think about ;-)

Thanks,

M.

PS. The backport of the 2.5 highpte stuff works fine for me in limited
touch-testing, but I don't have it playing with the discontigmem stuff
yet, so I can't give you any numbers at the moment ...



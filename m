Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTJFTNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTJFTNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:13:38 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:59132 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262319AbTJFTNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:13:34 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Date: Mon, 6 Oct 2003 12:09:15 -0700 (PDT)
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <E1A6aWv-0000rJ-00@neptune.local>
Message-ID: <Pine.LNX.4.58.0310061207460.18256@dlang.diginsite.com>
References: <DIre.Cy.15@gated-at.bofh.it> <DIre.Cy.17@gated-at.bofh.it>
 <DIre.Cy.19@gated-at.bofh.it> <DIre.Cy.13@gated-at.bofh.it>
 <DIAQ.2Hh.5@gated-at.bofh.it> <E1A6aWv-0000rJ-00@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct, this is why most device drivers ARE derived from the kernel and
must be GPL'd.

however it is possible to write a device driver independantly and then
interface it with the kernel without making it a derived work.

David Lang

On Mon, 6 Oct 2003, Pascal Schmidt wrote:

> Date: Mon, 6 Oct 2003 20:56:25 +0200
> From: Pascal Schmidt <der.eremit@email.de>
> To: Larry McVoy <lm@bitmover.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
>
> On Mon, 06 Oct 2003 20:50:12 +0200, you wrote in linux.kernel:
>
> > That has no bearing on the legalities.  A version of the kernel can't
> > force the GPL on a driver that works with that version of the kernel
> > because you can pull that driver out and drop in another.
>
> Okay, I can see the boundary. We still have the problem that drivers
> writers have to be very careful to not copy kernel code by accident
> because the kernel changes often, which creates a temptation to look
> closely at in-tree drivers to see how they do things. And if a
> drivers writer then produces code that is essentialy the same as is
> found in the kernel, only with changed indentation and variable names,
> I think we both a agree that such a driver would be a derived work.
>
> Another problem is the fact that Linux kernel headers can contain code
> in the form of macros. If a driver uses such a header, it links kernel
> code with itself which can easily make it a derived work.
>
> --
> Ciao,
> Pascal
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130993AbRALBOL>; Thu, 11 Jan 2001 20:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRALBOB>; Thu, 11 Jan 2001 20:14:01 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:27375 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130993AbRALBNo>; Thu, 11 Jan 2001 20:13:44 -0500
Date: Fri, 12 Jan 2001 03:12:47 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
Message-ID: <20010112031247.E10035@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E14GhTf-0002CS-00@the-village.bc.nu> <17544.979218884@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <17544.979218884@ocs3.ocs-net>; from kaos@ocs.com.au on Fri, Jan 12, 2001 at 12:14:44AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 12:14:44AM +1100, Keith Owens wrote:
> >What happens when we get a loop in init order because of binding and other init
> >order conflicts?
> 
> The kernel does not support circular dependencies between providers and
> consumers.  It does not matter whether they are built into vmlinux or
> loaded as modules, there can be no loops in the directed graph of
> dependencies.  It just does not make sense.

So why don't we use sth. like depmod for these issues and get the
link order automagically (like we get module load order)?

Keith: Perhaps you could explain, why this is impossible.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

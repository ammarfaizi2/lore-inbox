Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130130AbRAKNJL>; Thu, 11 Jan 2001 08:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAKNJC>; Thu, 11 Jan 2001 08:09:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42761 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130130AbRAKNIu>; Thu, 11 Jan 2001 08:08:50 -0500
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 11 Jan 2001 13:09:13 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        linux-kernel@vger.kernel.org (List Linux-Kernel)
In-Reply-To: <17071.979217174@ocs3.ocs-net> from "Keith Owens" at Jan 11, 2001 11:46:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GhTf-0002CS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stick to one method that works for all routines, dynamic registration.
> If that imposes the occasional need for a couple of extra calls in some
> routines and for people to think about initialisation order right from
> the start then so be it, it is a small price to pay for long term
> stability and ease of maintenance.

What happens when we get a loop in init order because of binding and other init
order conflicts?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

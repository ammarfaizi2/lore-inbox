Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271185AbTHHC6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271187AbTHHC6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:58:06 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:59333 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S271185AbTHHC56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:57:58 -0400
Message-ID: <009401c35d58$47ac8660$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [Q] How can I transfer data from hard disk to PCI device'smemory
Date: Fri, 8 Aug 2003 11:53:43 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to PCI device's register, but to PCI device's SDRAM memory.

In detail after I modify kernel, I want to transfer data

from HDD controller's data register (IDE controller case)

to another PCI's SDRAM memory with the help of kernel

( I think Direct I/O(using O_DIRECT flag) )

Is this impossible?


----- Original Message -----
From: "wa moua" <wmatlus@yahoo.com>
To: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
Sent: Friday, August 08, 2003 1:19 AM
Subject: Re: [Q] How can I transfer data from hard disk to PCI
device'smemory


> Are you trying to transfer data from one PCI register
> to another PCI register? Could you please rephrase
> your problem. PCI is a bus not a system storage.
>
> --- "Cho, joon-woo" <jwc@core.kaist.ac.kr> wrote:
> > Thank you for your reply, and I am very pleasant to
> > talk with you. ^^
> >
> > But english is not mother tongue, so I am little
> > confused about your
> > sentence.
> >
> > > The O_DIRECT I/O handling
> > > needs to know about stuff like page reference
> > counts that PCI space
> > > doesn't have lots of older (and some current)
> > hardware has real problems
> > > with PCI PCI transfers.
> >
> > At above sentence, you mean that
> >
> > 'To handle O_DIRECT I/O, stuff like page reference
> > is needed.
> >
> > But some HW(expecially old HW) doesn't have PCI
> > space,
> >
> > so that it needs much additional work to add a
> > PCI-PCI transferring.'
> >
> > Do I understand right?
> >
> >
> > Please reply, thanks.
> >
> >
> >
> > > So its a non trivial project, although doable






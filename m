Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTLAA2D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTLAA2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:28:03 -0500
Received: from pop.gmx.net ([213.165.64.20]:19608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262324AbTLAA17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:27:59 -0500
Date: Mon, 1 Dec 2003 01:27:58 +0100 (MET)
From: "john smith" <john.smith77@gmx.net>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Kernel modul licensing issues
X-Priority: 3 (Normal)
X-Authenticated: #21322809
Message-ID: <21620.1070238478@www5.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred

Thanks for your reply.

You wrote:
> Wrong mailing list.
> You must find a lawyer, and he'll answer your questions.

Of course, the company I'm working for will contact their
lawyers before releasing anything for linux. The reason
because I'm asking here is to get an idea of your attitude
regarding binary kernel modules in this specific scenario
and your interpretation of the GPL in my case.
I'd be glad if we can support linux but if it's not possible
due to unclear legal interpretations of the GPL we certainly
won't.

> RCU is a patented algorithm - mention that to your lawyer.
> Your creation must not be derived from the kernel
> (because creating derived works is  an exclusive right of
> the copyright owner, and you don't have and won't 
> get a permission), and it must not infringe the RCU patents.

Thanks for this information. I guess we can live without rcu.

> You have written an algorithm module that is tightly coupled to the 
> Linux kernel, and you think it's not derived from the kernel, correct? 
> As a non-lawyer, it'd say that's wrong.

Well, the algorithm has been developped totally independent from
linux. It also works under other OS's without any adjustments apart
from alloc and locking stuff.

The fact that it receives kernel data as input IMO does not make it
tightly coupled to the linux kernel since the algorithm does not even
know or care what it receives as input (at least as far as kernel data
is concerned). It basically considers kernel data: char[]

> "Derived work" is a legal term, your lawyer might be able to figure out 
> if your combination is a derived work.

As you stated later the interpretation differs from country to country
and though I'm no lawyer (and haven't talked to one myself yet regarding
this issue) I very much doubt that the interpretation is that clear even
for a "fixed" country.

> The drivers that are more or less accepted as not-derived run on 
> multiple operating systems - e.g. the nvidia ethernet driver uses the 
> same source code for Windows and Linux, and nvlib.o works on Linux
> and FreeBSD.

Well, the same holds for the algorithm module since it simply does not
need any kernel support apart from alloc and locking (as I already 
stated). Only the frontend is different from OS to OS.

I'd appreciate it very much if you and others contribute their opinion
to this topic. Basically, I believe that if we're not allowed to release
the algorithm as binary kernel module then you'd surely find a
reason why nvidia and others in fact also infringe the GPL.

Regards,

John

-- 
Neu bei GMX: Preissenkung für MMS-Versand und FreeMMS!

Ideal für alle, die gerne MMS verschicken:
25 FreeMMS/Monat mit GMX TopMail.
http://www.gmx.net/de/cgi/produktemail

+++ GMX - die erste Adresse für Mail, Message, More! +++


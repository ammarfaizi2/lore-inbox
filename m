Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310597AbSCGXcB>; Thu, 7 Mar 2002 18:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310594AbSCGXby>; Thu, 7 Mar 2002 18:31:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310598AbSCGXbj>; Thu, 7 Mar 2002 18:31:39 -0500
Subject: Re: [PATCH] preempt-kernel on 2.4.19-pre2-ac2 bugfix
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Thu, 7 Mar 2002 23:46:17 +0000 (GMT)
Cc: rml@tech9.net (Robert Love), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020307232105.GD28141@matchmail.com> from "Mike Fedyk" at Mar 07, 2002 03:21:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j7aU-0004CX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using 2.4.19-pre2-ac2-prmpt which is only patched with:
> preempt-kernel-rml-2.4.19-pre2-ac2-3
> And it looks like the VM accounting has been messed up.

I don't support pre-empt. If you can duplicate that without pre-empt then
its interesting, but not its not implausible

> Committed AS:   366712 kB
> 
> As you can see, it says I'm using 366MB (roughly) of ram, but I'm only about
> 95mb into swap with 128mb of ram.

That is the worst case swap usage based on the current allocations made by
the system. My laptop for example isnt into swap at all but has a worst
case of about 60Mb of swap.

> Alan, do you want me to try without preempt, or do you already have any
> other reports like this?

No others, also knowing what it is actually running would be useful.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269684AbRHJP6v>; Fri, 10 Aug 2001 11:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269936AbRHJP6c>; Fri, 10 Aug 2001 11:58:32 -0400
Received: from [64.7.140.42] ([64.7.140.42]:42712 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S269684AbRHJP61>;
	Fri, 10 Aug 2001 11:58:27 -0400
Message-ID: <017801c121b5$e254f3e0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Caleb Tennis" <caleb@aei-tech.com>, <linux-kernel@vger.kernel.org>,
        <tytso@mit.edu>
In-Reply-To: <01081010190800.03758@pete.aei-tech.com>
Subject: Re: [PATCH] serial.c to support ConnectTech Blueheat PCI
Date: Fri, 10 Aug 2001 12:02:41 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Caleb Tennis" <caleb@aei-tech.com>
> My first attempt at a patch - this fix was actually supported by
ConnectTech
> but for an older version of the serial driver - this patch brings it up to
> date with changes made to the kernel since 2.2.

This patch is maintained by me; it applies to 5.05. I'm not sure how
5.05[abc] are different from vanilla 5.05 though.

The reason this patch hasn't been seen on lkml is that I prefer
to have all the serial driver patches go through Ted (T'so the
serial driver maintainer) first. He's rejected this patch once
already on the basis that it adds specific board functionality to
the driver, which he's trying to avoid. I resubmitted it Jun 27 2001
with a lengthy explanation that all boards with half duplex and slave
multiplex functionality would have to have some method of doing the
switching between the modes, and that this isn't specific to our
products. I haven't heard back from him since.

He has been working intermittently on the driver, at the time I
submitted the 485 patch in Jun I'd also done some work on his devel
tarball, as we had a customer issue to fix. I'm sure that a new
version will show up in a while.

Linus, Alan, whomever else maintains kernels: if you wish to apply
this patch regardless of Ted's opinion, please contact me.

Caleb: I appreciate the effort, thanks.

Ted: What's the news with a new version?

..Stu

--

We make multiport serial boards.
www.connecttech.com
(519) 836-1291



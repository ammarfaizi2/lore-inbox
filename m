Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSGSUQr>; Fri, 19 Jul 2002 16:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSGSUQr>; Fri, 19 Jul 2002 16:16:47 -0400
Received: from chaos.ao.net ([205.244.242.21]:50394 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S317012AbSGSUQq>;
	Fri, 19 Jul 2002 16:16:46 -0400
Message-Id: <200207192019.g6JKJjUX019858@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Subject: VM wierdness in 2.5.25
Date: Fri, 19 Jul 2002 16:19:45 -0400
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've only got 256 meg RAM in my desktop, and it's thrashing like crazy once X
and mozilla begin leaking (1-2 meg/second each way).  There's a problem,
though.  While it's thrashing, there's between 100 and 120 meg of ram used as
cache, while swapping.  Am I missing a tune-point?  Or is there another reason
that 40% of my ram is locked as disk cache?

Also, if I swapoff right now (Obviously using less RAM in real+swap) I'll
OOM any application that's got pages in swap.

Could just be /proc/meminfo is way wrong, but I have no idea.  I do know it's
way more swap-prone then late 2.4 kernels are.

CC: me, please.  I read via the archives.

--Dan


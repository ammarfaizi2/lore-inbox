Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130765AbQKXOT2>; Fri, 24 Nov 2000 09:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129145AbQKXOTV>; Fri, 24 Nov 2000 09:19:21 -0500
Received: from [204.177.156.37] ([204.177.156.37]:32968 "EHLO
        bacchus-int.veritas.com") by vger.kernel.org with ESMTP
        id <S130869AbQKXNiR>; Fri, 24 Nov 2000 08:38:17 -0500
Date: Fri, 24 Nov 2000 18:37:05 +0530 (IST)
From: V Ganesh <ganesh@veritas.com>
Message-Id: <200011241307.SAA16581@vxindia.veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [bug] set_pgdir can skip mm's
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From ganesh Fri Nov 24 18:08:15 2000

[ set_pgdir() blah blah blah ]

damn. I was looking at test9 and as usual after shooting my mouth off on l-k
I go look at test11 and find it's fixed there, at least in i386, thanks to
the vmalloc_fault: stuff in do_page_fault. but a lot of other architectures
still use the old method.

ganesh
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

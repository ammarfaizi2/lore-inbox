Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131120AbQK0OlP>; Mon, 27 Nov 2000 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131624AbQK0OlE>; Mon, 27 Nov 2000 09:41:04 -0500
Received: from main.cornernet.com ([209.98.65.1]:28689 "EHLO
        main.cornernet.com") by vger.kernel.org with ESMTP
        id <S131597AbQK0Oky>; Mon, 27 Nov 2000 09:40:54 -0500
Date: Mon, 27 Nov 2000 08:22:02 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: Keith Owens <kaos@ocs.com.au>
cc: 64738 <schwung@rumms.uni-mannheim.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bits 
In-Reply-To: <2091.975331871@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0011270820280.20724-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, that only tells you the size of a long under the compiler you used.
> If you are on an Intel IA64 (64 bit kernel) but you compile with gcc
> for ix86 (32 bit userspace) then sizeof(long) is 4.  IA64 runs both
> native and ix86 code, sizeof(any userspace field) tells you nothing
> about the kernel.

Doh. Well, it *DOES* tell you if you're running 64bit - if you're running
the 64bit compiler. :)

It was a simple check. Obviously, its not perfect. (In the cases you
pointed out, for instance, we'd report the wrong thing.)

Chad


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRHQSvd>; Fri, 17 Aug 2001 14:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270236AbRHQSvY>; Fri, 17 Aug 2001 14:51:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7547 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268924AbRHQSvS>; Fri, 17 Aug 2001 14:51:18 -0400
To: swsnyder@home.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR/DRM questions
In-Reply-To: <01081712301804.01709@mercury.snydernet.lan>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Aug 2001 12:44:21 -0600
In-Reply-To: <01081712301804.01709@mercury.snydernet.lan>
Message-ID: <m1wv42o7ay.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Snyder <swsnyder@home.com> writes:

> Hello.
> 
> 1. Is there any benefit to enabling MTRR support for systems (RedHat v7.1 / 
> kernel v2.4.9) that will never run a graphical user interface?  Usually I 
> read of MTRR-related matters in the context of GUI acceleration.  Would my 
> text-only system benefit from MTRR support?

Having the kernel know how to manipulate MTRR's is useful for things
like high performance I/O cards.  Video is just one.  However you definentily
need MTRR's setting it is o.k. to do write back caching on your memory.

> 2. The kernel doc says the DRM support is avalable for the Intel 440LX 
> chipset, but no mention is made of the 440EX.  Given that the 440EX is 
> kinda-sorta similar to the 440LX, can I assume that the EX chipset is also 
> supported?

I haven't looked.  The fact that they are close probably means it is simple
to convert the code if the code doesn't support your chip.

Eric

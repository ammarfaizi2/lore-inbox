Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267499AbTBDV4I>; Tue, 4 Feb 2003 16:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTBDV4I>; Tue, 4 Feb 2003 16:56:08 -0500
Received: from ns.suse.de ([213.95.15.193]:21767 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267499AbTBDV4H>;
	Tue, 4 Feb 2003 16:56:07 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel> <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel> <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Feb 2003 23:05:40 +0100
In-Reply-To: torvalds@transmeta.com's message of "4 Feb 2003 22:44:28 +0100"
Message-ID: <p73znpbpuq3.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:
> 
> I'd love to see a small - and fast - C compiler, and I'd be willing to
> make kernel changes to make it work with it.  

If you want small and fast use lcc.

Unfortunately it's not completely free (some weird license), doesn't
really support real inline assembly and generates rather bad code compared 
to gcc.

I'm still looking forward to Open Watcom (http://www.openwatcom.org) - 
they are near self hosting on Linux. The inline assembly is very VC++ style 
though; very different from gcc and worse you have to write it in
Intel syntax.

Another alternative would be TenDRA, but it also has no inline assembly
and it's C understanding can be only described as "fascist".

If you don't care about free software you could also use the Intel
compiler, which seems to be often faster in compile time than gcc now
and can already compile kernels.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSHDS5Y>; Sun, 4 Aug 2002 14:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSHDS5X>; Sun, 4 Aug 2002 14:57:23 -0400
Received: from jalon.able.es ([212.97.163.2]:30715 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318209AbSHDS5A>;
	Sun, 4 Aug 2002 14:57:00 -0400
Date: Sun, 4 Aug 2002 20:59:52 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE reduction, prefetch fixes and other CPU-related changes
Message-ID: <20020804185952.GC1670@junk>
References: <1028471237.1294.515.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1028471237.1294.515.camel@ldb>; from ldb@ldb.ods.org on dom, ago 04, 2002 at 16:27:16 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020804 Luca Barbieri wrote:
> This is a revised version of a patch I posted a few months ago and
> implements all the suggestions that were posted in reply and several
> other things. 
> 
> - Defines CONFIG_X86_{686,MMX{EXT,},SSE{2,},3DNOW{EXT,}}: all except
> MMXEXT are currently unused (this is the reason for splitting
> Athlon-SSE, 6x86MX and Pentium2)

You could also add the optimized memory barriers from Zwane Mwaikambo.
Take a look at:
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-jam0/22-mem-barriers.bz2


-- 
J.A. Magallon                           \                 Software is like sex:
junk.able.es                             \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.19-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))

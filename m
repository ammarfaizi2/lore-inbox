Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRBWJK2>; Fri, 23 Feb 2001 04:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRBWJKS>; Fri, 23 Feb 2001 04:10:18 -0500
Received: from jalon.able.es ([212.97.163.2]:64242 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129562AbRBWJJ7>;
	Fri, 23 Feb 2001 04:09:59 -0500
Date: Fri, 23 Feb 2001 10:09:47 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: k.hindenburg@gte.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: __buggy_fxsr_alignment error 2.4.1 and 2.4.2
Message-ID: <20010223100947.A4593@werewolf.able.es>
In-Reply-To: <20010222224322.A15511@amdk7.gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010222224322.A15511@amdk7.gte.net>; from k.hindenburg@gte.net on Fri, Feb 23, 2001 at 04:43:22 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.23 Kurt V. Hindenburg wrote:
> asm-i386:
> init/main.o(.text.init+0x63): undefined reference to `__buggy_fxsr_alignment'
> 
> I don't recall this error in 2.4.0, but it is present in 2.4.1 and was not
> fixed in 2.4.2.
> 
>  >sh scripts/ver_linux 
> -- Versions installed: (if some fields are empty or look
> -- unusual then possibly you have very old versions)
> Linux amdk7 2.4.1 #3 Sat Feb 3 18:50:44 EST 2001 i686 unknown
> Kernel modules         2.4.1
> Gnu C                  pgcc-2.95.2.1

That is not a bug. That is there intentionally to catch broken compilers
like yours.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac1 #2 SMP Fri Feb 23 02:34:42 CET 2001 i686


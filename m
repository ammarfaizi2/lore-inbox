Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311588AbSCNLMK>; Thu, 14 Mar 2002 06:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311586AbSCNLMA>; Thu, 14 Mar 2002 06:12:00 -0500
Received: from [202.135.142.196] ([202.135.142.196]:22020 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311585AbSCNLLm>; Thu, 14 Mar 2002 06:11:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: Your message of "Thu, 14 Mar 2002 00:05:41 CDT."
             <3C902FA5.5010208@mandrakesoft.com> 
Date: Thu, 14 Mar 2002 22:14:53 +1100
Message-Id: <E16lTC9-0003uL-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C902FA5.5010208@mandrakesoft.com> you write:
> Your other changes look good, but RELOC_HIDE really does belong in 
> compiler.h... and percpu.h is a particularly poor choice of destination. 

How?  compiler.h is for things which vary based on compiler versions.
It was an arbitrary and relatively crappy place to put it: I only put
it there so PPC could use it...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277317AbRKDBnt>; Sat, 3 Nov 2001 20:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277338AbRKDBnj>; Sat, 3 Nov 2001 20:43:39 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:3562 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S277317AbRKDBn1>; Sat, 3 Nov 2001 20:43:27 -0500
Date: Sun, 4 Nov 2001 10:44:08 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Message-Id: <20011104104408.0fcbaf9b.rusty@rustcorp.com.au>
In-Reply-To: <15zzDZ-0yyjQWC@fmrl02.sul.t-online.com>
In-Reply-To: <E15zF9H-0000NL-00@wagner>
	<15zeoa-0RBdnkC@fmrl04.sul.t-online.com>
	<20011103103106.7eb6098b.rusty@rustcorp.com.au>
	<15zzDZ-0yyjQWC@fmrl02.sul.t-online.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2001 12:47:08 +0100
Tim Jansen <tim@tjansen.de> wrote:
> I do see the advantages of using strings in proc, and maybe there is another 
> solution: keep the type information out of the proc filesystem and save it 
> in a file similar to Configure.help, together with a description for a file. 
> I just don't know how to ensure that they are in sync. 

The same argument applies for module parameters when they become boot parameters
(handwave reference to my previous patch).  IMHO we should use a source-strainer
like the current Documentation/DocBook/ stuff does to extract these and consolidate
them.

Cheers,
Rusty.

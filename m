Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317726AbSGKCw4>; Wed, 10 Jul 2002 22:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317728AbSGKCwz>; Wed, 10 Jul 2002 22:52:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13722 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317726AbSGKCwx>;
	Wed, 10 Jul 2002 22:52:53 -0400
Date: Wed, 10 Jul 2002 19:45:55 -0700 (PDT)
Message-Id: <20020710.194555.88475708.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: adam@yggdrasil.com, R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020711124830.26e2388b.rusty@rustcorp.com.au>
References: <200207041724.KAA06758@adam.yggdrasil.com>
	<20020711124830.26e2388b.rusty@rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Thu, 11 Jul 2002 12:48:30 +1000

   For God's sake, WHY?  Look at what you're doing to your TLB (and if you
   made IPv4 a removable module, I'll bet real money you have a bug unless
   you are *very* *very* clever).

Modules can be mapped using a large PTE mapping.
I've been meaning to do this on sparc64 for a long
time.

So this TLB argument alone is not sufficient :-)
I do concur on the "ipv4 as module is difficult to
get correct" argument however.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317746AbSGKCnB>; Wed, 10 Jul 2002 22:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317747AbSGKCnB>; Wed, 10 Jul 2002 22:43:01 -0400
Received: from [202.135.142.194] ([202.135.142.194]:64264 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317746AbSGKCnA>; Wed, 10 Jul 2002 22:43:00 -0400
Date: Thu, 11 Jul 2002 12:48:30 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
Message-Id: <20020711124830.26e2388b.rusty@rustcorp.com.au>
In-Reply-To: <200207041724.KAA06758@adam.yggdrasil.com>
References: <200207041724.KAA06758@adam.yggdrasil.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002 10:24:11 -0700
"Adam J. Richter" <adam@yggdrasil.com> wrote:
> 	The system that I am composing this email on has 1.1MB of
> modules and does not have sound drivers loaded.  It has ipv4 and a
> number of other facilities modularized that are not modules in the
> stock kernels.  Every system that I use has a configuration like this.
> With a lower per-module overhead, I would be more inclined to try to
> modularize other facilities and break up some larger modules into
> smaller ones, in the case where there is substantial code that is not
> needed for some configurations.

For God's sake, WHY?  Look at what you're doing to your TLB (and if you
made IPv4 a removable module, I'll bet real money you have a bug unless
you are *very* *very* clever).

Modules are not "free".  Sorry.
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

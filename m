Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266677AbSKHAZ6>; Thu, 7 Nov 2002 19:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266680AbSKHAZ6>; Thu, 7 Nov 2002 19:25:58 -0500
Received: from dp.samba.org ([66.70.73.150]:62946 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266677AbSKHAZ5>;
	Thu, 7 Nov 2002 19:25:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader against 2.5.46: 9/9 
In-reply-to: Your message of "Wed, 06 Nov 2002 23:43:40 +1100."
             <25206.1036586620@ocs3.intra.ocs.com.au> 
Date: Thu, 07 Nov 2002 22:08:24 +1100
Message-Id: <20021108003238.B01AD2C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <25206.1036586620@ocs3.intra.ocs.com.au> you write:
> On Tue, 05 Nov 2002 11:47:27 +1100, 
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >The new one is:
> >/* Lookup an address.  modname is set to NULL if it's in the kernel. */
> >const char *kallsyms_lookup(unsigned long addr,
> >			    unsigned long *symbolsize,
> >			    unsigned long *offset,
> >			    char **modname);
> 
> If you are going to change the interface then don't call it kallsyms.
> kallsyms and that interface were designed to kernel debugging in
> general and kdb in particular.

That explains it: I didn't think you were insane 8).  Thanks, I'll
move it to some other name which just does the "add symbols to oops"
minimum.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267069AbUBRN4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267064AbUBRN4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:56:17 -0500
Received: from dp.samba.org ([66.70.73.150]:65487 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267069AbUBRN4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:56:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1 
In-reply-to: Your message of "Wed, 18 Feb 2004 01:25:53 -0800."
             <20040218012553.1228ae34.akpm@osdl.org> 
Date: Thu, 19 Feb 2004 00:42:30 +1100
Message-Id: <20040218135623.112C92C3B8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040218012553.1228ae34.akpm@osdl.org> you write:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Andrew Morton <akpm@osdl.org> wrote:
> >  >
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.
3-mm1/
> > 
> >  oops, it appears that rmmod hangs in D state all the time.  
> 
> Fixes:

[ snip obviously correct fixes ]

Yes.  My bad: I forwarded a replacement kthread implementation to you
and missed the other subs.  It was 1am on a Monday morning, but
nonetheless.

Do you want me to consolidate the patches in your tree?  At the moment
you're carrying:

kthread-primitive.patch
kthread-affinity-fix.patch
kthread-affinity-fix-fix.patch
kthread-handle-non-booting-CPUs.patch
kthread-stop-using-signals.patch

Which are logically a single "kthread-without-signals" patch.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

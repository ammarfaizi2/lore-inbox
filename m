Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTEGED7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbTEGED7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:03:59 -0400
Received: from dp.samba.org ([66.70.73.150]:23431 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262813AbTEGED6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:03:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       paulus@samba.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Tue, 06 May 2003 19:41:35 MST."
             <20030507024135.GW8978@holomorphy.com> 
Date: Wed, 07 May 2003 14:15:26 +1000
Message-Id: <20030507041632.0ED6B2C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030507024135.GW8978@holomorphy.com> you write:
> On Wed, May 07, 2003 at 11:57:13AM +1000, Rusty Russell wrote:
> > Paul Mackerras points out that we could get the numa-aware allocation
> > plus "one big alloc" properties by playing with page mappings: reserve
> > 1MB of virtual address, and map more pages as required.  I didn't
> > think that we'd need that yet, though.
> 
> This is somewhat painful to do (though possible) on i386. The cost of
> task migration would increase at the very least.

You misunderstand I think.  All cpus would have the same mappings.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

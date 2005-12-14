Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVLNStK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVLNStK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVLNStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:49:10 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:26526 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964883AbVLNStI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:49:08 -0500
Subject: Re: kernel-2.6.15-rc5-rt2 - compilation error
	=?ISO-8859-1?Q?=91RWSEM=5FACTIVE=5FBIAS=92?= undeclared
From: Steven Rostedt <rostedt@goodmis.org>
To: art@usfltd.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200512141157.AA15073854@usfltd.com>
References: <200512141157.AA15073854@usfltd.com>
Content-Type: text/plain; charset=iso-8859-7
Date: Wed, 14 Dec 2005 13:49:00 -0500
Message-Id: <1134586140.13138.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:57 -0600, art wrote:
> kernel-2.6.15-rc5-rt2 - compilation error ¡RWSEM_ACTIVE_BIAS¢ undeclared
> 
> gcc version 4.0.2
> ........
>   CC      lib/kref.o
>   CC      lib/prio_tree.o
>   CC      lib/radix-tree.o
>   CC      lib/rbtree.o
>   CC      lib/rwsem.o
> lib/rwsem.c: In function ¡__rwsem_do_wake¢:
> lib/rwsem.c:57: warning: implicit declaration of function ¡rwsem_atomic_update¢

...

> lib/rwsem.c:256: warning: type defaults to ¡int¢ in declaration of ¡type name¢
> lib/rwsem.c:256: error: ¡struct rw_semaphore¢ has no member named ¡wait_lock¢
> make[1]: *** [lib/rwsem.o] Error 1
> make: *** [lib] Error 2
> 
> xboom
> 
> -

.config please.

-- Steve



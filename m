Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVC0SdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVC0SdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVC0SdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:33:04 -0500
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:21953 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261361AbVC0SdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:33:00 -0500
Date: Sun, 27 Mar 2005 11:34:50 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Robert Love <rml@tech9.net>
Subject: Re: [RFC] spinlock_t & rwlock_t break_lock member initialization
 (patch seeking comments included)
In-Reply-To: <Pine.LNX.4.62.0503271108140.2388@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0503271132470.11848@montezuma.fsmlabs.com>
References: <Pine.LNX.4.62.0503202205480.2508@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.62.0503271108140.2388@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005, Jesper Juhl wrote:

> I've now been running kernels (both PREEMPT, SMP, both and without both) 
> with the patch below applied for a few days and I see no ill effects. I'm 
> still interrested in comments about wether or not something like this 
> makes sense and is acceptable ?

The concept seems fine to me, although i think you should be using named 
initialisers instead.

Thanks Jesper,

	Zwane


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUBWSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbUBWSdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:33:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:23774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261992AbUBWSdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:33:53 -0500
Date: Mon, 23 Feb 2004 10:36:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix shmat
In-Reply-To: <403A4328.5010302@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0402231035280.3005@ppc970.osdl.org>
References: <E1AvBNO-0004QF-00@bkwatch.colorfullife.com> <403A4328.5010302@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Feb 2004, Manfred Spraul wrote:
> 
> I'd propose to remove the asmlinkage and to move the prototype (without 
> asmlinkage) back from syscalls.h to shm.h - what do you think?

Please. Maybe it might even be worth-while renaming it to "do_sys_shmat()"  
to make it clear that it's not a "sys_xxx()" at all.

		Linus

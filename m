Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUBWXcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUBWXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:32:14 -0500
Received: from dp.samba.org ([66.70.73.150]:34007 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262078AbUBWXcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:32:13 -0500
Date: Tue, 24 Feb 2004 10:29:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, torvalds@osdl.org,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix shmat
Message-ID: <20040223232928.GY5801@krispykreme>
References: <Pine.LNX.4.58.0402231035280.3005@ppc970.osdl.org> <Pine.LNX.4.44.0402232127250.13421-100000@dbl.q-ag.de> <20040223125730.18a8ed5d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223125730.18a8ed5d.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'd be inclined to leave it as sys_shmat().  It is logically a syscall, and
> the fact that everyone except mips (and ia64) sticks a multiplexer in front
> of it is a sad historical note.

I still live in hope that we break it back out into syscalls on ppc32/64
one day.

Anton

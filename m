Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSGVF0f>; Mon, 22 Jul 2002 01:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSGVF0f>; Mon, 22 Jul 2002 01:26:35 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:18615 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316223AbSGVF0e>;
	Mon, 22 Jul 2002 01:26:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu patch 1/3 
In-reply-to: Your message of "Sun, 21 Jul 2002 20:00:02 MST."
             <3D3B7532.96B78172@zip.com.au> 
Date: Mon, 22 Jul 2002 15:14:04 +1000
Message-Id: <20020722053036.5A26B419C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D3B7532.96B78172@zip.com.au> you write:
> Rusty Russell wrote:
> > 
> > Name: Export __per_cpu_offset so modules can use per-cpu data.
> 
> ie: so modules can access per-cpu data which is defined in
> vmlinux.  afaik, modules cannot define percpu.h-style per-cpu
> storage of their own, yes?
> 
> That's rather a trap.  It would be nice to ensure that any
> attempt to define per-cpu data in a module fails reliably
> at compile-time, please.

See patch 3/3.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

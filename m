Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbTAAXmu>; Wed, 1 Jan 2003 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTAAXmu>; Wed, 1 Jan 2003 18:42:50 -0500
Received: from dp.samba.org ([66.70.73.150]:31128 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265266AbTAAXmu>;
	Wed, 1 Jan 2003 18:42:50 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53 : modules_install warnings 
In-reply-to: Your message of "Tue, 31 Dec 2002 09:24:54 CDT."
             <Pine.LNX.3.96.1021231091929.10362B-100000@gatekeeper.tmr.com> 
Date: Wed, 01 Jan 2003 10:34:22 +1100
Message-Id: <20030101235118.CE55F2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1021231091929.10362B-100000@gatekeeper.tmr.com> you write:
> If they didn't work in 2.5.47, before the module change, then clearly they
> are broken on their own. If they worked until then, and especially if they
> work built-in still, I would certainly suspect that the problem is related
> to the module change.

That's the point: they use cli, sti and save_flags.  All three were
eliminated in SMP completely independently of the module changes.

Hope I'm being clearer?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

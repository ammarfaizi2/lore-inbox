Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbTABMvQ>; Thu, 2 Jan 2003 07:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTABMvQ>; Thu, 2 Jan 2003 07:51:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38150 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261847AbTABMvO>; Thu, 2 Jan 2003 07:51:14 -0500
Date: Thu, 2 Jan 2003 07:57:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53 : modules_install warnings 
In-Reply-To: <20030101235118.CE55F2C05E@lists.samba.org>
Message-ID: <Pine.LNX.3.96.1030102075543.18246D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Rusty Russell wrote:

> In message <Pine.LNX.3.96.1021231091929.10362B-100000@gatekeeper.tmr.com> you write:
> > If they didn't work in 2.5.47, before the module change, then clearly they
> > are broken on their own. If they worked until then, and especially if they
> > work built-in still, I would certainly suspect that the problem is related
> > to the module change.
> 
> That's the point: they use cli, sti and save_flags.  All three were
> eliminated in SMP completely independently of the module changes.
> 
> Hope I'm being clearer?

Okay, so there are two issues, the SMP issue noted and and changes which
might be needed to make them work as modules. Gotit, thanks.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


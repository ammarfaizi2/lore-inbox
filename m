Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbTACETa>; Thu, 2 Jan 2003 23:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbTACESj>; Thu, 2 Jan 2003 23:18:39 -0500
Received: from dp.samba.org ([66.70.73.150]:38030 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267375AbTACEST>;
	Thu, 2 Jan 2003 23:18:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53 : modules_install warnings 
In-reply-to: Your message of "Thu, 02 Jan 2003 07:57:36 CDT."
             <Pine.LNX.3.96.1030102075543.18246D-100000@gatekeeper.tmr.com> 
Date: Fri, 03 Jan 2003 10:54:36 +1100
Message-Id: <20030103042650.54E652C09B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1030102075543.18246D-100000@gatekeeper.tmr.com> you w
rite:
> On Wed, 1 Jan 2003, Rusty Russell wrote:
> 
> > That's the point: they use cli, sti and save_flags.  All three were
> > eliminated in SMP completely independently of the module changes.
> > 
> > Hope I'm being clearer?
> 
> Okay, so there are two issues, the SMP issue noted and and changes which
> might be needed to make them work as modules. Gotit, thanks.

Nope, one issue.  The SMP issue.  There is no module issue here.
These are not the droids you are looking for. 8)

A patch to deprecate those functions might be in order.  But so might
a patch to just rip them out.

Hope that buries this,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

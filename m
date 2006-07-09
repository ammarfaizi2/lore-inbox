Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWGIXiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWGIXiy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWGIXiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:38:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7838 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161222AbWGIXiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:38:54 -0400
Message-Id: <200607092338.k69NccHx006950@laptop11.inf.utfsm.cl>
To: Mike Galbraith <efault@gmx.de>
cc: Ask List <askthelist@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Runnable threads on run queue 
In-Reply-To: Message from Mike Galbraith <efault@gmx.de> 
   of "Sun, 09 Jul 2006 09:20:26 +0200." <1152429626.9711.34.camel@Homer.TheSimpsons.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sun, 09 Jul 2006 19:38:37 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 09 Jul 2006 19:38:47 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
> On Sat, 2006-07-08 at 20:18 +0000, Ask List wrote:
> > procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa

[...]

> Looking at the interrupts column, I suspect you have a network problem,
> not a scheduler problem.  Looks to me like your SpamAssasins are simply
> running out of work to do because your network traffic comes in bursts.

spamassassin acted up here some time ago. With personal training and some
messages it went to a loop and the load went through the roof. Couldn't
find a cure, plus some hundred users with large personalized rule files
were causing problems anyway, so we axed that.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513


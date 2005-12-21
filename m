Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVLUQK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVLUQK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVLUQK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:10:56 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53730 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932377AbVLUQK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:10:56 -0500
Message-Id: <200512211610.jBLGAW05003489@laptop11.inf.utfsm.cl>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Peter Williams <pwil3058@bigpond.net.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on interactive response 
In-Reply-To: Message from Kyle Moffett <mrmacman_g4@mac.com> 
   of "Wed, 21 Dec 2005 08:36:45 CDT." <962C9716-6F84-477B-8B2A-FA771C21CDE8@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Wed, 21 Dec 2005 13:10:32 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 21 Dec 2005 13:10:34 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Dec 21, 2005, at 08:21, Trond Myklebust wrote:
> > ...and if you stick in a faster server?...
> > There is _NO_ fundamental difference between NFS and a local
> > filesystem that warrants marking one as "interactive" and the other
> > as "noninteractive". What you are basically saying is that all I/O
> > should be marked as TASK_NONINTERACTIVE.

> Uhh, what part of disk/NFS/filesystem access is "interactive"?  Which
> of those sleeps directly involve responding to user-interface  events?

And if it is a user waiting for the data to display? Can't distinguish that
so easily from the compiler waiting for something to do...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

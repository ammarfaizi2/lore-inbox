Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131907AbRCZJbm>; Mon, 26 Mar 2001 04:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRCZJbe>; Mon, 26 Mar 2001 04:31:34 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:18950 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131907AbRCZJba>;
	Mon, 26 Mar 2001 04:31:30 -0500
Message-Id: <200103260440.f2Q4eGD26052@sleipnir.valparaiso.cl>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init 
In-Reply-To: Message from Jonathan Morton <chromi@cyberspace.org> 
   of "Sun, 25 Mar 2001 19:35:38 +0100." <l03130325b6e3e9bdf18e@[192.168.239.101]> 
Date: Mon, 26 Mar 2001 00:40:16 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton <chromi@cyberspace.org> said:
> I'm currently investigating the old non-overcommit patch, which (apart from
> needing manual applying to recent kernels) appears to be rather broken in a
> trivial way.  It prevents allocation if total reserved memory is greater
> than the total unallocated memory.  Let me say that again, a different way
> - it prevents memory usage from exceeding 50%...

Think fork(2).
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

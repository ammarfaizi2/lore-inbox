Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVBYL4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVBYL4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVBYL4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:56:08 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7310 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262680AbVBYL4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:56:04 -0500
Message-Id: <200502250059.j1P0xbDU006504@laptop11.inf.utfsm.cl>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf.c cleanups 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Thu, 24 Feb 2005 18:16:38 CDT." <421E6056.7010901@didntduck.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 24 Feb 2005 21:59:37 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 25 Feb 2005 08:55:37 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> said:
> - Make sprintf call vsnprintf directly
> - use INT_MAX for sprintf and vsprintf

This is the size limit on what is written. 4GiB sounds a bit extreme...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

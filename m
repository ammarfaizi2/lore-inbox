Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVHGC2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVHGC2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 22:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVHGC2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 22:28:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:24030 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750755AbVHGC2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 22:28:12 -0400
Message-Id: <200508070120.j771KVQR012940@laptop11.inf.utfsm.cl>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Any access control mechanism that allow exceptions? 
In-Reply-To: Message from Xin Zhao <uszhaoxin@gmail.com> 
   of "Sat, 06 Aug 2005 03:08:05 -0400." <4ae3c1405080600082ef440c8@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sat, 06 Aug 2005 21:20:31 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao <uszhaoxin@gmail.com> wrote:
> I want to lock down a directory to be read-only, say, /etc, for system
> security.

If root can bypass that somehow, it is useless anyway.

>           Unfortunately, some valid system tools might need to
> create/modified files like "/etc/dhclient-eth0.conf".  To avoid
> disrupting the normal running of those tools, I might have to allow
> certain files to be created under /etc.

Use standard permissions, or make affected files inmutable.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

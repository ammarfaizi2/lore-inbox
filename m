Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUDYELw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUDYELw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 00:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUDYELv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 00:11:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50629 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262906AbUDYELA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 00:11:00 -0400
Message-Id: <200404240128.i3O1SrlP002787@pincoya.inf.utfsm.cl>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer 
In-Reply-To: Your message of "Fri, 23 Apr 2004 17:18:44 -0400."
             <40898834.7040803@techsource.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 23 Apr 2004 21:28:53 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> said:

[...]

> In a drive with multiple platters and therefore multiple heads, you 
> could read/write from all heads simultaneously.  Or is that how they 
> already do it?

No. Current disks have bad blocks (way too small on disk to be able to
ensure 100% OK), and they are remapped by the drive firmware to spare
cilinders. To have the exact same blocks broken on each surface would be a
real lottery.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

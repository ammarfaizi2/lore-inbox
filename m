Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbUDYEL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUDYEL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 00:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDYEL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 00:11:57 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50629 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262914AbUDYELN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 00:11:13 -0400
Message-Id: <200404240118.i3O1IuZt002673@pincoya.inf.utfsm.cl>
To: root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer 
In-Reply-To: Your message of "Fri, 23 Apr 2004 16:34:21 -0400."
             <Pine.LNX.4.53.0404231624010.1352@chaos> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 23 Apr 2004 21:18:56 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:

[...]

> If you want to have fast disks, then you should do what I
> suggested to Digital 20 years ago when they had ST-506
> interfaces and SCSI was available only from third-parties.
> It was called "striping" (I'm serious!). Not the so-called
> RAID crap that took the original idea and destroyed it.
> If you have 32-bits, you design an interface board for 32
> disks. The interface board strips each bit to the data that
> each disk gets. That makes the whole array 32 times faster
> than a single drive and, of course, 32 times larger.

But seeks are just as slow as before... and weigh in more as sectors are
shorter (for the same visible sector size, 1/32th). I'm not so sure this is
a win overall.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

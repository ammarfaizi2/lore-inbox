Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136264AbRDVSrs>; Sun, 22 Apr 2001 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136268AbRDVSr3>; Sun, 22 Apr 2001 14:47:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5905 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136265AbRDVSrV>; Sun, 22 Apr 2001 14:47:21 -0400
Subject: Re: Linux 2.4.3-ac12
To: manuel@mclure.org (Manuel McLure)
Date: Sun, 22 Apr 2001 19:48:30 +0100 (BST)
Cc: johnc@damncats.org (John Cavan), linux-kernel@vger.kernel.org
In-Reply-To: <20010422100738.A7557@ulthar.internal.mclure.org> from "Manuel McLure" at Apr 22, 2001 10:07:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rOuO-0006LH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Using /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o
> > /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
> > symbol rwsem_up_write_wake
> > /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
> > symbol rwsem_down_write_failed
> 
> Same thing with tdfx.o...

"Works for me" as ever. What configuration options are you using. This sounds
like some of the code is built with each kind of semaphore.

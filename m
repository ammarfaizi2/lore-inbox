Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270658AbTHGVbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbTHGVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:31:23 -0400
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:12465
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id S270658AbTHGVbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:31:21 -0400
Date: Thu, 7 Aug 2003 22:31:20 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc1 breaks dri in X-4.3.0
In-Reply-To: <200308072215.33253.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.56.0308072228180.9722@ppg_penguin>
References: <Pine.LNX.4.56.0308072050120.9400@ppg_penguin>
 <200308072215.33253.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Marc-Christian Petersen wrote:

>
> do you have radeon.o loaded? "lsmod|grep radeon"
>
> What does dmesg say if it should autoloads the module when you start X?
> (assuming you have autoload support enabled)
>
 Looks as if it was some sort of error on my part, it's now running
nicely.  I had to [re] run depmod -a.  After a further reboot to prove
this has fixed it, radeon.o is definitely being autoloaded in startx.

Thanks anyway.

Ken
-- 





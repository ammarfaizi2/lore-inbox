Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269087AbUINLPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269087AbUINLPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUINLM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:12:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45500 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269292AbUINLKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:10:13 -0400
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914070649.GI2336@suse.de>
References: <20040914060628.GC2336@suse.de>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net>
	 <20040914070649.GI2336@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095156428.16571.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 11:07:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 08:06, Jens Axboe wrote:
> They do support it, they just don't flag the support in the capability
> flags. And of course some don't support it at all, you can try this on
> your drives if you want to know for sure.

You have data sheets to prove this ?

> It is very annoying, I agree, I don't see the need to confuse people
> with this message as well. Until that is fixed, you should be able to
> use ide2=noprobe etc on the boot command line.

This is the Probing IDE foo... That should be KERN_DEBUG or even vanish
once its had a bit of testing. No argument there


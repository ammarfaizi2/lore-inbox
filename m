Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269493AbUINQXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269493AbUINQXV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269504AbUINQNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:13:44 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:63677 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269485AbUINQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:08:51 -0400
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914152509.GA27892@suse.de>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>
	 <20040914060628.GC2336@suse.de>
	 <1095156346.16572.2.camel@localhost.localdomain>
	 <41470BBD.7060700@pobox.com>  <20040914152509.GA27892@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095174305.16988.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 16:05:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 16:25, Jens Axboe wrote:
> Alan says it's unsafe for some of his flash cards, and I do believe they
> say they have write caching enabled.

It'll crash one of the flashcards doing that and the IT8212, but neither
the flash cards nor the IT8212 are SATA so its less of a concern there.
Still wrong really though.


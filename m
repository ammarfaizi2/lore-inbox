Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269578AbUINQSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbUINQSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUINQSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:18:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3006 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269474AbUINQPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:15:55 -0400
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>,
       "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41471366.1070103@pobox.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>
	 <20040914060628.GC2336@suse.de>
	 <1095156346.16572.2.camel@localhost.localdomain>
	 <41470BBD.7060700@pobox.com> <20040914152509.GA27892@suse.de>
	 <41470F3A.1060308@rtr.ca> <414710AA.80706@rtr.ca>
	 <41471366.1070103@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095174382.16988.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 16:06:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 16:51, Jeff Garzik wrote:
> 	if (ata version < 4)
> 		return not-supported
> 	if (wbcache-enabled or have-flush-cache or have-flush-cache-ext)
> 		return supported
> 	return not-supported

I like Mark's approach. Its a heuristic but it feels a sane one. What we
really need to know of course is what Redmond does because thats the
standard by order of Bill.


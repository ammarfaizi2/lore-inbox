Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752214AbWJ0O0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbWJ0O0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWJ0O0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:26:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27329 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752214AbWJ0O0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:26:12 -0400
Subject: Re: [Q] ide cdrom in native mode leads to irq storm?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vasily Averin <vvs@sw.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, devel@openvz.org
In-Reply-To: <454206EE.9080206@sw.ru>
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>
	 <454206EE.9080206@sw.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Oct 2006 15:21:01 +0100
Message-Id: <1161958862.16839.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-27 am 17:17 +0400, ysgrifennodd Vasily Averin:
> Could somebody please help me to troubleshoot this issue? I've seen this issue
> on the customer nodes and would like to know how I can work-around this issue
> without any changes inside motherboard BIOS.

If its an IRQ routing triggered problem you probably can't, at least not
the IDE error. The oops wants debugging further because it shouldn't
have oopsed on that error merely given up.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWF3JsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWF3JsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWF3JsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:48:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4252 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932231AbWF3JsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:48:17 -0400
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: albertl@mail.com
Cc: matthieu castet <castet.matthieu@free.fr>, Jeff Garzik <jeff@garzik.org>,
       akpm@osdl.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
In-Reply-To: <44A4CE21.30009@tw.ibm.com>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>
	 <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org>
	 <449E5445.60008@free.fr>  <44A4CE21.30009@tw.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 11:03:23 +0100
Message-Id: <1151661803.31392.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 15:09 +0800, ysgrifennodd Albert Lee:
> If it is the problem of the specific ATAPI device, all controllers
> should be affected, not only VIA. So, strange not seeing the problem on
> Promise.

That may be because of the way the chips handle buffering of interrupt
delivery and readahead/writebehind. I have two traces on the ALi
chipsets that look like the delayed response problem.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVCKP7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVCKP7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbVCKP7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:59:36 -0500
Received: from scilla.wseurope.com ([195.110.122.96]:51380 "EHLO
	corp.wseurope.com") by vger.kernel.org with ESMTP id S261419AbVCKP5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:57:47 -0500
From: Simone Piunno <simone.piunno@wseurope.com>
Organization: Wireless Solutions
To: Jens Axboe <axboe@suse.de>
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Date: Fri, 11 Mar 2005 16:58:04 +0100
User-Agent: KMail/1.8
Cc: Fabio Coatti <fabio.coatti@wseurope.com>, Baruch Even <baruch@ev-en.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111650.07336.fabio.coatti@wseurope.com> <20050311155400.GL28188@suse.de>
In-Reply-To: <20050311155400.GL28188@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200503111658.04499.simone.piunno@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 16:54, venerdì 11 marzo 2005, Jens Axboe ha scritto:

> I'd guess that your problem is queueing, if you have a ton of pending
> requests in the hardware it will take forever to get a new request
> through. There's nothing the io scheduler can do to help you there,
> really. The /proc/driver/cciss/cciss0 you originall posted, was that
> from before or after running bonnie++? I have no latency experience with
> cciss, at least IDE/SATA/SCSI should work alright.

It was after running bonnie++.

-- 
Simone Piunno, chief architect
Wireless Solutions SPA - DADA group
Europe HQ, via Castiglione 25 Bologna
web:www.dada-ws.com tel:+39512966811 fax:+39512966800

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWJRMkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWJRMkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWJRMkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:40:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1470 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030252AbWJRMkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:40:40 -0400
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061018122323.GW23492@unthought.net>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com>
	 <1161048269.3245.26.camel@laptopd505.fenrus.org>
	 <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net>
	 <1161164456.3128.81.camel@laptopd505.fenrus.org>
	 <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk>
	 <20061018122323.GW23492@unthought.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 13:42:24 +0100
Message-Id: <1161175344.9363.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 14:23 +0200, ysgrifennodd Jakob Oestergaard:
> iops/sec is what you get from your disks. In real world scenarios. It's
> no more magic than the real world, and no harder to understand than real
> world disks. Although I admit real-world disks can be a bitch at times ;)

Even iops/sec is very vague and arbitary. If your disk happens to be
retrying a sector or doing a cleaning pass or any other housekeeping or
vibration damping and so on you'll get very different numbers.

Bandwidth is completely silly in this context, iops/sec is merely
hopeless 8)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVBURjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVBURjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVBURjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:39:46 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:24488 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262046AbVBURjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:39:45 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give
	dev=/dev/hdX as device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e0502210725520eee3@mail.gmail.com>
References: <200502152125.j1FLPSvq024249@turing-police.cc.vt.edu>
	 <200502161736.j1GHa4gX013635@turing-police.cc.vt.edu>
	 <cv36kk$54m$1@gatekeeper.tmr.com>
	 <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
	 <1108998023.15518.93.camel@localhost.localdomain>
	 <58cb370e0502210725520eee3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109007488.15518.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Feb 2005 17:38:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-02-21 at 15:25, Bartlomiej Zolnierkiewicz wrote:
> I haven't looked closely but I've noticed that these fixes are accessing rq->bio
> directly which is a layering violation.  Could you de-bio and submit them?
> [ AFAIR they are already splitted out in RHEL4 ]

Not in the near future.

> Speaking about ide-scsi, it will be undeprecated after I fix the locking.
> Rationale is that ide-scsi is _much_ simpler than ide-{cd,tape}.
> [ although it doesn't support all the hardware that ide-{cd,tape} do ]

And vice versa with ide-cd - not always for reasons I understand either.


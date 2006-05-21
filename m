Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWEUNY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWEUNY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 09:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWEUNY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 09:24:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:10476 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964867AbWEUNY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 09:24:27 -0400
Message-ID: <4579880.1148217864672.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Sun, 21 May 2006 15:24:24 +0200 (CEST)
From: Andreas Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [git patches] net driver updates
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
In-Reply-To: <447012B2.9050207@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_18)
Organization: SuSE Linux AG
References: <20060520042856.GA7218@havoc.gtf.org> <Pine.LNX.4.64.0605201035510.10823@g5.osdl.org> <20060520105547.220f2bea.akpm@osdl.org> <200605210015.15847.ak@suse.de> <447012B2.9050207@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No idea, but unlikely. The fix removes a duplicate request_irq call.
> Is
> it possible that the both instances run concurrently?

The system has two Forcedeth ports, but only one has a cable connected.
I don't think there is any parallelism. Just one connection with a lot
of data. It didn't happen with 2.6.16.

If you don't have any other good ideas I will try to track it down.

-Andi


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRL1QUR>; Fri, 28 Dec 2001 11:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRL1QUG>; Fri, 28 Dec 2001 11:20:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281772AbRL1QUA>; Fri, 28 Dec 2001 11:20:00 -0500
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Fri, 28 Dec 2001 16:29:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), srwalter@yahoo.com
In-Reply-To: <Pine.LNX.4.33.0112280918170.18421-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Dec 28, 2001 09:21:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16JztP-0000yB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> check_region/request_region cleanup. I'll try cover it and send to
> the respective maintainers... Although i reckon the hit/miss ratio will be
> a tad on the miss side ;)

For 2.5 I wouldnt bother. ALSA is the intended path and I'm simply deleting
and ignoring any 2.5 audio changes for now. Its not worth the effort trying
to fix the old OSS code up. It should have died years ago.

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130261AbRBZOeo>; Mon, 26 Feb 2001 09:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130336AbRBZObc>; Mon, 26 Feb 2001 09:31:32 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130287AbRBZO3x>;
	Mon, 26 Feb 2001 09:29:53 -0500
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Mon, 26 Feb 2001 09:26:44 +0000 (GMT)
Cc: mikeg@wen-online.de (Mike Galbraith),
        torvalds@transmeta.com (Linus Torvalds),
        spstarr@sh0n.net (Shawn Starr), linux-kernel@vger.kernel.org (lkm)
In-Reply-To: <Pine.LNX.4.21.0102260029300.4659-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Feb 26, 2001 12:42:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XJvZ-0000rF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We can add an allocation flag (__GFP_NO_CRITICAL?) which can be used by
> sg_low_malloc() (and other non critical allocations) to fail previously
> and not print the message. 

It is just for debugging. The message can go. If anytbing it would be more
useful to tack Failed alloc data on the end of /proc/slabinfo



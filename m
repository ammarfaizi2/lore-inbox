Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTA0WGS>; Mon, 27 Jan 2003 17:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbTA0WGS>; Mon, 27 Jan 2003 17:06:18 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20233 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S263366AbTA0WGR>; Mon, 27 Jan 2003 17:06:17 -0500
Date: Mon, 27 Jan 2003 17:12:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update PnP IDE (2/6)
In-Reply-To: <Pine.LNX.4.10.10301251824510.1744-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1030127170934.27928I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003, Andre Hedrick wrote:

> 
> 
> "ide_unregister" is only called if you are physically removing the
> controller.  If PNP is going to permit physical removal when the OS is
> HOT, it may be justified.  This can make a "hole" in the rest of the
> driver an generate an OOPS.  IDE-CS has alway insured the ordering was
> last.
> 
> I need to thinks some more about it first.

When I have multiple PCMCIA cards with CompactFlash cards mounted, could
this result in a hole if I umount and remove them in the wrong order? I
haven't gotten it working with 2.5, but I do mount several with 2.4, and
presumably will with 2.5 when I figure it out.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


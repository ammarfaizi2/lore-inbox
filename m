Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSJTS2L>; Sun, 20 Oct 2002 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263785AbSJTS2L>; Sun, 20 Oct 2002 14:28:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50695 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S263760AbSJTS2K>; Sun, 20 Oct 2002 14:28:10 -0400
Date: Sun, 20 Oct 2002 14:33:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: davidsen <root@tmr.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: NCR adaptor doesn't see devices (was: 2.5.43 aic7xxx segfault)
In-Reply-To: <Pine.LNX.4.44.0210191910050.7796-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.3.96.1021020143039.452A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Mr. James W. Laferriere wrote:

> 
> 	Hello Davidsen ,  I hope the Sym-2 driver is what you are using ?
> 	From the dmesg output I suspect that is not the case .  If there
> 	is only the one Symbios/LSI driver I hope it is the Sym-2
> 	version .  Hth ,  JimL

No, the sym-anything seems to be for the newer chopsets, and not the old
ncr825. I believe I tried 2.5.38 or so with that driver and it couldn't
find a device it liked. I'll try building that module again, but it didn't
work and I thought it might be causing a problem trying.

Also note that the driver inserts and fails twice (see dmesg) which is not
intuitive to me.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


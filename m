Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265478AbUAGXsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUAGXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:48:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43532 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265478AbUAGXsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:48:05 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Date: 7 Jan 2004 23:35:56 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bti54s$7sn$1@gatekeeper.tmr.com>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <20031229190327.B5729@animx.eu.org> <20031230065439.GA1517@louise.pinerecords.com> <20031230094157.A7191@animx.eu.org>
X-Trace: gatekeeper.tmr.com 1073518556 8087 192.168.12.62 (7 Jan 2004 23:35:56 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031230094157.A7191@animx.eu.org>,
Wakko Warner  <wakko@animx.eu.org> wrote:
| > > > nice about bad sectors as most hardware raid controllers.  On the other 
| > > > hand the md driver kicks the ass of nearly every raid controller I've tried.
| > > 
| > > Faster than the mylex extreme raid 2000?  or one of the higher end adaptecs?
| > 
| > Even faster than HP/Compaq cciss hwraid setups, yes.
| 
| I've personally not had any experience with any hardware raid other than the
| mylex DAC960 family.
| 
| One thing that keeps me from using the linux raid sw is the fact it can't be
| partitioned.  I thought about lvm/evms, but I'm unwilling to make an initrd to
| set it up (mounting root).  Unfortunately boot loaders don't seem to support
| anything other than raid1. (Mostly lilo, but I'm not sure grub would do this
| either)

What? You do the RAID on partitions, so you can do anything you want.
They don't aven have to be the same type RAID, I once ran fours drives
with a small 0+1 partiton (2+2) for reliability and read performance,
and a large partition of the rest of the drives RAID-5. Different stripe
size, because one array had many small reads and the other many large
reads.

You can do anything you have the guts to do, except change partition
size once you are setup.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

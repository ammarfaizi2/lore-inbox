Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265330AbSJRTgT>; Fri, 18 Oct 2002 15:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265337AbSJRTgS>; Fri, 18 Oct 2002 15:36:18 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64774 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265330AbSJRTgM>; Fri, 18 Oct 2002 15:36:12 -0400
Date: Fri, 18 Oct 2002 15:41:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] de2104x.c missing __devexit_p in 2.5.43
In-Reply-To: <3DAEF15E.4030105@pobox.com>
Message-ID: <Pine.LNX.3.96.1021018153930.23760C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Jeff Garzik wrote:

> Adam J. Richter wrote:
> > 	I believe that there are motherboards that use a chipset from
> > Compaq that allows hot plugging and unplugging of ordinary PCI cards,
> > supported by drivers in linux-2.5.43/drivers/hotplug/cpq*.[ch].  At a
> > trade show, I saw a demo of a motherboard with such a capability (not
> > running Linux, but I think from Compaq).
> 
> 
> You are correct that all PCI cards are now hotpluggable.
> 
> My position is that _my_ driver will not be converted to be hotpluggable 
> until someone actually does so.  Until such a time, I prefer the space 
> savings that keeping it non-hotplug-able provides.

If I read the original post correctly, you save a LOT of space, becasue
the driver won't link without the patch. Sorry if I misread that, and it's
desirable to avoid such a dependency, but if it's hack or forget, expect
hack.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


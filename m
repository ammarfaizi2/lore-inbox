Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTFHXKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264063AbTFHXKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:10:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25654 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264060AbTFHXKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:10:44 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306082324.h58NOHI18294@devserv.devel.redhat.com>
Subject: Re: [PATCH][RFC] Add support for Adaptec 1210SA (was: Re: SiI3112 (Adaptec 1210SA): no devices)
To: hugo-lkml@carfax.org.uk (Hugo Mills)
Date: Sun, 8 Jun 2003 19:24:17 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), sflory@rackable.com (Samuel Flory),
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andre@linux-ide.org
In-Reply-To: <20030608214504.GA5754@carfax.org.uk> from "Hugo Mills" at Meh 08, 2003 10:45:04 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its clearly clos in that it works in PIO although DMA is failing
> 
>    Given that there appear to be problems with DMA in the plain SiI
> driver, would it be worth my while waiting until those are sorted out
> before continuing?

I'll fold the patch in anyway, maybe set to pio by default

>    What would be the next steps in getting this thing working?  Should
> I try to obtain the board/chip specifications from Adaptec? Or start
> poking stuff into arbitrary registers? :)

Given it seems its an SI chip I suspect SI are the right people here
if we need to bug someone. I would be very suprised if this is anything
but an SI3112. Its expensive to fab a chip so you dont fab special ones
for people. You might print a different logo or change the PCI ID in
the external serial eeprom but no more.

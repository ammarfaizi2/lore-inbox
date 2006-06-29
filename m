Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWF2Sy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWF2Sy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWF2Sy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:54:29 -0400
Received: from smtp4.poczta.interia.pl ([80.48.65.7]:62733 "EHLO
	smtp4.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S1751266AbWF2Sy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:54:28 -0400
Message-ID: <44A421D7.7050901@interia.pl>
Date: Thu, 29 Jun 2006 20:54:15 +0200
From: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060628)
MIME-Version: 1.0
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A2C9A7.6060703@interia.pl> <1151581077.23785.9.camel@localhost.localdomain> <44A3C17F.3060204@etpmod.phys.tue.nl> <44A3DFDB.7050202@interia.pl> <44A3EEDC.30006@etpmod.phys.tue.nl>
In-Reply-To: <44A3EEDC.30006@etpmod.phys.tue.nl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-EMID: 2eef6acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe you need to do something with the cache bits in CR0 as well. It
> could be something like that. Hardware can be stuborn. I remember the
> old Winchips (C3 predecessors) hanging when trying to disable caching of
> plain ram via MCR's for instance.
> 

I did it like in chapter 10.5.3. Result is exacly the same - processor 
stops. If I set NW flag CPU is still going, but I have "exception in 
interrupt" message.
I'm starting thinking that this will not work for "Nehemiah" core.

Thanks
Rafa³


----------------------------------------------------------------------
PS. Fajny portal... >>> http://link.interia.pl/f196a


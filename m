Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272405AbTHNPWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272410AbTHNPWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:22:40 -0400
Received: from law10-f41.law10.hotmail.com ([64.4.15.41]:36613 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S272405AbTHNPWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:22:38 -0400
X-Originating-IP: [217.158.179.18]
X-Originating-Email: [allymcw2000@hotmail.com]
From: "Alasdair McWilliam" <allymcw2000@hotmail.com>
To: solca@guug.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP system
Date: Thu, 14 Aug 2003 16:22:37 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F417rkWLoLBNJ0005120b@hotmail.com>
X-OriginalArrivalTime: 14 Aug 2003 15:22:37.0596 (UTC) FILETIME=[E4CFCDC0:01C36277]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration file has never been setup for an Intel chip, it was 
originally an AMD K6-II/500MHz. I've tried reconfiguring from a brand new 
tarball for Athlon. What do I get?

depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-rc2/kernel/drivers/block/floppy.o
depmod:         _mmx_memcpy
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-rc2/kernel/drivers/block/loop.o
depmod:         _mmx_memcpy
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-rc2/kernel/drivers/cdrom/cdrom.o
depmod:         _mmx_memcpy
depmod: *** Unresolved symbols in 
/lib/modules/2.4.22-rc2/kernel/drivers/ide/ide-cd.o
depmod:         _mmx_memcpy
.....etc

Alasdair :(


>From: Otto Solares <solca@guug.org>
>To: Alasdair McWilliam <allymcw2000@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an 
>Athlon XP system
>Date: Wed, 13 Aug 2003 20:41:29 -0600
>
>On Thu, Aug 14, 2003 at 02:02:02AM +0100, Alasdair McWilliam wrote:
> > 1. PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP
> > system
>
>you must save your .config to another dir, then make mrproper,
>then move your .config to your source tree, then make normally.
>
>happens to me when i had an intel configured source tree, then
>compile for amd.
>
>-solca
>

_________________________________________________________________
Tired of 56k? Get a FREE BT Broadband connection 
http://www.msn.co.uk/specials/btbroadband


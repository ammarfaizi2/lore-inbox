Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272430AbTHNPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272432AbTHNPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:24:57 -0400
Received: from law10-f6.law10.hotmail.com ([64.4.15.6]:8208 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S272430AbTHNPYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:24:54 -0400
X-Originating-IP: [217.158.179.18]
X-Originating-Email: [allymcw2000@hotmail.com]
From: "Alasdair McWilliam" <allymcw2000@hotmail.com>
To: m.c.p@wolk-project.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP system
Date: Thu, 14 Aug 2003 16:24:52 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F6vjQN0hIQFBR0004a024@hotmail.com>
X-OriginalArrivalTime: 14 Aug 2003 15:24:52.0825 (UTC) FILETIME=[356A1C90:01C36278]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Thanks for making the patch - unfortunately it had no effect. :(

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


... etc.

Alasdair


>From: Marc-Christian Petersen <m.c.p@wolk-project.de>
>To: "Alasdair McWilliam" <allymcw2000@hotmail.com>,   
>linux-kernel@vger.kernel.org
>Subject: Re: PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an 
>Athlon XP system
>Date: Thu, 14 Aug 2003 04:46:45 +0200
>
>On Thursday 14 August 2003 03:02, Alasdair McWilliam wrote:
>
>Hi Alasdair,
>
> > 1. PROBLEM: Unresolved symbols of _mmx_memcpy in modules on an Athlon XP
> > 8. I've done research and found that people have been experiencing this
> > problem from linux-2.4.0-test releases. Can someone please fix it?! Or
> > point me to a patch that works? :( The server's running on a chunky 
>kernel
> > optimised for the old K6-II (i586).
>
>urgs, for that long? surprising :)
>
>Could you please try attached patch? Completely untested and just a guess.
>Please report success/failure. Thanks
>
>ciao, Marc
><< mmx_memcpy-fix.patch >>

_________________________________________________________________
Sign-up for a FREE BT Broadband connection today! 
http://www.msn.co.uk/specials/btbroadband


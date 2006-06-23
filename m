Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWFWRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWFWRdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWFWRdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:33:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:11939 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751809AbWFWRdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:33:11 -0400
Date: Fri, 23 Jun 2006 19:32:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
In-Reply-To: <20060622181658.GA4193@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0606231930360.26864@yvahk01.tjqt.qr>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
 <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com>
 <20060619222528.GC1648@openzaurus.ucw.cz> <Pine.LNX.4.61.0606201156080.2481@yvahk01.tjqt.qr>
 <20060622181658.GA4193@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> K6 run cooler even with the regular kernel HLT (sti/hlt I presume). 
>> Difference to full load can be up to 10 deg, depending on ambient (room) 
>> temperature. In winter (read 2005-12-31) it ran between 28 celsius and 34 
>> celsius. The fan even stopped and I thought it was a fan failure, but 
>> luckily it was just hw-controlled :)
>
>Okay, so you've got a point. The patch is useful on k6 in the winter
>:-). (Actually, to show you've got a point, you'd have to stop the fan
>and show that cpu badly overheats under for(;;) conditions).

If you spend me a new CPU, no problem :p
Maybe someone from AMD with spare K6s can try.

>Yes, we probably want to consolidate various for(;;) loops... and
>maybe it will helpsomeone. If overheating causes reboot instead of
>panic, you probably still loose, as BIOS is close to for(;;)...

The best would be to turn the machine off after, say, 60 seconds. (So you 
can grab the panic, if there is one.)


Jan Engelhardt
-- 

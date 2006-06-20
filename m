Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWFTJ6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWFTJ6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWFTJ6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:58:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:18111 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964926AbWFTJ6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:58:54 -0400
Date: Tue, 20 Jun 2006 11:58:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
In-Reply-To: <20060619222528.GC1648@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.61.0606201156080.2481@yvahk01.tjqt.qr>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
 <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com>
 <20060619222528.GC1648@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>If it happens to you... you needed a new cpu anyway. Anything non-historical
>*has* thermal protection.
>
>BTW I doubt those old athlons can be saved by cli; hlt . (Someone willing 
>to try if old
>athlon can run cli; hlt code w/o heatsink?).

K6 run cooler even with the regular kernel HLT (sti/hlt I presume). 
Difference to full load can be up to 10 deg, depending on ambient (room) 
temperature. In winter (read 2005-12-31) it ran between 28 celsius and 34 
celsius. The fan even stopped and I thought it was a fan failure, but 
luckily it was just hw-controlled :)



Jan Engelhardt
-- 

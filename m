Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272004AbTG2Tr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272012AbTG2Tr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:47:59 -0400
Received: from [66.212.224.118] ([66.212.224.118]:18192 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272004AbTG2Tr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:47:57 -0400
Date: Tue, 29 Jul 2003 15:36:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, linux-yoann@ifrance.com,
       linux-kernel@vger.kernel.org, akpm@digeo.com, vortex@scyld.com,
       jgarzik@pobox.com
Subject: Re: another must-fix: major PS/2 mouse problem
In-Reply-To: <20030729115825.5347b487.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0307291534540.31622@montezuma.mastecende.com>
References: <1054431962.22103.744.camel@cube> <3EDCF47A.1060605@ifrance.com>
 <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com>
 <1058921044.943.12.camel@cube> <20030724103047.31e91a96.akpm@osdl.org>
 <1059097601.1220.75.camel@cube> <20030725201914.644b020c.akpm@osdl.org>
 <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com>
 <1059447325.3862.86.camel@cube> <20030728201459.78c8c7c6.akpm@osdl.org>
 <1059482410.3862.120.camel@cube> <20030729115825.5347b487.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Andrew Morton wrote:

> Albert Cahalan <albert@users.sourceforge.net> wrote:
> >
> > > So this looks OK, yes?
> > 
> > I suppose boomerang_interrupt itself is OK.
> > Spending 104 ms in IRQ 0, 31 ms in IRQ 11, and
> > 44 ms in IRQ 14 is not at all OK. I was hoping
> > to get under 200 microseconds for everything.
>
> I misread that.
> 
> Last time I checked (which was about 18 months ago) the maximum
> interrupts-off time on a 500MHz desktop-class machine was 80 microseconds.

IDE has traditionally been a small headache in that department. I need to 
find out how it fares in 2.5
 

-- 
function.linuxpower.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVAEQJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVAEQJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVAEQGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:06:14 -0500
Received: from fsmlabs.com ([168.103.115.128]:39646 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262510AbVAEQEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 11:04:54 -0500
Date: Wed, 5 Jan 2005 09:05:11 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
In-Reply-To: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.61.0501050904430.6858@montezuma.fsmlabs.com>
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Martin Drab wrote:

> I'm witnessing a total freeze on my system when the APIC and LAPIC are 
> enabled in kernel 2.6.10-bk7.
> 
> The feeze seems to occur whenever there is some heavy interrupt occurance, 
> usually high network communication load, or high HDD activity. The freeze 
> does not occur after constant time during the heavy interrupt load, but it 
> ALLWAYS occurs, and allways after quite a short time. The freeze is total, 
> I mean nothing reacts, then, even the cursor on the HW text console stops 
> blinking. Only cold reset helps.
> 
> The problem disappears when I turn off APIC and LAPIC (by the "noapic 
> nolapic" commands at the kernel boot command line). I tried to turn off 
> only APIC (i.e., only "noapic"), at first it seemd to be working, but it 
> frozen anyway, only a bit later. I also tried to turn off only the LAPIC 
> (i.e.,  only "nolapic"), but then my HDD was loosing interrupts, so the 
> system didn't even boot.
> 
> I also tried the native kernel from MDK 10.1 i586, i.e. 2.6.8.1-12mdk and 
> it works without any problem with both APIC and LAPIC enabled.
> 
> Does anybody have a clue what could be wrong? 

I'm assuming that 2.6.10 is ok?


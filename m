Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVGMAL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVGMAL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVGMAL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:11:26 -0400
Received: from unused.mind.net ([69.9.134.98]:62123 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262530AbVGMAJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:09:46 -0400
Date: Tue, 12 Jul 2005 17:08:58 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Karsten Wiese <annabellesgarden@yahoo.de>
cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <200507130204.08824.annabellesgarden@yahoo.de>
Message-ID: <Pine.LNX.4.58.0507121706210.21776@echo.lysdexia.org>
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu>
 <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
 <200507130204.08824.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Karsten Wiese wrote:

> i've only tested on 2005ish Ahlon64_UP@k8T800: it doesn't need any of the quirks
>   IOAPIC_POSTFLUSH, sis_bug, level-edge cleanup.
> IOAPIC_POSTFLUSH caused no negative influence neither.
> i've an io_apic_one.c here, that doesn't have any of the quirks and is stripped down
> to handle just one ioapic. It runs just fine on PREEMPT_RT.
> Could be used as a "Do i crash/suffer without the quirks?" test for 1 ioapic equipped machines.
> Should i post it?

Please do.  I'll give it a spin on several machines and let you know how 
it goes ;-}

--ww

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265372AbTLHKnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 05:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265377AbTLHKnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 05:43:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:46766 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265372AbTLHKnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 05:43:55 -0500
Date: Mon, 8 Dec 2003 11:43:51 +0100 (MET)
Message-Id: <200312081043.hB8AhpPW009472@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, recbo@nishanet.com
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 03:13:55 -0500, Bob <recbo@nishanet.com> wrote:
>Does the kernel opt "user HPET timer" relate to io-apic-edge timer?

No. HPET is a newer piece of timer HW. IO-APIC-edge on the timer
relates to how it's connected to the CPU, not where it comes from.

>Does the kernel opt "hangcheck timer relate" to nmi_watchdog?

No.

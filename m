Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTHWVvn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263414AbTHWVvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:51:43 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:19855 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263683AbTHWVvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:51:23 -0400
Date: Sat, 23 Aug 2003 23:51:13 +0200 (MEST)
Message-Id: <200308232151.h7NLpDto000018@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@colin2.muc.de, ak@muc.de, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] physid_maskt for x86-64 was R[BUG][2.6.0-test3-bk7] x86-64 UP_IOAPIC panic caused by cpumask_t conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 02:39:29 +0200, Andi Kleen <ak@colin2.muc.de> wrote:
>This patch fixes the UP boot problem in 2.6.0test3-bk7 for me. I just ported over
>the physid_mask_t code from i386 for the IO-APIC ids. This avoids the problems
>with the boolean cpumask on UP kernels.
>
>Caveat: I only tested it with a UP kernel on a UP machine. SMP is untested.

Thanks. This fixed test3-bk7 & test4 for me.

/Mikael

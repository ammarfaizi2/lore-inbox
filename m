Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUHYRB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUHYRB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUHYRB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:01:27 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:40571 "EHLO
	mwinf0312.wanadoo.fr") by vger.kernel.org with ESMTP
	id S268134AbUHYRBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:01:24 -0400
Date: Wed, 25 Aug 2004 19:05:27 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Zarakin <zarakin@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog=2 - Oops with 2.6.8
Message-ID: <20040825170527.GB562@zaniah>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net> <20040825061248.GB556@zaniah> <16684.23372.311191.218551@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16684.23372.311191.218551@alkaid.it.uu.se>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 at 11:26 +0000, Mikael Pettersson wrote:
 
> I figured that too. Strangely enough, perfctr has been run
> successfully on two CPUID 0xF3x machines, and it didn't hit
> this problem. I have no idea why, yet. Maybe they haven't
> removed IQ_ESCR{0,1} from the Nocona?

I'm suprised too, w/o more information I'll follow strictly
the documentation.

> I don't have physical access to either a Prescott or a Nocona,
> but it it shouldn't be difficult to test. Just set up IQ_ESCR{0,1}
> with a clock-like event and see what happens.

loading oprofile driver must segfault w/o IQ_ESCR0/1 but we don't use
these MSR in oprofile so it can't be used to check if they are
functionnal on nocoma (and no HW to test it too)

regards,
Phe

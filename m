Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWIDOex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWIDOex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWIDOex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:34:53 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:33495 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751396AbWIDOew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:34:52 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: [RFT] e100 driver on ARM
References: <44FC0261.6010807@garzik.org>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 04 Sep 2006 15:34:14 +0100
In-Reply-To: <44FC0261.6010807@garzik.org> (Jeff Garzik's message of "Mon,
 04 Sep 2006 06:39:29 -0400")
Message-ID: <tnxk64jr995.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Sep 2006 14:34:16.0439 (UTC) FILETIME=[33012070:01C6D02F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
> The eepro100 removal has been blocked for almost a year by a vague
> suggestion from Russell that e100 doesn't work on ARM.  But he doesn't
> have that machine anymore.  So, we're stuck in limbo.

Russell might have tested it on an Integrator/AP (not sure
though). IIRC, I tested the e100.c driver on this platform with 2.6.12
and it was OK at that time (the platform is now discontinued by ARM
Ltd).

> 1) Does e100 driver work on ARM?

I tested the e100.c driver a few months ago on the Versatile/PB and
RealView/EB platforms with PCI backplanes attached. The driver seemed
to work well (after fixing some PCI hardware problems on our
platforms). I couldn't get the eepro100.c driver to work though, but
didn't have any reason to investigate further.

-- 
Catalin

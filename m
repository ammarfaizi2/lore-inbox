Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVDFWf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVDFWf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVDFWf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:35:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:63186 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262343AbVDFWfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:35:53 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
 accesses
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	<1112743901.9568.67.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I feel real SOPHISTICATED being in FRANCE!
Date: Thu, 07 Apr 2005 00:35:51 +0200
In-Reply-To: <1112743901.9568.67.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 06 Apr 2005 09:31:41 +1000")
Message-ID: <jeoecr1qk8.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Hrm... it should only add a few ms, maybe about 20 ms to the mode
> switching... If you remove the radeon_msleep(5) call from the
> radeon_pll_errata_after_data() routine in radeonfb.h, does it make a
> difference ?

Yes, it does.  Without the sleep, switching is as fast as before.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

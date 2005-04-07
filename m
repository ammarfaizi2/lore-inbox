Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVDGUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVDGUVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVDGUVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:21:15 -0400
Received: from ns.suse.de ([195.135.220.2]:3504 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262587AbVDGUVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:21:05 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
 accesses
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	<1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	<1112827655.9518.194.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  I want to mail a bronzed artichoke to Nicaragua!
Date: Thu, 07 Apr 2005 22:21:03 +0200
In-Reply-To: <1112827655.9518.194.camel@gaston> (Benjamin Herrenschmidt's
 message of "Thu, 07 Apr 2005 08:47:35 +1000")
Message-ID: <jehdii8hjk.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> It is weird tho. Could you try adding a printk or something to figure
> out how much this is called during a typical swich ?

There are 1694 calls to radeon_pll_errata_after_data during a switch from
X to the console and 393 calls the other way.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

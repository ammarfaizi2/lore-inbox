Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWJFAYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWJFAYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 20:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWJFAYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 20:24:38 -0400
Received: from mx1.suse.de ([195.135.220.2]:18876 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751535AbWJFAYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 20:24:37 -0400
From: Andreas Schwab <schwab@suse.de>
To: mel@skynet.ie (Mel Gorman)
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc1: known regressions
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061005042816.GD16812@stusta.de>
	<1160023503.22232.10.camel@localhost.localdomain>
	<jevemyv77c.fsf@sykes.suse.de> <20061005211506.GB28161@skynet.ie>
X-Yow: I brought my BOWLING BALL - and some DRUGS!!
Date: Fri, 06 Oct 2006 02:24:20 +0200
In-Reply-To: <20061005211506.GB28161@skynet.ie> (Mel Gorman's message of "Thu,
	5 Oct 2006 22:15:06 +0100")
Message-ID: <jek63euw97.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mel@skynet.ie (Mel Gorman) writes:

> Can you please confirm that CONFIG_HIGHMEM is set on your machine?

Yes, it is.

> If it is, can you unset it and see does it boot?

I did, and it did.

> If it boots, this patch should allow the kernel to boot with
> CONFIG_HIGHMEM.

Bingo! :-)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

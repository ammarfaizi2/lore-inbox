Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVDCN1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVDCN1o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 09:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDCN1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 09:27:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50068 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261722AbVDCN1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 09:27:42 -0400
To: Dag Arne Osvik <da@osvik.no>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
References: <424FD9BB.7040100@osvik.no>
	<20050403220508.712e14ec.sfr@canb.auug.org.au>
	<424FE1D3.9010805@osvik.no>
From: Andreas Schwab <schwab@suse.de>
X-Yow: The appreciation of the average visual graphisticator alone is worth
 the whole suaveness and decadence which abounds!!
Date: Sun, 03 Apr 2005 15:27:40 +0200
In-Reply-To: <424FE1D3.9010805@osvik.no> (Dag Arne Osvik's message of "Sun,
 03 Apr 2005 14:30:11 +0200")
Message-ID: <jezmwgxa5v.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dag Arne Osvik <da@osvik.no> writes:

> Yes, but wouldn't it be much better to avoid code like the following, 
> which may also be wrong (in terms of speed)?
>
> #ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
>  #define fast_u32 u64
> #else
>  #define fast_u32 u32
> #endif

How about using just unsigned long instead?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

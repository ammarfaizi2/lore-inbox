Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUKVQzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUKVQzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUKVQxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:53:09 -0500
Received: from news.suse.de ([195.135.220.2]:56709 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262215AbUKVQwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:52:03 -0500
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: [Lse-tech] scalability of signal delivery for Posix Threads
References: <41A20AF3.9030408@sgi.com> <20041122162214.GE21861@wotan.suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Clear the laundromat!!  This whirl-o-matic just had a nuclear
 meltdown!!
Date: Mon, 22 Nov 2004 17:51:59 +0100
In-Reply-To: <20041122162214.GE21861@wotan.suse.de> (Andi Kleen's message of
 "Mon, 22 Nov 2004 17:22:14 +0100")
Message-ID: <jept25yggg.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> At least in traditional signal semantics you have to call sigaction
> or signal in each signal handler to reset the signal. So that 
> assumption is not necessarily true.

If you use sigaction then you get POSIX semantics, which don't have this
problem.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

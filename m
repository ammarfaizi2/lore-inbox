Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967611AbWLAMbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967611AbWLAMbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967633AbWLAMbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:31:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:29098 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S967611AbWLAMbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:31:46 -0500
From: Andreas Schwab <schwab@suse.de>
To: davids@webmaster.com
Cc: <mrmacman_g4@mac.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
References: <MDEHLPKNGKAHNMBLJOLKMEDBABAC.davids@webmaster.com>
X-Yow: I was in EXCRUCIATING PAIN until I started reading JACK AND JILL
 Magazine!!
Date: Fri, 01 Dec 2006 13:31:43 +0100
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEDBABAC.davids@webmaster.com> (David
	Schwartz's message of "Fri, 1 Dec 2006 03:24:54 -0800")
Message-ID: <jehcwflrv4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> The problem is that '*(volatile unsigned int *)' results in a 'volatile
> unsigned int'.

No, it doesn't.  Values don't have qualifiers, only objects have.
Qualifiers on rvalues are meaningless.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

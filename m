Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264693AbRFQGZZ>; Sun, 17 Jun 2001 02:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264694AbRFQGZQ>; Sun, 17 Jun 2001 02:25:16 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:14076 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S264693AbRFQGZE>;
	Sun, 17 Jun 2001 02:25:04 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Longstanding APIC/NE2K bug
In-Reply-To: <20010617000645.A2022@zarq.dhs.org>
From: Jens Gecius <jens@gecius.de>
Date: 17 Jun 2001 02:25:00 -0400
In-Reply-To: <20010617000645.A2022@zarq.dhs.org> (rc@zarq.dhs.org's message of "Sun, 17 Jun 2001 00:06:45 -0400")
Message-ID: <87d783ei83.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	rc@zarq.dhs.org writes:

> There has been a bug in the 2.4.x series of kernels for a long time (at
> least -pre9) concerning SMP and ne2k-pci.
> 
> Maciej W. Rozycki posted a patch back during 2.4.0 that fixed this problem
> "[patch] 2.4.0, 2.4.0-ac12: APIC lock-ups" in late January.  I've been
> trying new kernels regularly since, and the patch doesn't seem to have
> made it in (tested 2.4.2, .3, .4 and .5).  Falling back on my patched
> 2.4.0 works fine.
> 
> Symptoms: Network driver locks up.  Repeated messages of "ETH0: Transmit
> timeout" occurs.  Unloading and reloading network drivers does not help,
> reboot is required.  Usually only triggered by heavy network traffic
> (300-400 megs at 700k or so usually does it).

This fits exactly my problems I mentioned a couple weeks ago. Same
question here. Therefore my question: can we expect to see this patch
implemented? If not, any other suggestions?

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284386AbRLRSEV>; Tue, 18 Dec 2001 13:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284415AbRLRSEL>; Tue, 18 Dec 2001 13:04:11 -0500
Received: from B55ac.pppool.de ([213.7.85.172]:33801 "HELO Nicole.fhm.edu")
	by vger.kernel.org with SMTP id <S284386AbRLRSEA>;
	Tue, 18 Dec 2001 13:04:00 -0500
Date: Tue, 18 Dec 2001 16:34:57 +0100 (CET)
From: degger@fhm.edu
Reply-To: degger@fhm.edu
Subject: Re: Scheduler ( was: Just a second ) ...
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16GKvk-0007Sc-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20011218164152.1E4835A3E@Nicole.fhm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec, Alan Cox wrote:

> The scheduler is eating 40-60% of the machine on real world 8 cpu
> workloads. That isn't going to go away by sticking heads in sand.

What about a CONFIG_8WAY which, if set, activates a scheduler that
performs better on such nontypical machines? I see and understand
boths sides arguments yet I fail to see where the real problem is
with having a scheduler that just kicks in _iff_ we're running the
kernel on a nontypical kind of machine.
This would keep the straigtforward scheduler Linus is defending
for the single processor machines while providing more performance
to heavy SMP machines by having a more complex scheduler better suited
for this task.

--
Servus,
       Daniel


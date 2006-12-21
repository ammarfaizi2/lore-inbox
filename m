Return-Path: <linux-kernel-owner+w=401wt.eu-S1422756AbWLUG2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbWLUG2W (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWLUG2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:28:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42535 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422756AbWLUG2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:28:21 -0500
Date: Wed, 20 Dec 2006 22:27:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, tglx@linutronix.de,
       mingo@elte.hu, Valdis.Kletnieks@vt.edu,
       Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH -mm 5/5][time][x86_64] Re-enable vsyscall support for
 x86_64
Message-Id: <20061220222729.aaf635c5.akpm@osdl.org>
In-Reply-To: <20061220221015.15178.16523.sendpatchset@localhost>
References: <20061220220945.15178.2669.sendpatchset@localhost>
	<20061220221015.15178.16523.sendpatchset@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 17:13:49 -0500
john stultz <johnstul@us.ibm.com> wrote:

> Cleanup and re-enable vsyscall gettimeofday using the generic 
> clocksource infrastructure.

This patch disagrees violently with the post-2.6.20-rc1-mm1
introduce-time_data-a-new-structure-to-hold-jiffies-xtime-xtime_lock-wall_to_monotonic-calc_load_count-and-avenrun.patch,
which I dropped to make way for this (sorry).




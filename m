Return-Path: <linux-kernel-owner+w=401wt.eu-S1762914AbWLKNpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762914AbWLKNpv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762917AbWLKNpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:45:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36515 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762914AbWLKNpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:45:50 -0500
Date: Mon, 11 Dec 2006 14:43:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime: vanilla 2.6.19 with 2.6.19-rt11 patch doesn't boot
Message-ID: <20061211134354.GB8219@elte.hu>
References: <200612092001.01542.o.bock@fh-wolfenbuettel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612092001.01542.o.bock@fh-wolfenbuettel.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oliver Bock <o.bock@fh-wolfenbuettel.de> wrote:

> Hi Ingo,
> 
> I tried to boot a vanilla 2.6.19 kernel with your 2.6.19-rt11 patch 
> but without success. However, the patch applied without a single error 
> and the vanilla kernel (without the patch) works fine so far. As my 
> screen just stays black and as there's no HD activity after selecting 
> the kernel in grub, I suppose that it might be related to the new 
> Areca RAID driver I use (compiled in because all my partitions reside 
> on a RAID volume) in conjunction with your patch...

do you have HPET enabled in your .config by any chance?

	Ingo

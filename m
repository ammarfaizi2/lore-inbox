Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWGZQ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWGZQ63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWGZQ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:58:29 -0400
Received: from mail.suse.de ([195.135.220.2]:8428 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932201AbWGZQ63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:58:29 -0400
From: Andi Kleen <ak@suse.de>
To: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Date: Wed, 26 Jul 2006 18:54:20 +0200
User-Agent: KMail/1.9.3
Cc: "Gulam, Nagib" <nagib.gulam@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <84EA05E2CA77634C82730353CBE3A84303218F04@SAUSEXMB1.amd.com>
In-Reply-To: <84EA05E2CA77634C82730353CBE3A84303218F04@SAUSEXMB1.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607261854.20670.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AMD Opteron(tm) Processor 838 stepping 01
> CPU 3: Syncing TSC to CPU 0.
> CPU 3: synchronized TSC with CPU 0 (last diff -109 cycles, maxerr 1024

Hmm, indeed  - i would have expected higher max errors too.
It should have worked in theory. No explanation currently.

> cycles)
> powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x6
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
> powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
> 
> Is there a better test we can be using?

I don't know of any. Ok I guess it would be possible to write
something in user space, but it would likely look similar to
the algorithm the kernel uses.

-Andi

Return-Path: <linux-kernel-owner+w=401wt.eu-S932166AbXAQJqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXAQJqI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbXAQJqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:46:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39881 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166AbXAQJqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:46:06 -0500
Date: Wed, 17 Jan 2007 10:44:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
Message-ID: <20070117094454.GB19093@elte.hu>
References: <Pine.LNX.4.44L0.0701161153200.2276-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701161153200.2276-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alan Stern <stern@rowland.harvard.edu> wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> 
> This patch (as839) implements the Kwatch (kernel-space hardware-based 
> watchpoints) API for the i386 architecture.  The API is explained in 
> the kerneldoc for register_kwatch() in arch/i386/kernel/kwatch.c.

i think it would be nice to have this ontop of Roland's utrace 
infrastructure, which nicely modularizes all hardware debugging 
capabilities and detaches it from ptrace.

	Ingo

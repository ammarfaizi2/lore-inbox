Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVF1Vnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVF1Vnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVF1Vlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:41:31 -0400
Received: from fmr19.intel.com ([134.134.136.18]:51421 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261668AbVF1Vky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:40:54 -0400
Date: Tue, 28 Jun 2005 14:40:06 -0700
From: Rusty Lynch <rusty@linux.intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recent kprobe work
Message-ID: <20050628214006.GA19157@linux.jf.intel.com>
References: <20050628.140136.57453291.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628.140136.57453291.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 02:01:36PM -0700, David S. Miller wrote:
> 
> Can the folks submitting all of the kprobe stuff at least consult me
> when they can't figure out how to implement the sparc64 kprobe variant
> for new features?
> 
> Currently, the sparc64 build is broken by recent kprobe
> changes:
> 
> kernel/built-in.o: In function `init_kprobes':
> : undefined reference to `arch_init'
> 
> Also, can we use a more namespace friendly name for this kprobe layer
> specific function other than "arch_init()"?
> 
> Thanks.

Sorry, just an oversight.  We have several arch_* functions, maybe we should
start using kprobes_arch_* instead.

    --rusty

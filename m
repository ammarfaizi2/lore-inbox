Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWHDCpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWHDCpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWHDCpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:45:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030296AbWHDCpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:45:52 -0400
Date: Thu, 3 Aug 2006 19:45:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
       john.ronciak@intel.com, auke-jan.h.kok@intel.com,
       netdev@vger.kernel.org, arjan@linux.intel.com
Subject: Re: [RFC] irqbalance: Mark in-kernel irqbalance as obsolete, set to
 N by default
Message-Id: <20060803194550.9ff31bc1.akpm@osdl.org>
In-Reply-To: <44CE3F5E.4010305@intel.com>
References: <44CE3F5E.4010305@intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 10:35:26 -0700
Auke Kok <auke-jan.h.kok@intel.com> wrote:

> We've recently seen a number of user bug reports against e1000 that the 
> in-kernel irqbalance code is detrimental to network latency. The algorithm 
> keeps swapping irq's for NICs from cpu to cpu causing extremely high network 
> latency (>1000ms).

What kernel versions?  Some IRQ balancer fixes went in shortly after 2.6.17.

It would be better if poss to fix the balancer rather than deprecating it.

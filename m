Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVKCDZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVKCDZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVKCDZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:25:38 -0500
Received: from ozlabs.org ([203.10.76.45]:62658 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030288AbVKCDZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:25:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17257.33037.210237.986072@cargo.ozlabs.ibm.com>
Date: Thu, 3 Nov 2005 14:16:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: 64K pages support
In-Reply-To: <1130916198.20136.17.camel@gaston>
References: <1130915220.20136.14.camel@gaston>
	<1130916198.20136.17.camel@gaston>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> It took a while, but finally, here is the 64K pages support patch for
> ppc64. This patch adds a new CONFIG_PPC_64K_PAGES which, when enabled,
> changes the kernel base page size to 64K. The resulting kernel still
> boots on any hardware. On current machines with 4K pages support only,
> the kernel will maintain 16 "subpages" for each 64K page
> transparently.
> 
> Note that while real 64K capable HW has been tested, the current patch
> will not enable it yet as such hardware is not released yet, and I'm
> still verifying with the firmware architects the proper to get the
> information from the newer hypervisors.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Paul Mackerras <paulus@samba.org>

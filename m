Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbULPXG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbULPXG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbULPXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:06:26 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49933 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262066AbULPXGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:06:14 -0500
Date: Thu, 16 Dec 2004 23:06:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [patch] [RFC] move 'struct page' into its own header
Message-ID: <20041216230607.B15420@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>
References: <E1Cf3jM-00034h-00@kernel.beaverton.ibm.com> <20041216222513.GA15451@infradead.org> <1103237161.13614.2388.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1103237161.13614.2388.camel@localhost>; from haveblue@us.ibm.com on Thu, Dec 16, 2004 at 02:46:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 02:46:01PM -0800, Dave Hansen wrote:
> But, I'm not quite sure why page-flags.h even needs asm/pgtable.h.  I
> just took it out in i386, and it still compiles just fine.  Maybe it is
> needed for another architecture.

Removing that include is also fine on ARM.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

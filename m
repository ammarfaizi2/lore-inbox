Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265433AbUGDHN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUGDHN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 03:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbUGDHN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 03:13:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27662 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265446AbUGDHNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 03:13:54 -0400
Date: Sun, 4 Jul 2004 08:13:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, David Mosberger <davidm@hpl.hp.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       bjorn.helgaas@hp.com, Matt Tolentino <matthew.e.tolentino@intel.com>
Subject: Re: [patch] Fix ia64 UPF_RESOURCES pcdp.c 2.6.7-mm5 build
Message-ID: <20040704081342.A29091@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Jackson <pj@sgi.com>, akpm@osdl.org,
	David Mosberger <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com,
	Matt Tolentino <matthew.e.tolentino@intel.com>
References: <20040704021907.32029.98969.47514@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040704021907.32029.98969.47514@sam.engr.sgi.com>; from pj@sgi.com on Sat, Jul 03, 2004 at 07:19:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 07:19:06PM -0700, Paul Jackson wrote:
> It looks like someone removed UPF_RESOURCES in remove-upf_resources.patch
> in parallel with someone adding drivers/firmware/pcdp.c that references
> UPF_RESOURCES.

Your patch is correct.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVERQ1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVERQ1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVERQZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:25:56 -0400
Received: from colin.muc.de ([193.149.48.1]:36878 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262334AbVERQZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:25:32 -0400
Date: 18 May 2005 18:25:28 +0200
Date: Wed, 18 May 2005 18:25:28 +0200
From: Andi Kleen <ak@muc.de>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, apw@shadowen.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 2/4] add x86-64 Kconfig options for sparsemem
Message-ID: <20050518162528.GC88141@muc.de>
References: <200505181524.j4IFOfew026909@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505181524.j4IFOfew026909@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 08:24:41AM -0700, Matt Tolentino wrote:
> 
> Add the requisite arch specific Kconfig options to enable 
> the use of the sparsemem implementation for NUMA kernels
> on x86-64.

How much did you test sparsemem on x86-64 NUMA ? 

There are various cases that probably need to be checked,
AMD with SRAT, AMD without SRAT, AMD with more than 4GB RAM, 
Summit(?), NUMA EMULATION etc.

If all that works I would have no problem with removing the
old code.

-Andi



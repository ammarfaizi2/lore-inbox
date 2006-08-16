Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWHPPfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWHPPfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHPPfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:35:13 -0400
Received: from hera.kernel.org ([140.211.167.34]:18375 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751195AbWHPPfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:35:10 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH for review] [60/145] x86_64: Move early chipset quirks out to new file
Date: Wed, 16 Aug 2006 11:36:44 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193615.80DCC13B90@wotan.suse.de>
In-Reply-To: <20060810193615.80DCC13B90@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161136.44944.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:36, Andi Kleen wrote:

> They did not really belong into io_apic.c. Move them into a new file
> and clean it up a bit.
> 
> Also remove outdated ATI quirk that was obsolete,
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/x86_64/kernel/Makefile       |    2 
>  arch/x86_64/kernel/early-quirks.c |  118 ++++++++++++++++++++++++++++++++++++++
>  arch/x86_64/kernel/io_apic.c      |  101 --------------------------------
>  arch/x86_64/kernel/setup.c        |    2 
>  include/asm-x86_64/proto.h        |    2 
>  5 files changed, 121 insertions(+), 104 deletions(-)
> 

Acked-by: Len Brown <len.brown@intel.com>

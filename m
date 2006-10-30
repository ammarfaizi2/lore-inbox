Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWJ3AFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWJ3AFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 19:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWJ3AFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 19:05:53 -0500
Received: from ozlabs.org ([203.10.76.45]:56285 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030464AbWJ3AFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 19:05:53 -0500
Subject: Re: [PATCH] Re: [PATCH 3/4] Prep for paravirt: desc.h clearer
	parameter names, some code motion
From: Rusty Russell <rusty@rustcorp.com.au>
To: Don Mullis <dwm@meer.net>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1162158259.23311.35.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
	 <1161920728.17807.39.camel@localhost.localdomain>
	 <1162152071.23311.28.camel@localhost.localdomain>
	 <200610291306.36148.ak@suse.de>
	 <1162158259.23311.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 11:05:50 +1100
Message-Id: <1162166750.9802.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 13:44 -0800, Don Mullis wrote:
> On Sun, 2006-10-29 at 13:06 -0800, Andi Kleen wrote:
> > On Sunday 29 October 2006 12:01, Don Mullis wrote:
> > > Fix build where CONFIG_CC_OPTIMIZE_FOR_SIZE is not set.
> > >
> > > Tested by build and boot.
> > 
> > What error does that fix?
> 
> The build aborts with:
> 
>   include/asm/desc.h: In function 'set_ldt':
>   include/asm/desc.h:92: error: implicit declaration of function 'write_gdt_entry'
> 
> The patch is a follow-on to my earlier reply to "[PATCH 1/4]".

Yes, I caught this immediately after I sent; I sent the fix straight to
akpm, as I didn't expect anyone else to be applying the patches.

The patch was the same as yours.

Thanks!
Rusty.



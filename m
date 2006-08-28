Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWH1IDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWH1IDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWH1IDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:03:13 -0400
Received: from mail.suse.de ([195.135.220.2]:29392 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751402AbWH1IDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:03:10 -0400
From: Andi Kleen <ak@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:03:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
References: <20060827214734.252316000@klappe.arndb.de> <200608280950.04441.ak@suse.de> <200608281001.39381.arnd@arndb.de>
In-Reply-To: <200608281001.39381.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281003.02757.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 10:01, Arnd Bergmann wrote:
> On Monday 28 August 2006 09:50, Andi Kleen wrote:
> > Or just keep the current ones that work fine? 
> > 
> 
> Are you sure they do? Since dwmw2 did the changeset 
> 56142536868a2be34f261ed8fdca1610f8a73fbd, they are all inside
> #ifdef __KERNEL__. You may argue that merging that patch was
> wrong and it should be reverted, but now that we have it, the 
> code is not relevant for user space anymore.

Thanks for brining it to my attention. I indeed think think the patch was 
wrong.

-Andi

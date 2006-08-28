Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWH1ICA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWH1ICA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWH1ICA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:02:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56525 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751271AbWH1IB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:01:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:01:38 +0200
User-Agent: KMail/1.9.1
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
References: <20060827214734.252316000@klappe.arndb.de> <200608280941.10965.arnd@arndb.de> <200608280950.04441.ak@suse.de>
In-Reply-To: <200608280950.04441.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281001.39381.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 09:50, Andi Kleen wrote:
> Or just keep the current ones that work fine? 
> 

Are you sure they do? Since dwmw2 did the changeset 
56142536868a2be34f261ed8fdca1610f8a73fbd, they are all inside
#ifdef __KERNEL__. You may argue that merging that patch was
wrong and it should be reverted, but now that we have it, the 
code is not relevant for user space anymore.

	Arnd <><

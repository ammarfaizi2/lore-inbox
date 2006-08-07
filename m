Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHGIwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHGIwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHGIwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:52:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42669 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751172AbWHGIwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:52:04 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH] Slight cleanups for x86 ring macros (against rc3-mm2)
Date: Mon, 7 Aug 2006 10:51:52 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1154925522.21647.25.camel@localhost.localdomain>
In-Reply-To: <1154925522.21647.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608071051.52727.ak@muc.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 06:38, Rusty Russell wrote:
> Clean up of patch for letting kernel run other than ring 0:
> 
> a. Add some comments about the SEGMENT_IS_*_CODE() macros.
> b. Add a USER_RPL macro.  (Code was comparing a value to a mask
>    in some places and to the magic number 3 in other places.)
> c. Add macros for table indicator field and use them.
> d. Change the entry.S tests for LDT stack segment to use the macros.

If you submit a patch that actually applies I would apply it :)

Applying patch patches/slight-cleanups-for-x86-ring-macros-against-rc3-mm2
patching file arch/i386/kernel/entry.S
Hunk #1 FAILED at 237.
Hunk #2 succeeded at 367 (offset -7 lines).
1 out of 2 hunks FAILED -- rejects in file arch/i386/kernel/entry.S
patching file include/asm-i386/ptrace.h
patch: **** malformed patch at line 52: 3);

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269788AbUJMUDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269788AbUJMUDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269789AbUJMUDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:03:49 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:64469 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269788AbUJMUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:03:38 -0400
Date: Wed, 13 Oct 2004 22:04:14 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andi Kleen <ak@suse.de>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 4level page tables for Linux
Message-ID: <20041013200414.GP17849@dualathlon.random>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost> <20041013184153.GO17849@dualathlon.random> <20041013213558.43b3236c.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013213558.43b3236c.ak@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 09:35:58PM +0200, Andi Kleen wrote:
> page mapping level 4 (?) just guessing here.

make sense.

> PML4 is the name AMD and Intel use in their documentation. I don't see 
> a particular reason to be different from them.

just because we never say 'page mapping level 4', we think 'page table
level 4' or 'page directory level 4'.

pte4 doesn't sound nice since we don't use pte3/2/1, but pgd4 could make
some more sense than pml4.

But I'm fine if you prefer to stick with pml4. Those are names we tend
to memorize anyways, I don't actually know what pmd means exactly either
(page middle directory)?

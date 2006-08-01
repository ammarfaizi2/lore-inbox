Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWHATCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWHATCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWHATCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:02:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47812 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750989AbWHATCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:02:22 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 18/33] x86_64: Kill temp_boot_pmds
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302392378-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:02:20 +0200
In-Reply-To: <11544302392378-git-send-email-ebiederm@xmission.com>
Message-ID: <p73vepc1dqb.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:
> 
> I also modify the early page table initialization code
> to use early_ioreamp and early_iounmap, instead of the
> special case version of those functions that they are
> now calling.

Ok valuable cleanup. I queued that one too.

> The only really silly part left with init_memory_mapping
> is that find_early_table_space always finds pages below 1M.

I fixed this some time ago - obsolete comment? 

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWHATEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWHATEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWHATEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:04:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:51880 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751798AbWHATEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:04:04 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 18/33] x86_64: Kill temp_boot_pmds II
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302392378-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:04:02 +0200
In-Reply-To: <11544302392378-git-send-email-ebiederm@xmission.com>
Message-ID: <p73psfk1dnh.fsf_-_@verdi.suse.de>
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

Or rather I tried to apply it - it doesn't apply at all
on its own:

patching file arch/x86_64/mm/init.c
Hunk #1 FAILED at 167.
Hunk #2 succeeded at 274 with fuzz 1 (offset 28 lines).
Hunk #3 FAILED at 286.
Hunk #4 FAILED at 341.
3 out of 4 hunks FAILED -- rejects in file arch/x86_64/mm/init.c

-Andi

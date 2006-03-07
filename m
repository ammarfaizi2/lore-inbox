Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWCGNp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWCGNp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWCGNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:45:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:25744 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751072AbWCGNp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:45:59 -0500
From: Andi Kleen <ak@suse.de>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] x86-64: Use cpumask bitops for cpu_vm_mask
Date: Tue, 7 Mar 2006 07:18:24 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <440D8C9E.2080200@didntduck.org>
In-Reply-To: <440D8C9E.2080200@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603070718.24748.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 14:37, Brian Gerst wrote:
> cpu_vm_mask is of type cpumask_t, so use the proper bitops.

Doesn't apply.

patching file arch/x86_64/kernel/smp.c
patching file include/asm-x86_64/mmu_context.h
Hunk #1 FAILED at 34.
Hunk #2 FAILED at 50.
2 out of 2 hunks FAILED -- rejects in file include/asm-x86_64/mmu_context.h

-Andi


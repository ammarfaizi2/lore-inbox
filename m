Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVJVTac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVJVTac (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJVTac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 15:30:32 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:25875 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751234AbVJVTab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 15:30:31 -0400
Date: Sat, 22 Oct 2005 15:23:01 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] mm: uml kill unused
Message-ID: <20051022192301.GA10014@ccure.user-mode-linux.org>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221725560.18047@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510221725560.18047@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 05:27:01PM +0100, Hugh Dickins wrote:
> In worrying over the various pte operations in different architectures,
> I came across some unused functions in UML: remove mprotect_kernel_vm,
> protect_vm_page and addr_pte.

NACK on the addr_pte part of this - I use this from gdb all the time when I'm
concerned with page tables.  The other two are fine.

				Jeff

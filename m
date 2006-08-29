Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbWH2UVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbWH2UVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbWH2UVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:21:45 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:19861 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965274AbWH2UVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:21:44 -0400
Date: Tue, 29 Aug 2006 16:20:20 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH 3/6] uml: arch/um remove_mapping() clash
Message-ID: <20060829202020.GB12080@ccure.user-mode-linux.org>
References: <20060825153709.24254.28118.sendpatchset@twins> <20060825153740.24254.20935.sendpatchset@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825153740.24254.20935.sendpatchset@twins>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 05:37:40PM +0200, Peter Zijlstra wrote:
> Now that 'include/linux/mm.h' includes 'include/linux/swap.h', the global
> remove_mapping() definition clashes with the arch/um one.
> 
> Rename the arch/um one.

If you tested the UML build -

Acked-by: Jeff Dike <jdike@addtoit.com>

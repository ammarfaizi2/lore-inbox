Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUF1G3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUF1G3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 02:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUF1G3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 02:29:37 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:58262 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264704AbUF1G3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 02:29:31 -0400
Date: Sun, 27 Jun 2004 23:29:12 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Anton Blanchard <anton@samba.org>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] __alloc_bootmem_node should not panic when it fails
Message-ID: <20040628062912.GA4391@taniwha.stupidest.org>
References: <20040627052747.GG23589@krispykreme> <200406270827.28310.ioe-lkml@rameria.de> <20040627222803.GH23589@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040627222803.GH23589@krispykreme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 08:28:03AM +1000, Anton Blanchard wrote:

> Unfortunately nodes without memory is relatively common on ppc64,
> and I believe x86-64. From a ppc64 perspective Im fine with best
> effort, perhaps someone from the heavily NUMA camp (ia64?) could
> comment.

Does anyone make ia64 NUMA hardware where you can have memory-less
nodes?


  --cw

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUF1S01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUF1S01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUF1S01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:26:27 -0400
Received: from galileo.bork.org ([66.11.174.156]:177 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S265112AbUF1S00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:26:26 -0400
Date: Mon, 28 Jun 2004 14:26:40 -0400
From: Martin Hicks <mort@wildopensource.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Anton Blanchard <anton@samba.org>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] __alloc_bootmem_node should not panic when it fails
Message-ID: <20040628182640.GP19652@localhost>
References: <20040627052747.GG23589@krispykreme> <200406270827.28310.ioe-lkml@rameria.de> <20040627222803.GH23589@krispykreme> <20040628062912.GA4391@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628062912.GA4391@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Jun 27, 2004 at 11:29:12PM -0700, Chris Wedgwood wrote:
> On Mon, Jun 28, 2004 at 08:28:03AM +1000, Anton Blanchard wrote:
> 
> > Unfortunately nodes without memory is relatively common on ppc64,
> > and I believe x86-64. From a ppc64 perspective Im fine with best
> > effort, perhaps someone from the heavily NUMA camp (ia64?) could
> > comment.
> 
> Does anyone make ia64 NUMA hardware where you can have memory-less
> nodes?

Altix SN2 can have memoryless nodes

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

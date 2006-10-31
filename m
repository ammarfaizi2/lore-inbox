Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWJaMqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWJaMqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 07:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWJaMqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 07:46:00 -0500
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:51148 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1422809AbWJaMqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 07:46:00 -0500
Message-ID: <45474585.2070607@compro.net>
Date: Tue, 31 Oct 2006 07:45:57 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Jun Sun <jsun@junsun.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reserve memory in low physical address - possible?
References: <20061031072203.GA10744@srv.junsun.net>
In-Reply-To: <20061031072203.GA10744@srv.junsun.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun Sun wrote:
> This question is specific to i386 architecture.  While I am fairly 
> comfortable with Linux kernel, I am not familiar with i386 arch. 
> 
> My objective is to reserve, or hide from kernel, some memory space in low
> physical address range starting from 0.  The memory amount is in the order
> of 100MB to 200MB.  The total memory is assumed to be around 512MB.
> 
> Is this possible?
> 
> I understand it is possible to reserve some memory at the end by
> specifying "mem=xxxM" option in kernel command line.  I looked into
> "memmap=xxxM" option but it appears not helpful for what I want.
> 
> While searching on the web I also found things like DMA zone and loaders
> etc that all seem to assume the existence low-addressed physical
> memory.  True?
> 
> I can certainly workaround the loader issue.  I can also re-code the real-mode
> part of kernel code to migrate to higher addresses.  The DMA zone might be
> a thorny one.  Any clues?  Are modern PCs still subject to
> the 16MB DMA zone restriction?
> 
> Am I too far off from what I want to do?
> 
> Thanks.
> 
> Jun

Maybe the bigphysarea patch is what you want?

Mark


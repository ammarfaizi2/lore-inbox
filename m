Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbUATRqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUATRqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:46:06 -0500
Received: from ns.suse.de ([195.135.220.2]:21397 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265580AbUATRqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:46:04 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, cmp@synopsys.com, jlnance@unity.ncsu.edu
Subject: Re: Awful NFS performance with attached test program
References: <20040119211649.GA20200@ncsu.edu.suse.lists.linux.kernel>
	<1074549226.1560.59.camel@nidelv.trondhjem.org.suse.lists.linux.kernel>
	<20040120132803.GA2830@ncsu.edu.suse.lists.linux.kernel>
	<1074607946.1871.37.camel@nidelv.trondhjem.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Jan 2004 15:38:00 +0100
In-Reply-To: <1074607946.1871.37.camel@nidelv.trondhjem.org.suse.lists.linux.kernel>
Message-ID: <p73r7xu65yv.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> Oh. It's an x86_64? You didn't say originally, so I assumed an ia32. OK,
> I believe my modified math above is correct.
> 
> If the your kernel was compiled using the default larger page size
> (isn't that 16K?), then the explanation is simple: Linux generates

x86-64 uses 4K pages, just like i386.  It doesn't support bigger pages.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTENI62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTENI62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:58:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:53 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261300AbTENI61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:58:27 -0400
Date: Wed, 14 May 2003 02:12:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: trond.myklebust@fys.uio.no
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] htree nfs fix
Message-Id: <20030514021229.35e74ccd.akpm@digeo.com>
In-Reply-To: <16066.1778.401988.753875@charged.uio.no>
References: <16065.35997.348432.385925@charged.uio.no>
	<20030513174425.2bc49803.akpm@digeo.com>
	<16066.1778.401988.753875@charged.uio.no>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 09:11:10.0319 (UTC) FILETIME=[C28E37F0:01C319F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> >>>>> " " == Andrew Morton <akpm@digeo.com> writes:
> 
>      > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>     >>
>     >> If you're unhappy with the state of readdir, then fix the
>     >> VFS/glibc.
> 
>      > What should be done?
> 
> Either we have to agree that we break legacy 32-bit getdents() and
> treat all cookies as signed 32/64-bit, or we break getdents64(), and
> treat all cookies as unsigned. (This applies to both 2.5.x and 2.4.x)
> 

Or we do nothing.

What would you recommend?



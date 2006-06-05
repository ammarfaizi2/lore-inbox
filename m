Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932349AbWFEBCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWFEBCM (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWFEBCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:02:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932349AbWFEBCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:02:11 -0400
Date: Sun, 4 Jun 2006 18:02:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readahead benchmark
Message-Id: <20060604180208.9f678a9b.akpm@osdl.org>
In-Reply-To: <349467272.31863@ustc.edu.cn>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<349467272.31863@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 08:28:07 +0800
Fengguang Wu <fengguang.wu@gmail.com> wrote:

> On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> > readahead-kconfig-options.patch
> [...] 
> >  It's early days yet - needs heaps more performance testing.  The results
> >  from "Linux Portal" <linportal@gmail.com> were discouraging.
> 
> I found this mail from the lkml archive, did you happen to have more
> results?
> 

Sorry, I had the wrong tester.  Voluspa <lista1@comhem.se>: "Conclusion: On
_this_ machine, with _these_ operations, Adaptive Readahead in its current
incarnation and default settings is a _loss_."

> 
> There is an interesting (although simple) benchmark of Wu's adaptive
> readahead patchset (v12) together with graphs here:
> 
>   http://linux.inet.hr/adaptive_readahead_benchmark.html
> 
> In that simple test it definitely looks promising (3x speedup).

That's postgreql again.

We know there's a problem at present with postgresql.  Has anyone tried to
fix it, without going and rewriting everything?

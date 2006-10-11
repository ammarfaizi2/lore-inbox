Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWJKVrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWJKVrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWJKVrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:47:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23512 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422661AbWJKVrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:47:21 -0400
Date: Wed, 11 Oct 2006 14:47:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061011144713.cb0c1453.akpm@osdl.org>
In-Reply-To: <452D4D17.1090705@google.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452D4D17.1090705@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 12:59:19 -0700
"Martin J. Bligh" <mbligh@google.com> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> >
> >
> > -
> >   
> 
> Oh, and hangs in LTP.
> 
> x86_64 just hangs.
> http://test.kernel.org/abat/54544/debug/test.log.1 (in something io-ish)
> 

What makes you thing it was something io-ish?

> 
> http://test.kernel.org/abat/54541/debug/test.log.1 (ppc64)
> craps itself with

There's been a fix for this in hot-fixes/ for 24 hours.  It'd be good if you
could tinkle the scripts to pull that directory in.

Or just suck the -mm git tree.  That incorprates additions to hot-fixes/ within
five minutes.


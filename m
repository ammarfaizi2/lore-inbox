Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVC2DMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVC2DMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVC2DMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:12:52 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:33729 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262164AbVC2DMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:12:51 -0500
Date: Mon, 28 Mar 2005 19:12:40 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Chris Wright <chrisw@osdl.org>, Coywolf Qi Hunt <coywolf@gmail.com>,
       Ali Akcaagac <aliakc@web.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel OOOPS in 2.6.11.6
Message-ID: <20050329031240.GA5365@taniwha.stupidest.org>
References: <20050329020608.GA4675@taniwha.stupidest.org> <7326.1112063221@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7326.1112063221@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 12:27:01PM +1000, Keith Owens wrote:

> i386 needs unwind data plus a kernel unwinder to get accurate
> backtraces.  Without the data and an unwinder, i386 backtraces are
> best guess.  They often contain spurious addresses, from noise words
> that were left on the kernel stack.  Nothing to do with
> CONFIG_4K_STACKS.

XFS will break sometimes with 4K stacks on x86

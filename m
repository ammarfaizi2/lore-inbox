Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVAMGzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVAMGzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAMGzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:55:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:11181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261173AbVAMGzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:55:15 -0500
Date: Wed, 12 Jan 2005 22:54:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davej@redhat.com, torvalds@osdl.org, marcelo.tosatti@cyclades.com,
       greg@kroah.com, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-Id: <20050112225412.5957c5d7.akpm@osdl.org>
In-Reply-To: <20050113044942.GI14443@holomorphy.com>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	<20050112185133.GA10687@kroah.com>
	<Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	<20050112161227.GF32024@logos.cnet>
	<Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	<20050112205350.GM24518@redhat.com>
	<Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	<20050112182838.2aa7eec2.akpm@osdl.org>
	<20050113033542.GC1212@redhat.com>
	<20050112194239.0a7b720b.akpm@osdl.org>
	<20050113044942.GI14443@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Most of the local DoS's I'm aware of are memory management -related,
>  i.e. user- triggerable proliferation of pinned kernel data structures.

Well.  A heck of a lot of the DoS opportunities we've historically seen
involved memory leaks, deadlocks or making the kernel go oops or BUG with
locks held or with kernel memory allocated.


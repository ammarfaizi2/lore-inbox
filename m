Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUIJGzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUIJGzD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUIJGzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:55:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:34252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267278AbUIJGyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:54:14 -0400
Date: Thu, 9 Sep 2004 23:52:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040909235217.5a170840.akpm@osdl.org>
In-Reply-To: <414149A0.1050006@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
	<20040909010610.28ca50e1.akpm@osdl.org>
	<4140EE3E.5040602@bigpond.net.au>
	<20040909171450.6546ee7a.akpm@osdl.org>
	<4141092B.2090608@bigpond.net.au>
	<20040909200650.787001fc.akpm@osdl.org>
	<41413F64.40504@bigpond.net.au>
	<20040909231858.770ab381.akpm@osdl.org>
	<414149A0.1050006@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> > Please keep going ;)
>  > 
> 
>  All the way through and it's still occurring.  After the second patch 
>  the symptoms changed slightly and it was a different gdm program that 
>  triggered the oops.  But with all patches applied it's back to the 
>  original symptoms.

Drat - I expected one of those would be the culprit.  Your .config works
happily here on a FC1 box, of course :(

It would be useful if you could experiment with CONFIG_DEBUG_SLAB and
CONFIG_DEBUG_PAGEALLOC.


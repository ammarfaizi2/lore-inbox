Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWECNZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWECNZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWECNZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:25:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030198AbWECNZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:25:51 -0400
Date: Wed, 3 May 2006 06:25:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: greg@kroah.com, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-Id: <20060503062536.56cad6f5.akpm@osdl.org>
In-Reply-To: <20060502204216.GB6566@in.ibm.com>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
	<20060428163409.389e895e.akpm@osdl.org>
	<20060428234410.GA7598@kroah.com>
	<20060428170519.1194b077.akpm@osdl.org>
	<20060429071818.GA939@kroah.com>
	<20060429232615.GA18723@in.ibm.com>
	<20060429164043.4cf4a861.akpm@osdl.org>
	<20060502204216.GB6566@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 16:42:16 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > Yes, it would need to to be a new type - resource_addr_t, perhaps.
> > 
> 
> How about "res_sz_t".

resource_size_t, please.

> "resource_addr_t" probably is not a very appropriate
> keyword as at lots of places we also need to represent size and alignment
> with this typedef.

OK.

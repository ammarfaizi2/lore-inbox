Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268755AbUHTVdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbUHTVdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268759AbUHTVdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:33:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:30699 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268755AbUHTVdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:33:07 -0400
Date: Fri, 20 Aug 2004 14:35:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rusty@rustcorp.com.au, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org, vatsa@in.ibm.com
Subject: Re: 2.6.8.1-mm2
Message-Id: <20040820143554.59979df9.akpm@osdl.org>
In-Reply-To: <20040820083322.GA8392@elte.hu>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	<1092964083.4946.7.camel@biclops.private.network>
	<20040819181603.700a9a0e.akpm@osdl.org>
	<1092987650.28849.349.camel@bach>
	<20040820083322.GA8392@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > Nathan, can you revert that, and apply this?  This actually fixes the
> > might_sleep problem, and should fix at least the problem Vatsa saw. 
> > If it doesn't solve your problem, we need to look again.
> 
> i've attached a much simpler replacement: dont allow CPU hotplug during
> self-reap.

I got this patch into -mm3, but at the expense of one of Rusty's earlier
patches.

Could you and Rusty please carefully review what we have in -mm3 and make
sure that everything is now shipshape?


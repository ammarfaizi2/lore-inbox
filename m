Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUAGFa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUAGFa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:30:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:30364 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266142AbUAGFa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:30:27 -0500
Date: Tue, 6 Jan 2004 21:30:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: shutdown panic in mm_release (really flush_tlb_others?)
Message-Id: <20040106213036.5051129b.akpm@osdl.org>
In-Reply-To: <4500000.1073444277@[10.10.2.4]>
References: <4500000.1073444277@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> And the award for longest panic I've ever seen goes to ....
>  <drumroll> ....
> 
>  (there were several of these in sequence).
>  Looks like it was trying to printk an error on shutdown ...
>  really maybe " [<c0115242>] flush_tlb_others+0x22/0xd0"
> 
>  Probably the same panic I sent out the other day in a slight
>  disguise ... "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others

Cute.  Didn't you have a patch for this?  Or a proposed solution which
you've been too lazy to type in?  ;)


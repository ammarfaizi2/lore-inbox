Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263628AbUEKUxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUEKUxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUEKUxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:53:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:24739 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263628AbUEKUxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:53:09 -0400
Date: Tue, 11 May 2004 13:55:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: hch@infradead.org, geoff@linux.jf.intel.com, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511135538.1f232b79.akpm@osdl.org>
In-Reply-To: <20040511203236.GA6726@elte.hu>
References: <409FFF3B.3090506@linux.intel.com>
	<20040511004551.7c7af44d.akpm@osdl.org>
	<00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com>
	<20040511121126.73f5fdeb.akpm@osdl.org>
	<20040511195856.GA4958@elte.hu>
	<20040511131137.2390ffa8.akpm@osdl.org>
	<20040511211950.A20071@infradead.org>
	<20040511132619.7a4fb4cb.akpm@osdl.org>
	<20040511203236.GA6726@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Nah, that's ungrammatical.  del_timer_singleshot means "delete a timer
> > in a single-shot manner".
> > 
> > We have:
> > 
> > "add a timer"
> > "modify a timer"
> > "delete a timer"
> > "delete a timer synchronously"
> > "delete a single-shot timer"
> 
> hm, indeed. Miraculously, the existing timer API names are correct
> grammatically, so we might as well go for del_single_shot_timer() ...
> 

<anal>del_singleshot_timer_sync</anal>

I vote we leave it up to Ken.  But please, not del_timer_kenneth().


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbUKRE6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbUKRE6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUKRE6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:58:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:15307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262543AbUKRE54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:57:56 -0500
Date: Wed, 17 Nov 2004 20:57:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Ian.Pratt@cl.cam.ac.uk, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-Id: <20041117205728.27a7e58d.akpm@osdl.org>
In-Reply-To: <200411180654.iAI6sTQ3008495@ccure.user-mode-linux.org>
References: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk>
	<200411180508.iAI58iQ3007886@ccure.user-mode-linux.org>
	<20041117190933.16e8b8ed.akpm@osdl.org>
	<200411180654.iAI6sTQ3008495@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> akpm@osdl.org said:
> > But heck - why bother?  The current patch adds just one line of code
> > in one place, and the compiler will toss it away anyway for all but
> > xen and um. 
> 
> Agree, but on a conceptual level, this is allowing the arch to swipe pages 
> arbitrarily out from under the nose of the generic page allocator.  Plus, the 
> code that's being bypassed has to be implemented in some form in the arch.  
> That's not my concern, or yours, necessarily, but it does suggest that the 
> interface is being abused.
> 

True.  But we can take a look at that once we've seen the rest of the xen
patches.  I wouldn't be merging up any of these patches until we've seen
the whole submission.



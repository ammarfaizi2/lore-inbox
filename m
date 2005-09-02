Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbVIBU75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbVIBU75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbVIBU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:59:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161013AbVIBU7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:59:15 -0400
Date: Fri, 2 Sep 2005 13:57:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-Id: <20050902135735.5862e97b.akpm@osdl.org>
In-Reply-To: <20050902135701.GA4470@linux.intel.com>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<20050902135701.GA4470@linux.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@linux.intel.com> wrote:
>
> On Thu, Sep 01, 2005 at 03:55:42AM -0700, Andrew Morton wrote:
> >  Dropped (I have it in a new AIO patch series but I took yet another look at
> >  all the AIO stuff and felt queasy)
> 
> What's the nature of the queasiness?  Is it something that can be addressed 
> by rewriting the patches, or just general worries about adding another 
> feature?  The status quo is not acceptable.
> 

Cons:

- Additional arguments to various fastpath functions

- Additional code size

- Additional code complexity

- Significantly degrades collective understanding of how the VFS works.

Pros:

- Unclear.


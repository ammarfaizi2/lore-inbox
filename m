Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbVD3Btx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVD3Btx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 21:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVD3Bt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 21:49:28 -0400
Received: from ozlabs.org ([203.10.76.45]:48009 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263122AbVD3BtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 21:49:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17010.58405.906123.715001@cargo.ozlabs.ibm.com>
Date: Sat, 30 Apr 2005 11:49:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
In-Reply-To: <20050429141437.GA24617@kvack.org>
References: <20050428182926.GC16545@kvack.org>
	<17009.33633.378204.859486@cargo.ozlabs.ibm.com>
	<20050429141437.GA24617@kvack.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:

> There are at least two users who need asynchronous semaphore/mutex 
> operations: aio_write (which needs to acquire i_sem), and nfs.  

What do you mean by asynchronous semaphore/mutex operations?  Are you
talking about a down operation that will acquire the semaphore if it
is free, but if not, arrange for a callback and return immediately, or
something?

Paul.

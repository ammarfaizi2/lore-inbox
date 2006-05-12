Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWELKMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWELKMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWELKMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:12:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751109AbWELKMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:12:02 -0400
Date: Fri, 12 May 2006 03:08:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, hch@lst.de,
       bcrl@kvack.org, cel@citi.umich.edu
Subject: Re: [PATCH 1/4] Vectorize aio_read/aio_write methods
Message-Id: <20060512030855.65651bb5.akpm@osdl.org>
In-Reply-To: <20060512030309.3a94bea8.akpm@osdl.org>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147361939.12117.12.camel@dyn9047017100.beaverton.ibm.com>
	<20060512030309.3a94bea8.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Please send fix.

On second thoughts, I'll drop them all.  Too many fixups, this code needs
more work.

Please ensure that the next version passes allmodconfig without adding any
new warnings on both 32-bit and 64-bit compilers, thanks.


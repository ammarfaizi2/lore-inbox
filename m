Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUIOV1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUIOV1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIOVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:23:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:55204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267507AbUIOVTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:19:54 -0400
Date: Wed, 15 Sep 2004 14:23:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][3/6]Routines for copying the dump pages
Message-Id: <20040915142339.4f0881d8.akpm@osdl.org>
In-Reply-To: <20040915125422.GD15450@in.ibm.com>
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<20040915125422.GD15450@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> +/*
> + * Copy a page from "oldmem". For this page, there is no pte mapped
> + * in the current kernel. We stitch up a pte, similar to kmap_atomic.
> + */
> +static inline ssize_t copy_oldmem_page(unsigned long pfn,
> +			char *buf, size_t csize, int userbuf)

Again, why inline this function?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUFEGMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUFEGMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 02:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264349AbUFEGMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 02:12:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:39837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264514AbUFEGMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 02:12:30 -0400
Date: Fri, 4 Jun 2004 23:11:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, ak@suse.de,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH]2.6.7-rc1 Fix and Reenable MSI Support on x86_64
Message-Id: <20040604231147.16dbc393.akpm@osdl.org>
In-Reply-To: <200406040120.i541KT53004130@snoqualmie.dp.intel.com>
References: <200406040120.i541KT53004130@snoqualmie.dp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

long <tlnguyen@snoqualmie.dp.intel.com> wrote:
>
> 
>  MSI support for x86_64 is currently disabled in the kernel 2.6.x.
>  Below is the patch, which provides a fix and reenable it.

Could you please fix this up?

arch/x86_64/kernel/i8259.c:118: warning: excess elements in array initializer
arch/x86_64/kernel/i8259.c:118: warning: (near initialization for `interrupt')

.config is at http://www.zip.com.au/~akpm/linux/patches/stuff/config

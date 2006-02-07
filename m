Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWBGVGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWBGVGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWBGVGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:06:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:7656 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932216AbWBGVGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:06:18 -0500
Message-ID: <43E90BC1.7010907@austin.ibm.com>
Date: Tue, 07 Feb 2006 15:06:09 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 4/9] ppc64 - Specify amount of kernel memory
 at boot time
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie> <20060126184425.8550.64598.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060126184425.8550.64598.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch adds the kernelcore= parameter for ppc64

...

> diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.16-rc1-mm3-103_x86coremem/mm/page_alloc.c linux-2.6.16-rc1-mm3-104_ppc64coremem/mm/page_alloc.c
> --- linux-2.6.16-rc1-mm3-103_x86coremem/mm/page_alloc.c	2006-01-26 18:09:04.000000000 +0000
> +++ linux-2.6.16-rc1-mm3-104_ppc64coremem/mm/page_alloc.c	2006-01-26 18:10:29.000000000 +0000

Not to nitpick, but this chunk should go in a different patch, it's not 
ppc64 specific.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVB0NRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVB0NRz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 08:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVB0NRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 08:17:55 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:3508 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261385AbVB0NRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 08:17:53 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Date: Sun, 27 Feb 2005 14:17:51 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <2.416337461@selenic.com>
In-Reply-To: <2.416337461@selenic.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200502271417.51654.agruen@suse.de>
X-Length: 1138
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt,

On Monday 31 January 2005 08:34, Matt Mackall wrote:
> This patch adds a generic array sorting library routine. This is meant
> to replace qsort, which has two problem areas for kernel use.

the sort function is broken. When sorting the integer array {1, 2, 3, 4, 5}, 
I'm getting {2, 3, 4, 5, 1} as a result. Can you please have a look?

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH


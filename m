Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCURRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCURRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVCURRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 12:17:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29354 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261166AbVCURRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 12:17:48 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>, arjanv@infradead.org
Subject: Re: 2.6.12-rc1-mm1
Date: Mon, 21 Mar 2005 09:15:53 -0800
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050321025159.1cabd62e.akpm@osdl.org>
In-Reply-To: <20050321025159.1cabd62e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503210915.53193.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 21, 2005 2:51 am, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>6.12-rc1-mm1/

Andrew, please drop

revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch

The tiocx.c driver is now in the tree, and it uses those functions.

Thanks,
Jesse

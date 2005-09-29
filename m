Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVI2WgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVI2WgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVI2WgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:36:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932302AbVI2WgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:36:24 -0400
Date: Thu, 29 Sep 2005 15:36:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Seth, Rohit" <rohit.seth@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] earlier allocation of order 0 pages from pcp in
 __alloc_pages
Message-Id: <20050929153626.3ab4fce1.akpm@osdl.org>
In-Reply-To: <20050929150155.A15646@unix-os.sc.intel.com>
References: <20050929150155.A15646@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Seth, Rohit" <rohit.seth@intel.com> wrote:
>
> 	[PATCH]: Try to service a order 0 page request in __alloc_pages from the pcp list before checking the aone_watermarks.
>
>         Try to service a order 0 page request from pcp list.  This will allow us to not check and possibly start the reclaim activity when there are free pages present on the pcp.  This early allocation does not try to replenish an empty pcp.

(Please avoid the 240-column emails!)

Why is this a desirable change to make?

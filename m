Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUAIEPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUAIEPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:15:49 -0500
Received: from dp.samba.org ([66.70.73.150]:1759 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263834AbUAIEPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:15:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] dynamic allocation of huge continuous pages 
In-reply-to: Your message of "Thu, 08 Jan 2004 20:37:34 +0900."
             <20040108.203734.122074391.taka@valinux.co.jp> 
Date: Fri, 09 Jan 2004 14:56:18 +1100
Message-Id: <20040109041546.5F2B82C071@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040108.203734.122074391.taka@valinux.co.jp> you write:
> +		list_for_each(p, &area->free_list) {
> +			page = list_entry(p, struct page, list);

Just FYI, "list_for_each_entry(page, &area->free_list, list)" is
shorter and neater.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbUAIJnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 04:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUAIJns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 04:43:48 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:29374 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S266452AbUAIJnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 04:43:47 -0500
Date: Fri, 09 Jan 2004 18:41:58 +0900 (JST)
Message-Id: <20040109.184158.128598672.taka@valinux.co.jp>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] dynamic allocation of huge continuous pages 
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040109041546.5F2B82C071@lists.samba.org>
References: <20040108.203734.122074391.taka@valinux.co.jp>
	<20040109041546.5F2B82C071@lists.samba.org>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Thank you for your advice.

> > +		list_for_each(p, &area->free_list) {
> > +			page = list_entry(p, struct page, list);
> 
> Just FYI, "list_for_each_entry(page, &area->free_list, list)" is
> shorter and neater.
> 
> Cheers,
> Rusty.

Thank you,
Hirokazu Takahashi.

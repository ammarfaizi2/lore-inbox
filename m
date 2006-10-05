Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWJEUTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWJEUTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJEUTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:19:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7569
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751224AbWJEUTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:19:41 -0400
Date: Thu, 05 Oct 2006 13:19:43 -0700 (PDT)
Message-Id: <20061005.131943.11597704.davem@davemloft.net>
To: dmonakhov@openvz.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: D-cache aliasing issue in __block_prepare_write
From: David Miller <davem@davemloft.net>
In-Reply-To: <87ejtmn675.fsf@sw.ru>
References: <87ejtmn675.fsf@sw.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monakhov Dmitriy <dmonakhov@openvz.org>
Date: Thu, 05 Oct 2006 19:16:46 +0400

> It's seems I've found D-cache aliasing issue in fs/buffer.c
 ...
> x86 does not have cache aliasing problems, the problem could
> show up only on marginal archs, ia64 is the most frequently used.
> 
> Following is the patch against 2.6.18 fix this issue:

This patch looks good to me.

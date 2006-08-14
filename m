Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWHNMHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWHNMHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWHNMHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:07:50 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:20018 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1752016AbWHNMHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:07:48 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator. 
In-reply-to: Your message of "Mon, 14 Aug 2006 15:04:03 +0400."
             <20060814110359.GA27704@2ka.mipt.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 22:07:48 +1000
Message-ID: <9286.1155557268@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov (on Mon, 14 Aug 2006 15:04:03 +0400) wrote:
>Network tree allocator can be used to allocate memory for all network
>operations from any context....
>...
>Design of allocator allows to map all node's pages into userspace thus
>allows to have true zero-copy support for both sending and receiving
>dataflows.

Is that true for architectures with virtually indexed caches?  How do
you avoid the cache aliasing problems?


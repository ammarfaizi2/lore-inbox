Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbVKIUYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbVKIUYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbVKIUYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:24:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161222AbVKIUYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:24:11 -0500
Date: Wed, 9 Nov 2005 12:20:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: saw@sawoct.com, xemul@sw.ru, linux-kernel@vger.kernel.org, den@sw.ru
Subject: Re: [PATCH]: buddy allocator: ext3 failed to alloc with
 __GFP_NOFAIL
Message-Id: <20051109122002.01b81b03.akpm@osdl.org>
In-Reply-To: <43725227.5040605@sw.ru>
References: <4370ACB2.3000103@sw.ru>
	<43725227.5040605@sw.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> as Andrey Savochkin pointed to me, the previous patch is incorrect since 
>  makes allocations with PF_MEMALLOC to be always success for order <= 3 
>  which is not what we usually want.

OK, thanks.  This patch was still in my
things-i-need-to-spend-half-an-hour-thinking-about queue anyway.

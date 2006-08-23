Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWHWQwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWHWQwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWHWQwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:52:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31174 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965057AbWHWQwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:52:22 -0400
Date: Wed, 23 Aug 2006 09:50:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 4/6] BC: user interface (syscalls)
Message-Id: <20060823095031.cb14cc52.akpm@osdl.org>
In-Reply-To: <44EC5B74.2040104@sw.ru>
References: <44EC31FB.2050002@sw.ru>
	<44EC369D.9050303@sw.ru>
	<44EC5B74.2040104@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 17:43:16 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> +asmlinkage long sys_set_bclimit(uid_t id, unsigned long resource,
> +		unsigned long *limits)

I'm still a bit mystified about the use of uid_t here.  It's not a uid, is
it?


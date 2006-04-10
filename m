Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWDJVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWDJVDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDJVDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:03:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751074AbWDJVDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:03:03 -0400
Date: Mon, 10 Apr 2006 13:02:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
Message-Id: <20060410130214.70760ae3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604101523031.32445@scrub.home>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
	<20060410015727.69b5c1f6.akpm@osdl.org>
	<20060410104250.GA24160@mars.ravnborg.org>
	<20060410025851.641022a0.akpm@osdl.org>
	<Pine.LNX.4.64.0604101523031.32445@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> On Mon, 10 Apr 2006, Andrew Morton wrote:
> 
>  > hm, it takes nearly five seconds, but it wasn't that - something actually
>  > broke.  But I forget what it was.  I'll put it back and will wait for it
>  > to reoccur.
> 
>  The patch below should speed this up.

It went from 5 seconds down to 4 seconds.

> You know that you have to update 
>  this file explicitly?

That depends on what "explicitly" means.   `make oldconfig' updates it.

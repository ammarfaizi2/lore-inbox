Return-Path: <linux-kernel-owner+w=401wt.eu-S1425612AbWLHQlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425612AbWLHQlt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425613AbWLHQlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:41:49 -0500
Received: from [198.99.130.12] ([198.99.130.12]:39093 "EHLO
	saraswathi.solana.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1425612AbWLHQls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:41:48 -0500
Date: Fri, 8 Dec 2006 11:37:40 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uml problems with linux/io.h
Message-ID: <20061208163740.GC5944@ccure.user-mode-linux.org>
References: <20061208094530.GP4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208094530.GP4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 09:45:30AM +0000, Al Viro wrote:
> Remove useless includes of linux/io.h, don't even try to build iomap_copy
> on uml (it doesn't have readb() et.al., so...)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  crypto/blkcipher.c |    1 -
>  lib/Kconfig        |    5 +++++
>  lib/Makefile       |    3 ++-
>  lib/ioremap.c      |    1 -
>  4 files changed, 7 insertions(+), 3 deletions(-)

Acked-by: Jeff Dike <jdike@addtoit.com>

-- 
Work email - jdike at linux dot intel dot com

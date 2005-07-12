Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVGLX7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVGLX7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVGLX7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:59:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262470AbVGLX6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:58:11 -0400
Date: Tue, 12 Jul 2005 16:57:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too
 much, for no good reason.]
Message-Id: <20050712165719.7211e277.akpm@osdl.org>
In-Reply-To: <42D3F502.9040209@brturbo.com.br>
References: <42D3F502.9040209@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>
>  	Do you intend to apply Olaf's patchsets to eliminate linux/version.h?
>  Some of them will not apply, because, at -mm2, KERNEL_VERSION isn't used
>  anymore.

I think they were against -mm.  They all applied OK.

>  	Maybe I can generate a patchset for V4L eliminating version.h, if you
>  want, against latest version.

Well the patches are staged after everything else in -mm.  After 2.6.13 is
released I guess I'll move them forward, fix stuff up, send them to Linus
and people will fix up any fallout in external trees.


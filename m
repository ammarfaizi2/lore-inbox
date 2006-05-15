Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWEOVqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWEOVqF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWEOVqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:46:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965258AbWEOVqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:46:04 -0400
Date: Mon, 15 May 2006 14:48:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kdump maintainer info update
Message-Id: <20060515144844.1a791909.akpm@osdl.org>
In-Reply-To: <20060515142805.GA6517@in.ibm.com>
References: <20060515142805.GA6517@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> diff -puN MAINTAINERS~kdump-maintainers-update MAINTAINERS
> --- linux-2.6.17-rc4-1M/MAINTAINERS~kdump-maintainers-update	2006-05-15 10:05:45.000000000 -0400
> +++ linux-2.6.17-rc4-1M-vivek/MAINTAINERS	2006-05-15 10:21:20.000000000 -0400
> @@ -1536,6 +1536,16 @@ M:	zippel@linux-m68k.org
>  L:	kbuild-devel@lists.sourceforge.net
>  S:	Maintained
>  
> +KDUMP
> +P:	Vivek Goyal
> +M:	vgoyal@in.ibm.com
> +P:	Haren Myneni
> +M:	hbabu@us.ibm.com

btw, I'm thinking it would be sensible to convert the MAINTAINERS file into the
form:

P: Vivek Goyal <vgoyal@in.ibm.com>
P: Haren Myneni <hbabu@us.ibm.com>

And remove the "M:" lines.

This is more compact, saner for pasting into email clients, saner for
pasting into patch changelogs and would save me, oh, 45 seconds per day.


Is there any reason not to do this?  Such as tools which are parsing the
current format?

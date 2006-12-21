Return-Path: <linux-kernel-owner+w=401wt.eu-S1161101AbWLUA46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWLUA46 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWLUA46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:56:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54619 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161101AbWLUA45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:56:57 -0500
Date: Wed, 20 Dec 2006 16:56:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: fix email for S3C2410 and S3C2440
Message-Id: <20061220165624.8a3e895e.akpm@osdl.org>
In-Reply-To: <20061218102411.GA10601@home.fluff.org>
References: <20061218102411.GA10601@home.fluff.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 10:24:11 +0000
Ben Dooks <ben-linux@fluff.org> wrote:

> --- linux-2.6.20-rc1/MAINTAINERS	2006-12-17 23:04:58.000000000 +0000
> +++ linux-2.6.20-rc1-fix2/MAINTAINERS	2006-12-18 10:21:25.000000000 +0000
> @@ -406,14 +406,14 @@ S:	Maintained
>  
>  ARM/S3C2410 ARM ARCHITECTURE
>  P:	Ben Dooks
> -M:	ben-s3c2410@fluff.org
> +M:	ben-linux@fluff.org
>  L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  
>  ARM/S3C2440 ARM ARCHITECTURE
>  P:	Ben Dooks
> -M:	ben-s3c2440@fluff.org
> +M:	ben-linux@fluff.org
>  L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
> 
> 
> [2620-rc1-s3c24xx-fix-maintainer-email.patch  text/x-diff (600B)]
> --- linux-2.6.20-rc1/MAINTAINERS	2006-12-17 23:04:58.000000000 +0000
> +++ linux-2.6.20-rc1-fix2/MAINTAINERS	2006-12-18 10:21:25.000000000 +0000

argh.  Please don't include a patch in both the email body and as an
attachment like this.  Because the resulting file applies happily with
`patch --dry-run' then goes boom when you apply it for real.



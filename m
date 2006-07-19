Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWGSXMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWGSXMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWGSXMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:12:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932564AbWGSXMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:12:08 -0400
Subject: Re: [RFC: -mm patch] fs/dlm/lock.c: unexport dlm_lvb_operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
In-Reply-To: <20060715003631.GM3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <20060715003631.GM3633@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 20 Jul 2006 00:27:30 +0100
Message-Id: <1153351651.3604.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch. Its now applied to the gfs2 git tree,

Steve.

On Sat, 2006-07-15 at 02:36 +0200, Adrian Bunk wrote:
> On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc1-mm1:
> >...
> >  git-gfs2.patch
> >...
> >  git trees.
> >...
> 
> This patch removes the unused EXPORT_SYMBOL_GPL(dlm_lvb_operations).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc1-mm2-full/fs/dlm/lock.c.old	2006-07-15 00:39:11.000000000 +0200
> +++ linux-2.6.18-rc1-mm2-full/fs/dlm/lock.c	2006-07-15 00:39:17.000000000 +0200
> @@ -128,7 +128,6 @@
>          {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
>          {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
>  };
> -EXPORT_SYMBOL_GPL(dlm_lvb_operations);
>  
>  #define modes_compat(gr, rq) \
>  	__dlm_compat_matrix[(gr)->lkb_grmode + 1][(rq)->lkb_rqmode + 1]
> 


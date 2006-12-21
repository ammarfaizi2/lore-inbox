Return-Path: <linux-kernel-owner+w=401wt.eu-S1422662AbWLUDtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWLUDtF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWLUDtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:49:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35213 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422662AbWLUDtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:49:02 -0500
Date: Wed, 20 Dec 2006 19:48:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: Remove final traces of deprecated kmem_cache_t.
Message-Id: <20061220194858.120af272.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612191305490.10391@localhost.localdomain>
References: <Pine.LNX.4.64.0612191305490.10391@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 13:10:11 -0500 (EST)
"Robert P. J. Day" <rpjday@mindspring.com> wrote:

> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -14,8 +14,6 @@
>  #include <linux/gfp.h>
>  #include <linux/types.h>
> 
> -typedef struct kmem_cache kmem_cache_t __deprecated;
> -

Nope, let's leave that there for a couple of kernel cycles, give people  
to catch up.

It's fairly common for non-developers to download and build out-of-tree code from
random websites.  Let's not break their build unless we really need to.  In this
case there's little cost to us in giving the developers of that out-of-tree code
time to do an update.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTIJFGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTIJFGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:06:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:30396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264536AbTIJFGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:06:51 -0400
Date: Tue, 9 Sep 2003 22:08:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: davidm@HPL.HP.COM, torvalds@osdl.org, jes@wildopensource.com,
       hch@infradead.org, linux-kernel@vger.kernel.org, jun.nakajima@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Patch] asm workarounds in generic header files
Message-Id: <20030909220808.31eb29ca.akpm@osdl.org>
In-Reply-To: <A609E6D693908E4697BF8BB87E76A07A022114C1@fmsmsx408.fm.intel.com>
References: <A609E6D693908E4697BF8BB87E76A07A022114C1@fmsmsx408.fm.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> --- linux/include/linux/compiler-intel.h	Wed Dec 31 16:00:00 1969
>  +++ linux-/include/linux/compiler-intel.h	Tue Sep  9 21:34:19 2003
>  @@ -0,0 +1,21 @@
>  +/* Never include this file directly.  Include <linux/compiler.h> instead.  */
>  +
>  +#ifdef __ECC
>  +
>  +/* Some compiler specific definitions are overwritten here
>  + * for Intel ECC compiler 
>  + */
>  +
>  +#include <asm/intrinsics.h>

This is ia64-only, yes?

Where do we stand with ECC/ia32 support?


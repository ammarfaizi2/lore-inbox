Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWAFJOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWAFJOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWAFJOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:14:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:188 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932386AbWAFJOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:14:52 -0500
Date: Fri, 6 Jan 2006 10:12:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       hch@infradead.org
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
Message-ID: <20060106091238.GA2438@elf.ucw.cz>
References: <patchbomb.1135726914@eng-12.pathscale.com> <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 27-12-05 15:41:56, Bryan O'Sullivan wrote:
> Introduce an x86_64-specific memcpy32 routine.  The routine is similar
> to memcpy, but is guaranteed to work in units of 32 bits at a time.
> 
> Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

> diff -r 7b7b442a4d63 -r 042b7d9004ac arch/x86_64/lib/memcpy32.S
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/arch/x86_64/lib/memcpy32.S	Tue Dec 27 15:41:48 2005 -0800
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (c) 2003, 2004, 2005 PathScale, Inc.
> + */

Did it really take 3 years to develop this? Anyway this contains
copyright but not GPL, not allowing us to distribute it.
							Pavel

-- 
Thanks, Sharp!

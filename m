Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTKTRQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTKTRQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:16:32 -0500
Received: from ns.suse.de ([195.135.220.2]:64655 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262033AbTKTRP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:15:28 -0500
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mqueues-4.00-lib-a0.patch
References: <20031120165500.GA5569@rudolph.ccur.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Nov 2003 18:15:25 +0100
In-Reply-To: <20031120165500.GA5569@rudolph.ccur.com.suse.lists.linux.kernel>
Message-ID: <p73brr7otaq.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:
> +#ifndef __NR_mq_open
>  
> +#ifdef __i386__
>  #define __NR_mq_open		274
> +#elif __x86_64__
> +#define __NR_mq_open		237
> +#else

FYI. I already allocated 237 for something else on x86-64.  The patch
is guaranteed to get broken.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVEZXr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVEZXr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 19:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVEZXr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 19:47:57 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:28083 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261853AbVEZXrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 19:47:37 -0400
Message-ID: <42966014.4070408@us.ibm.com>
Date: Thu, 26 May 2005 16:47:32 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] smp_processor_id() cleanup, 2.6.12-rc5
References: <20050526104449.GA14289@elte.hu>
In-Reply-To: <20050526104449.GA14289@elte.hu>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> --- linux/lib/smp_processor_id.c.orig
> +++ linux/lib/smp_processor_id.c
> @@ -0,0 +1,55 @@
> +/*
> + * lib/kernel_lock.c
> + *
> + * DEBUG_PREEMPT variant of smp_processor_id.
> + */

Nope.  It's lib/smp_processor_id.c.

Other than this, I agree that this is extremely helpful and I greatly look
forward to it's inclusion.  I've grappled with the underscore monkey many
times...

-Matt

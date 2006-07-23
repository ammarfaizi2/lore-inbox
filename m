Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWGWUYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWGWUYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWGWUYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:24:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2464 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751290AbWGWUYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:24:13 -0400
Message-ID: <44C3DAE5.7050601@garzik.org>
Date: Sun, 23 Jul 2006 16:24:05 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se>
In-Reply-To: <1153669750.44c39a7607a30@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> index 4b4b295..3cb84ac 100644
> --- a/include/asm-i386/types.h
> +++ b/include/asm-i386/types.h
> @@ -1,6 +1,8 @@
>  #ifndef _I386_TYPES_H
>  #define _I386_TYPES_H
>  
> +typedef _Bool bool;
> +
>  #ifndef __ASSEMBLY__
>  


This probably belongs in include/linux/types.h.

Other than that, looks good to me.

	Jeff



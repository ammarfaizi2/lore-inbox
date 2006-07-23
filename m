Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWGWQNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWGWQNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWGWQNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:13:46 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:41188
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751249AbWGWQNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:13:45 -0400
From: Michael Buesch <mb@bu3sch.de>
To: ricknu-0@student.ltu.se
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
Date: Sun, 23 Jul 2006 18:13:21 +0200
User-Agent: KMail/1.9.1
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se>
In-Reply-To: <1153669750.44c39a7607a30@portal.student.luth.se>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607231813.21813.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 17:49, ricknu-0@student.ltu.se wrote:
> And here comes lucky number four.

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

I'd say that typedef must go into the !__ASSEMBLY__ section here,
like the other typedefs in that header.

-- 
Greetings Michael.

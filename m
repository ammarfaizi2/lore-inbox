Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVLIKH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVLIKH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVLIKH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:07:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1260 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751294AbVLIKH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:07:56 -0500
Date: Fri, 9 Dec 2005 12:01:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Miguel de Icaza <miguel@nuclecu.unam.mx>,
       Gadi Oxman <gadio@netvision.net.il>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Decrease number of pointer derefs in multipath.c
Message-ID: <20051209110129.GB20314@elte.hu>
References: <200512082336.30194.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512082336.30194.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesper Juhl <jesper.juhl@gmail.com> wrote:

> Hi,
> 
> Here's a small patch to decrease the number of pointer derefs in
> drivers/md/multipath.c
> 
> Benefits of the patch:
>  - Fewer pointer dereferences should make the code slightly faster.
>  - Size of generated code is smaller
>  - improved readability
> 
> Please consider applying.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo

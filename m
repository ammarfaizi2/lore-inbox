Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbUKJNc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUKJNc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbUKJNc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:32:28 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:11234 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261773AbUKJNcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:32:24 -0500
Message-ID: <1100093543.41921867a2aef@imp2-q.free.fr>
Date: Wed, 10 Nov 2004 14:32:23 +0100
From: remi.colinet@free.fr
To: Sylvain <autofr@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about MM on x86
References: <64b1faec041110040117a80877@mail.gmail.com>
In-Reply-To: <64b1faec041110040117a80877@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 192.85.50.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mel Gorman documented the linux VM subsystem :

www.skynet.ie/~mel/projects/vm/

Otherwise, you could have a look at mm/page_alloc.c

Remi


Selon Sylvain <autofr@gmail.com>:

> Hi,
>
> I am interested in the way memory management is implemented on x86,
> specially the low level part.
>
> I search: where physical address are computed when a new Frame new to
> be allocated but I can't find out. (alogithm to find out the next
> frame free?? other the next frame to reuse??)
>
> Please, can somebody  familiar with the code point me to very prescise
> function, or give me some hint.
>
> Thanks in advance,
>
> Sylvain
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbREVAQy>; Mon, 21 May 2001 20:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbREVAQo>; Mon, 21 May 2001 20:16:44 -0400
Received: from t2.redhat.com ([199.183.24.243]:3581 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262543AbREVAQ3>; Mon, 21 May 2001 20:16:29 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <5.0.2.1.2.20010521163446.00a85fa0@pxwang.pobox.stanford.edu> 
In-Reply-To: <5.0.2.1.2.20010521163446.00a85fa0@pxwang.pobox.stanford.edu> 
To: Philip Wang <PXWang@stanford.edu>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, Dawson Engler <engler@cs.Stanford.EDU>
Subject: Re: [PATCH] drivers/mtd/mtdchar.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 May 2001 01:15:50 +0100
Message-ID: <22152.990490550@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PXWang@stanford.edu said:
>  There is a bug in mtdchar.c of not freeing memory on error paths.
> databuf  is allocated but not freed if copy_from_user fails.  The
> addition I made  was to kfree databuf before returning -EFAULT.
> Thanks!

Thankyou. I've now committed the fix to my tree and it'll be in the next 
merge with Linus, which should hopefully happen quite soon.

--
dwmw2



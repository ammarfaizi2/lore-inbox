Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbRFWO5r>; Sat, 23 Jun 2001 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263973AbRFWO5h>; Sat, 23 Jun 2001 10:57:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:37617 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263979AbRFWO5W>; Sat, 23 Jun 2001 10:57:22 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010623164218.D840@jaquet.dk> 
In-Reply-To: <20010623164218.D840@jaquet.dk> 
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add kmalloc checking to fs/jffs/intrep.c (245-ac16) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Jun 2001 15:57:16 +0100
Message-ID: <20304.993308236@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rasmus@jaquet.dk said:
>  The following patch adds some checks for kmalloc returning NULL to fs/
> jffs/intrep.c along with some way of getting that propagated back.
> Applies against 245ac16 and 246p5. These dereferences were reported by
> the Stanford team a way back. 

Fixed in my tree at about the same time the FTL code was, a month or so ago,
along with some more important bugs. I haven't yet got round to feeding the
updates to Linus - that's next on my list after the MTD stuff which is in
2.4.6. 

--
dwmw2



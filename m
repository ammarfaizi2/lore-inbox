Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270016AbRHQJYX>; Fri, 17 Aug 2001 05:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270024AbRHQJYN>; Fri, 17 Aug 2001 05:24:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270021AbRHQJYG>; Fri, 17 Aug 2001 05:24:06 -0400
Subject: Re: 2.4.9 does not compile [PATCH]
To: davem@redhat.com (David S. Miller)
Date: Fri, 17 Aug 2001 10:25:33 +0100 (BST)
Cc: bcrl@redhat.com, zippel@linux-m68k.org, aia21@cam.ac.uk, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 16, 2001 11:07:12 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xfsj-00071i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I would hope that it would warn: what if a is the maximum size that an
>    array can be and b is a value passed in from userland?  Most definately
>    not an expected result.
> 
> My example was poor, consider if 'b' was something like '100'
> or for some other reason you already know perfectly well
> the legal range of 'b' or 'a'.

Then the compiler will cast constants for you (and warn if they dont fit),
and you can use casts to make it clear you know the legal ranges

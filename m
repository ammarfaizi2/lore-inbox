Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270020AbRHQJTN>; Fri, 17 Aug 2001 05:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270031AbRHQJTE>; Fri, 17 Aug 2001 05:19:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22028 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270020AbRHQJS5>; Fri, 17 Aug 2001 05:18:57 -0400
Subject: Re: 2.4.9 does not compile [PATCH]
To: davem@redhat.com (David S. Miller)
Date: Fri, 17 Aug 2001 10:17:16 +0100 (BST)
Cc: zippel@linux-m68k.org, aia21@cam.ac.uk, tpepper@vato.org,
        f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 16, 2001 07:59:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Xfki-0006zw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wrong.  This is legal:
> 
> int test(unsigned long a, int b)
> {
> 	return min(a, b);
> }

> And the compiler will warn about it with your typeof version.

Good, because its absolutely bogus and you want people to be warned so they
fix the input types to fit in the output type, and are forced to think about
whether all cases actually fit

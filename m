Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUFGTgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUFGTgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUFGTgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:36:06 -0400
Received: from web51808.mail.yahoo.com ([206.190.38.239]:26217 "HELO
	web51808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265022AbUFGTfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:35:55 -0400
Message-ID: <20040607193325.24606.qmail@web51808.mail.yahoo.com>
Date: Mon, 7 Jun 2004 12:33:25 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Missing BKL in sys_chroot() for 2.6
To: Linus Torvalds <torvalds@osdl.org>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.58.0406071216060.1637@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clarification.

Phy


--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 7 Jun 2004, Phy Prabab wrote:
> >  
> > > see what the BKL 
> > 
> > What does BKL stand for?
> 
> "big kernel lock" aka the traditional global kernel
> lock that these days 
> is not actually used that much any more. When you
> see "lock_kernel()", 
> "unlock_kernel()", that's the BKL.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

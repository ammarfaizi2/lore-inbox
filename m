Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUFGTUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUFGTUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 15:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUFGTUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 15:20:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:39375 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265008AbUFGTSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 15:18:14 -0400
Date: Mon, 7 Jun 2004 12:18:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] Missing BKL in sys_chroot() for 2.6
In-Reply-To: <20040607191340.25304.qmail@web51803.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0406071216060.1637@ppc970.osdl.org>
References: <20040607191340.25304.qmail@web51803.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jun 2004, Phy Prabab wrote:
>  
> > see what the BKL 
> 
> What does BKL stand for?

"big kernel lock" aka the traditional global kernel lock that these days 
is not actually used that much any more. When you see "lock_kernel()", 
"unlock_kernel()", that's the BKL.

		Linus
